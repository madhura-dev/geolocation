import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var locationMessage = '';
  String latitude;
  String longitude;

  void getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lat = position.latitude;
    var long = position.longitude;

    // passing this to latitude and longitude strings
    latitude = "$lat";
    longitude = "$long";

    setState(() {
      locationMessage = "Latitude: $lat and Longitude: $long";
    });
  }

  @override
  Widget build(BuildContext context) {
    final ref = Firestore.instance.collection("GeoLocator");
   // TextEditingController DesController = TextEditingController();
   // TextEditingController ImgController = TextEditingController();
    Map<String, dynamic> blogToAdd;
    addData() {
      blogToAdd = {
        "latitude":latitude,
        "longitude": longitude,

      };
      ref.add(blogToAdd).whenComplete(() {
        Navigator.pop(context);

        print("added to the database");
      });
    }
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text("Firebase Geo locator"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                size: 45.0,
                color: Colors.white,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Get User Location",
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                locationMessage,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 05.0,
              ),

              // button for taking the location
              MaterialButton(
                color: Colors.white,
                onPressed: () {
                  getCurrentLocation();
                  addData();

                },
                child: Text("Get User Location"),
              ),
              StreamBuilder(
                  stream: ref.snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot>snapShot) {
                    if(snapShot.hasData){

                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapShot.data.documents.length,
                              itemBuilder: (context,index){
                                return InkWell(
                                  onTap: (){
                                    // Navigator.push(context, MaterialPageRoute(builder: (_)=>DisplayPage(dataList[index])));
                                  },
                                  child: Center(
                                    child: InkWell(
                                      onTap: (){
                                        // Navigator.push(context, MaterialPageRoute(builder: (_)=>SubType(typeName:snapShot.data.documents[index].data["typeName"])));
                                      },
                                      child: Card(
                                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Center(child: Text(snapShot.data.documents[index].data["longitude"],style: TextStyle(fontSize: 30),)),


                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },


                            ),

                          ],
                        ),
                      );
                    }
                    else{
                      return CircularProgressIndicator();
                    }

                    return Column(
                      children: [

                      ],
                    );
                  }
              ),

              // FlatButton(
              //   color: Colors.white,
              //   onPressed: () {
              //     googleMap();
              //   },
              //   child: Text("Open GoogleMap"),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}