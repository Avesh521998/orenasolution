import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orenasolution/page/event_editing_page.dart';
import 'dart:io';
class Scheduled extends StatefulWidget {
  @override
  _ScheduledState createState() => _ScheduledState();
}

class _ScheduledState extends State<Scheduled> {
  String username,profile,email;
  bool dataisthere=false;
  File _image;
  EventEditingPage eventEditingPage;
  DateTimeRange dateRange;
  DateTime dateTime;
  @override
  Widget build(BuildContext context) {
   // ViewInterVieweeScheduled(text: FirebaseAuth.instance.currentUser.email,);
    return Scaffold(
      floatingActionButton: null,

      appBar: AppBar(
        title: Text('Approve Interviews'),
        leading: Icon(Icons.menu),
      ),
      body: StreamBuilder(
        //stream: FirebaseFirestore.instance.collection('IntervieweeRequest').doc(widget.role).collection('ScheduleDetails').snapshots(),
        // stream: FirebaseFirestore.instance.collection('IntervieweeRequest').doc(widget.role).collection('ScheduleDetails').snapshots(),
        // stream: FirebaseFirestore.instance.collection("IntervieweeRequest").doc(widget.role).collection('ScheduleDetails').snapshots(),
        stream: FirebaseFirestore.instance.collection('IntervieweeRequest').where('Email',isEqualTo: FirebaseAuth.instance.currentUser.email).where('IntervieweeRequest',isEqualTo: 'approved').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final list = snapshot.data.docs;
          return  ListView.builder( padding: EdgeInsets.all(8.0),itemBuilder: (context,index){
            return GestureDetector(
              onTap: (){
                //showDialogFunc(context,list[index]['FirstName'],list[index]['LastName'],list[index]['Email'],list[index]['Mobile'],list[index]['Password'],list[index]['urole'],list[index]['userstatus'],list[index]['profileurl'],list[index]['Experience']);
               // showDialogFuncion(context,list[index]['Email'],list[index]['IntervieweeEmail'],list[index]['IntervieweeRequest'],list[index]['IntervieweeTime'],list[index]['From'],list[index]['To'],list[index]['Title']);
              },
              child: Card(
                color: Colors.white70,
                child:ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/true.png"), // no matter how big it is, it won't overflow
                  ),
                  title: Text(list[index]['Title'] ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  subtitle: Text(list[index]['IntervieweeTime']+ '\n' + list[index]['IntervieweeEmail']),
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
