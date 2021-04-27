
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class DisplayPage extends StatefulWidget {
  @override
  _DisplayPageState createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  final ref = Firestore.instance.collection("GeoLocator");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text("Display Location"),
      ),
      body:  StreamBuilder(
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
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(child: Column(
                                        children: [
                                          Text("Longitude",style: TextStyle(fontSize: 20,color: Colors.grey),),
                                          Text(snapShot.data.documents[index].data["longitude"],style: TextStyle(fontSize: 30),),
                                        ],
                                      )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(child: Column(
                                        children: [
                                          Text("Latitude",style: TextStyle(fontSize: 20,color: Colors.grey),),
                                          Text(snapShot.data.documents[index].data["latitude"],style: TextStyle(fontSize: 30),),
                                        ],
                                      )),
                                    ),


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


          }
      ),
    );
  }
}