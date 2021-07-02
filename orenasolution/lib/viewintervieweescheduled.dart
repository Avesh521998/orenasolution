import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class ViewInterVieweeScheduled extends StatefulWidget {
  String role;
  String inter;
  String text;
  ViewInterVieweeScheduled({Key key, @required this.text}) :super(key: key);
  @override
  _ViewInterVieweeScheduledState createState() => _ViewInterVieweeScheduledState();
}

class _ViewInterVieweeScheduledState extends State<ViewInterVieweeScheduled> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: null,
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text('Meetings Scheduled'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('IntervieweeRequest').where('IntervieweeEmail',isEqualTo: FirebaseAuth.instance.currentUser.email).where('IntervieweeRequest',isEqualTo: 'approved').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final list = snapshot.data.docs;

          return  ListView.builder(
            padding: EdgeInsets.all(8.0),itemBuilder: (context,index){
            String titles = list[index]['Title'].toString();
            String froms = list[index]['From'].toString();
            String tos = list[index]['To'].toString();
            return GestureDetector(
              child: Card(
                color: Colors.white70,
                child:ListTile(

                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/true.png"), // no matter how big it is, it won't overflow
                  ),
                  title: Text(titles,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  subtitle: Text('From :' + '\t' + froms + '\n' + 'To :' + '\t' + tos),
                ),),
              );
          },
            itemCount: list.length,
          );
        },
      ),
    );
  }
}

