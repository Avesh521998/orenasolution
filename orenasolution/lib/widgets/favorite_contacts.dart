import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:orenasolution/models/message_model.dart';
import 'package:orenasolution/screens/chat_screen.dart';
import 'package:orenasolution/models/message_model.dart';
import 'package:orenasolution/selectedinterviewerdata.dart';
import 'package:transparent_image/transparent_image.dart';
import 'dart:io';

import '../NavBar.dart';


class FavoriteContacts extends StatefulWidget {
  @override
  _FavoriteContactsState createState() => _FavoriteContactsState();
}

class _FavoriteContactsState extends State<FavoriteContacts> {
  String username, profileurl,email;
  File _image;
  bool dataisthere=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserdata();
  }
  getuserdata() async{
    DocumentSnapshot userdoc = await usercollection.doc(FirebaseAuth.instance.currentUser.uid).get();
    setState(() {
      username = userdoc.data()['username'];
      dataisthere = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text('Welcome'),
      ),
     // backgroundColor: Colors.blue,
      drawer: NavBar(),
      body:Container(
        child: SingleChildScrollView(
          child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Interviewers',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection("RegisterDetails").where('urole',isEqualTo: 'Interviewer').where('userstatus',isEqualTo: 'verified').snapshots(),
                builder: (context,snapshot){
                  email = FirebaseAuth.instance.currentUser.email;
                  if(snapshot.hasData){
                    return Container(
                      height: 150.0,
                      child: ListView.builder(
                        padding: EdgeInsets.only(left: 10.0),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
                          return GestureDetector(
                            onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectedInterviewerData(role:documentSnapshot["Email"]))),
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                children: <Widget>[

                                  SizedBox(height: 5.0),
                                  CircleAvatar(
                                    radius: 35,
                                    backgroundColor: Color(0xff476cfb),
                                    child: ClipOval(
                                      child: new SizedBox(
                                        width: 100.0,
                                        height: 100.0,
                                        child: (_image!=null)?Image.file(
                                          _image,
                                          fit: BoxFit.fill,
                                        ):Image.network(
                                          documentSnapshot["profileurl"],
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 6.0),
                                  Text(
                                    documentSnapshot["FirstName"],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  else{
                    return Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              Text('Pending Requests',style: TextStyle(fontWeight: FontWeight.bold),),
              Card(
                color: Color(0xFF2196F3),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.lime, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  height: 150.0,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('IntervieweeRequest').where('IntervieweeEmail',isEqualTo: FirebaseAuth.instance.currentUser.email).where('IntervieweeRequest',isEqualTo: 'pending').snapshots(),
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
                        String status = list[index]['IntervieweeRequest'].toString();
                        return GestureDetector(
                          child: Card(
                            color: Colors.white70,
                            child:ListTile(
                              leading: CircleAvatar(
                                backgroundImage: AssetImage("assets/images/pending.png"), // no matter how big it is, it won't overflow
                              ),
                              title: Text(titles,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                              subtitle: Text('From :' + '\t' + froms + '\n' + 'To :' + '\t' + tos+ '\n' + 'Status :' + '\t' + status,style: TextStyle(fontWeight: FontWeight.bold),),

                            ),
                          ),
                        );
                      },
                        itemCount: list.length,
                      );
                    },
                  ),),
              ),
              Text('Not Approved Status',style: TextStyle(fontWeight: FontWeight.bold),),
              Card(
                color: Color(0xFF2196F3),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.lime, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  height: 200.0,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('IntervieweeRequest').where('IntervieweeEmail',isEqualTo: FirebaseAuth.instance.currentUser.email).where('IntervieweeRequest',isEqualTo: 'notapproved').snapshots(),
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
                        String status = list[index]['IntervieweeRequest'].toString();
                        return GestureDetector(
                          child: Card(
                            color: Colors.white70,
                            child:ListTile(
                              leading: CircleAvatar(
                                backgroundImage: AssetImage("assets/images/cross.jpg"), // no matter how big it is, it won't overflow
                              ),
                              title: Text(titles,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                              subtitle: Text('From :' + '\t' + froms + '\n' + 'To :' + '\t' + tos +  '\n' +'Status :' + '\t' + status,style: TextStyle(fontWeight: FontWeight.bold),),
                            ),
                          ),
                        );
                      },
                        itemCount: list.length,
                      );
                    },
                  ),),
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }
}
