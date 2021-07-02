
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class ShowFeedback extends StatefulWidget {
  @override
  _ShowFeedbackState createState() => _ShowFeedbackState();
}

class _ShowFeedbackState extends State<ShowFeedback> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: null,
      appBar: AppBar(
        title: Text('Feedback Details'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('FeedbackforSystem').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final list = snapshot.data.docs;

          return  ListView.builder( padding: EdgeInsets.all(8.0),itemBuilder: (context,index){
            String long2 = list[index]['rating'].toString();
            return GestureDetector(
              child: Card(
                /* shape: StadiumBorder(			//Card with stadium border
                    side: BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                ),*/
                //elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.white70,

                child:ListTile(
                  title: Text(list[index]['Email'] + '\n' + long2,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  subtitle: Text(list[index]['feedback'],style: TextStyle(fontSize: 15,)),
                ),),
              // child: Text("First Name " + list[index]['FirstName'] + "Last Name " + list[index]['LastName']+ "Email " + list[index]['Email'] + "Mobile " + list[index]['Mobile'] + "User Role " + list[index]['urole']),
            );
          },
            itemCount: list.length,
          );
        },
      ),
    );
  }
}
