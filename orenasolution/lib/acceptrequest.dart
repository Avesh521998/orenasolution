import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:intl/intl.dart';
import 'package:orenasolution/date_range_picker_widget.dart';
import 'package:orenasolution/page/event_editing_page.dart';
import 'package:orenasolution/screens/login_screen.dart';
import 'package:orenasolution/viewintervieweescheduled.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'buttonheaderwidget.dart';
import 'constants.dart';
import 'models/message_model.dart';
class AcceptRequest extends StatefulWidget {
  String role;
  String inter;
  String intreviewe;
  AcceptRequest({Key key, @required this.intreviewe}) :super(key: key);
  @override
  _AcceptRequestState createState() => _AcceptRequestState();
}

class _AcceptRequestState extends State<AcceptRequest> {
  String username,profile,email;
  bool dataisthere=false;
  File _image;
  EventEditingPage eventEditingPage;
  DateTimeRange dateRange;
  DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    ViewInterVieweeScheduled(text: FirebaseAuth.instance.currentUser.email,);
    return Scaffold(
      floatingActionButton: null,

      appBar: AppBar(
        title: Text('Interviewee Request'),
        leading: Icon(Icons.menu),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('IntervieweeRequest').where('Email',isEqualTo: FirebaseAuth.instance.currentUser.email).where('IntervieweeRequest',isEqualTo: 'pending').snapshots(),
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
                showDialogFuncion(context,list[index]['Email'],list[index]['IntervieweeEmail'],list[index]['IntervieweeRequest'],list[index]['IntervieweeTime'],list[index]['From'],list[index]['To'],list[index]['Title']);
              },
              child: Card(
                color: Colors.white70,
                child:ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/pendings.jpg"), // no matter how big it is, it won't overflow
                  ),
                  title: Text(list[index]['Title'] ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  subtitle: Text(list[index]['IntervieweeTime']+ '\n' + list[index]['IntervieweeEmail']),
                ),),
              );
          },
            itemCount: list.length,
          );
        },
      ),
    );
  }


  showDialogFuncion(BuildContext context, email,intervieweeEmail,intervieweeRequest,intervieweeTime,from,to,title) {
    String valueChoose;
    notapprove() async{
      String sts = 'notapproved';
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String a = preferences.getString("key");
      DocumentReference  documentReference = FirebaseFirestore.instance.collection("IntervieweeRequest").doc(a);
      Map<String, dynamic> students = {
        "Title": title,
        "From" : from,
        "To": to,
        "IntervieweeEmail": intervieweeEmail,
        "Email":email,
        "IntervieweeRequest": sts,
        "IntervieweeTime":intervieweeTime,
      };
      documentReference.set(students).whenComplete(() {
        print("Request send");
      });
    }
    updateData() async{
      String sts = 'approved';
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String a = preferences.getString("key");
     DocumentReference documentReference = FirebaseFirestore.instance.collection("IntervieweeRequest").doc(a);
      Map<String, dynamic> students = {
        "Title": title,
        "From" : from,
        "To": to,
        "IntervieweeEmail": intervieweeEmail,
        "Email":email,
        "IntervieweeRequest": sts,
        "IntervieweeTime":intervieweeTime,
        "requestid": a,
      };
      documentReference.set(students).whenComplete(() {
        print("Request send");
      });
    }
    return showDialog(
        context: context,
        builder: (context){
          return Center(
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                padding: EdgeInsets.only(top:10),
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                width: MediaQuery.of(context).size.width * 0.9,
                height: 540,
               child: StreamBuilder(
                 stream: FirebaseFirestore.instance.collection("RegisterDetails").where('Email',isEqualTo: intervieweeEmail).snapshots(),
                 builder: (context,snapshot){
                   //       email = FirebaseAuth.instance.currentUser.email;
                   if(snapshot.hasData){
                     return Container(
                       child: ListView.builder(
                         itemCount: snapshot.data.docs.length,
                         itemBuilder: (BuildContext context, int index) {
                           DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
                           return GestureDetector(
                             child: Padding(
                                 padding: EdgeInsets.all(10.0),
                                 child: Column(
                                   children: <Widget>[
                                     Center(
                                       child: Container(
                                         child: CircleAvatar(
                                           radius: 55,
                                           backgroundColor: Color(0xff33eeff),
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
                                       ),
                                     ),
                                     SizedBox(height: 6.0),
                                     Column(
                                       children: [
                                         Center(
                                           child: Text(
                                             documentSnapshot["FirstName"],
                                             textAlign: TextAlign.center,
                                             style: TextStyle(
                                               color: Colors.black,
                                               fontSize: 16.0,
                                               fontWeight: FontWeight.w700,
                                             ),
                                           ),
                                         ),
                                         // SizedBox(height: 25.0),
                                         Card(
                                           color: Color(0xFF2196F3),
                                           shape: RoundedRectangleBorder(
                                             side: BorderSide(color: Colors.lime, width: 2),
                                             borderRadius: BorderRadius.circular(10),
                                           ),
                                           //  margin: EdgeInsets.all(20.0),
                                           child: Column(
                                             children: [
                                               SizedBox(height: 25.0),
                                               Row(
                                                 // margin: const EdgeInsets.only(top: 10.0),
                                                 children: [
                                                   Container(
                                                     margin: const EdgeInsets.only(left: 30.0),
                                                     child: Text(
                                                       'First Name',
                                                       textAlign: TextAlign.start,
                                                       style: TextStyle(
                                                         color: Colors.white,
                                                         fontSize: 16.0,
                                                         fontWeight: FontWeight.w900,
                                                       ),
                                                     ),
                                                   ),
                                                   Container(
                                                     margin: const EdgeInsets.only(left: 100.0),
                                                     child: Text(
                                                       documentSnapshot['FirstName'],
                                                       textAlign: TextAlign.end,
                                                       style: TextStyle(
                                                         color: Colors.white,
                                                         fontSize: 16.0,
                                                         fontWeight: FontWeight.w900,
                                                       ),
                                                     ),
                                                   )
                                                 ],
                                               ),
                                               SizedBox(height: 15.0,),
                                               Row(
                                                 // margin: const EdgeInsets.only(top: 10.0),
                                                 children: [
                                                   Container(
                                                     margin: const EdgeInsets.only(left: 30.0),
                                                     child: Text(
                                                       'Last Name',
                                                       textAlign: TextAlign.start,
                                                       style: TextStyle(
                                                         color: Colors.white,
                                                         fontSize: 16.0,
                                                         fontWeight: FontWeight.w900,
                                                       ),
                                                     ),
                                                   ),
                                                   Container(
                                                     margin: const EdgeInsets.only(left: 100.0),
                                                     child: Text(
                                                       documentSnapshot['LastName'],
                                                       textAlign: TextAlign.start,
                                                       style: TextStyle(
                                                         color: Colors.white,
                                                         fontSize: 16.0,
                                                         fontWeight: FontWeight.w900,
                                                       ),
                                                     ),
                                                   ),

                                                 ],
                                               ),
                                               SizedBox(height: 15.0,),
                                               Row(
                                                 // margin: const EdgeInsets.only(top: 10.0),
                                                 children: [
                                                   Container(
                                                     margin: const EdgeInsets.only(left: 30.0),
                                                     child: Text(
                                                       'Email',
                                                       textAlign: TextAlign.start,
                                                       style: TextStyle(
                                                         color: Colors.white,
                                                         fontSize: 16.0,
                                                         fontWeight: FontWeight.w900,
                                                       ),
                                                     ),
                                                   ),
                                                   Flexible(child: Container(
                                                     margin: const EdgeInsets.only(left: 100.0),
                                                     child: Text(
                                                       documentSnapshot['Email'],
                                                       textAlign: TextAlign.start,
                                                       style: TextStyle(
                                                         color: Colors.white,
                                                         fontSize: 16.0,
                                                         fontWeight: FontWeight.w900,
                                                       ),
                                                     ),
                                                   ),
                                                   ),
                                                 ],
                                               ),
                                               SizedBox(height: 15.0,),
                                               Row(
                                                 // margin: const EdgeInsets.only(top: 10.0),
                                                 children: [
                                                   Container(
                                                     margin: const EdgeInsets.only(left: 30.0),
                                                     child: Text(
                                                       'Mobile',
                                                       textAlign: TextAlign.start,
                                                       style: TextStyle(
                                                         color: Colors.white,
                                                         fontSize: 16.0,
                                                         fontWeight: FontWeight.w900,
                                                       ),
                                                     ),
                                                   ),
                                                   Container(
                                                     margin: const EdgeInsets.only(left: 100.0),
                                                     child: Align(
                                                       alignment: Alignment.centerRight,
                                                       child: Text(
                                                         documentSnapshot['Mobile'],
                                                         textAlign: TextAlign.start,
                                                         style: TextStyle(
                                                           color: Colors.white,
                                                           fontSize: 16.0,
                                                           fontWeight: FontWeight.w900,
                                                         ),
                                                       ),
                                                     ),
                                                   )
                                                 ],
                                               ),
                                               SizedBox(height: 15.0,),
                                               SizedBox(height: 25.0),
                                             ],
                                           ),
                                         ),
                                       ],
                                     ),
                                     Card(
                                       color: Color(0xFF2196F3),
                                       shape: RoundedRectangleBorder(
                                         side: BorderSide(color: Colors.lime, width: 2),
                                         borderRadius: BorderRadius.circular(10),
                                       ),
                                       child: Column(
                                         children: [
                                           SizedBox(height: 25.0),
                                           Row(
                                             // margin: const EdgeInsets.only(top: 10.0),
                                             children: [
                                               Container(
                                                 margin: const EdgeInsets.only(left: 30.0),
                                                 child: Text(
                                                   'Title',
                                                   textAlign: TextAlign.start,
                                                   style: TextStyle(
                                                     color: Colors.white,
                                                     fontSize: 16.0,
                                                     fontWeight: FontWeight.w900,
                                                   ),
                                                 ),
                                               ),
                                               Container(
                                                 margin: const EdgeInsets.only(left: 100.0),
                                                 child: Text(
                                                   title,
                                                   textAlign: TextAlign.end,
                                                   style: TextStyle(
                                                     color: Colors.white,
                                                     fontSize: 16.0,
                                                     fontWeight: FontWeight.w900,
                                                   ),
                                                 ),
                                               )
                                             ],
                                           ),
                                           SizedBox(height: 15.0,),
                                           Row(
                                             children: [
                                               Container(
                                                 margin: const EdgeInsets.only(left: 30.0),
                                                 child: Text(
                                                   'Time',
                                                   textAlign: TextAlign.start,
                                                   style: TextStyle(
                                                     color: Colors.white,
                                                     fontSize: 16.0,
                                                     fontWeight: FontWeight.w900,
                                                   ),
                                                 ),
                                               ),
                                               Container(
                                                 margin: const EdgeInsets.only(left: 60.0),
                                                 child: Text(
                                                   intervieweeTime,
                                                   textAlign: TextAlign.start,
                                                   style: TextStyle(
                                                     color: Colors.white,
                                                     fontSize: 16.0,
                                                     fontWeight: FontWeight.w900,
                                                   ),
                                                 ),
                                               ),
                                             ],
                                           ),
                                           SizedBox(height: 25.0),
                                         ],
                                       ),
                                     ),
                                     Row(
                                       children: [
                                         Container(
                                           //margin: const EdgeInsets.only(left: 30.0),
                                           child: FloatingActionButton.extended(
                                             onPressed: () {
                                               notapprove();
                                               Navigator.pop(context);
                                             },
                                             label: const Text('Not Approve'),
                                             icon: const Icon(Icons.thumb_down),
                                             backgroundColor: Colors.pink,
                                           ),
                                         ),
                                         Container(
                                           margin: const EdgeInsets.only(left: 10.0),
                                           child: FloatingActionButton.extended(
                                             onPressed: () {
                                               updateData();
                                               Navigator.pop(context);
                                             },
                                             label: const Text('Approve'),
                                             icon: const Icon(Icons.thumb_up),
                                             backgroundColor: Color(0xFF42A5F5),
                                           ),
                                         ),

                                       ],
                                     ),
                                   ],
                                 )
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
              ),
            ),
          );
        }
    );
  }
}
