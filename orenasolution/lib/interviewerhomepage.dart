import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'constants.dart';
class InterviewerHomepage extends StatefulWidget {
  @override
  _InterviewerHomepageState createState() => _InterviewerHomepageState();
}

class _InterviewerHomepageState extends State<InterviewerHomepage> {
  @override
  Widget build(BuildContext context) {
    File _image;
    return Scaffold(
      floatingActionButton: null,
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text('Scheduled Time-slots'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('InterviewerScheduleDetails').doc(FirebaseAuth.instance.currentUser.email).collection('ScheduleDetails').snapshots(),
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
            String froms = list[index]['From'].toDate().toString();
            String tos = list[index]['To'].toDate().toString();
            return GestureDetector(
              child: Card(
                color: Colors.white70,
                child:ListTile(
                  title: Text(titles,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  subtitle: Text('From :' + '\t' + froms + '\n' + 'To :' + '\t' + tos),
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
