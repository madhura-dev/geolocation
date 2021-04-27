import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/DisplayPage.dart';
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
      print(latitude.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final ref = Firestore.instance.collection("GeoLocator");

    Map<String, dynamic> dataToAdd;
    addData() {
      dataToAdd  = {
        "latitude":latitude,
        "longitude": longitude,

      };
      ref.add(dataToAdd).whenComplete(() {

        print("added to the database");
      });
    }
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        centerTitle: true,
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

              MaterialButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>DisplayPage()));


                },
                child: Text("Check all Location"),
              ),



            ],
          ),
        ),
      ),
    );
  }
}