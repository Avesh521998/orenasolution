import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orenasolution/calenderrange.dart';
import 'package:orenasolution/screens/login_screen.dart';
import 'package:orenasolution/videoconference.dart';
import 'Scheduled.dart';
import 'acceptrequest.dart';
import 'feedbacksystem.dart';
import 'interviewer.dart';
import 'interviewercalender.dart';
import 'interviewerhomepage.dart';
import 'dart:io';

import 'models/message_model.dart';
class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  double value = 0;
  int page=0;
 // File _image;
  String username,profile;
  bool dataisthere=false;
  String fname,lname;
  List pageoptions = [
    // VideoConference(),
    // ProfileScreen()
    InterviewerHomepage(),
    AcceptRequest(),
    Scheduled(),
    VideoConference(),
    Interviewer(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  //  getuserdata();
  }


  @override
  Widget build(BuildContext context) {

    _signOut() async{
      await FirebaseAuth.instance.signOut();
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()),);
     // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen()), (Route<dynamic> route) => false);
    }
    String emails = FirebaseAuth.instance.currentUser.email;
    getuserdata() async{
      DocumentSnapshot userdoc = await FirebaseFirestore.instance.doc(FirebaseAuth.instance.currentUser.email).get();
      setState(() {
        username = userdoc.data()['FirstName'];
        profile= userdoc.data()['profileurl'];
        dataisthere = true;
        // return username;
      });
    }
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue[400],
                  Colors.blue[800],
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              )
            ),
          ),
          SafeArea(
            child: Container(
           width: 200.0,
           padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                DrawerHeader(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        child: ClipOval(
                          child: Image.asset(
                            'assets/logo.png',
                            fit: BoxFit.cover,
                            width:300,
                            height: 300,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0,),
                      Text(emails,style: TextStyle(color: Colors.white,fontSize: 15.0),),
                    ],
                  ),
                ),
                Expanded(
                    child: ListView(
                      children: [
                        ListTile(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>NavigationDrawer()));
                          },
                          leading: Icon(Icons.home,color: Colors.white,),
                          title: Text("Home",style: TextStyle(color: Colors.white),),
                        ),
                        ListTile(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>InterviewerCalender()));
                          },
                          leading: Icon(Icons.calendar_today_outlined,color: Colors.white,),
                          title: Text("Calender",style: TextStyle(color: Colors.white),),
                        ),
                        ListTile(
                          onTap: ()=>{
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllScheduledinPdf()))
                          },
                          leading: Icon(Icons.receipt_long_rounded,color: Colors.white,),
                          title: Text("Your Report",style: TextStyle(color: Colors.white),),
                        ),
                        ListTile(
                          onTap: ()=>{
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>FeedbackSystem()))
                          },
                          leading: Icon(Icons.feedback,color: Colors.white,),
                          title: Text("Feedback",style: TextStyle(color: Colors.white),),
                        ),
                        ListTile(
                          onTap: (){
                            _signOut();
                          },
                          leading: Icon(Icons.logout,color: Colors.white,),
                          title: Text("Logout",style: TextStyle(color: Colors.white),),
                        )
                      ],
                    ))
              ],
            ),
          ),
          ),
          TweenAnimationBuilder(tween: Tween<double>(begin: 0,end: value), duration: Duration(milliseconds: 500),curve: Curves.easeInExpo, builder: (_,double val,__){
            return(Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..setEntry(0, 3, 200*val)
              ..rotateY((pi/6)*val),
              child: Scaffold(
                backgroundColor: Colors.grey[250],
                bottomNavigationBar: BottomNavigationBar(
                  backgroundColor: Colors.white,
                  selectedItemColor: Colors.blue,
                  // selectedLabelStyle: mystyle(17,Colors.blue),
                  selectedLabelStyle: TextStyle(fontSize: 17.0,fontFamily: 'Family Name',color:Colors.blue),
                  unselectedItemColor: Colors.black,
                  // unselectedLabelStyle: mystyle(17,Colors.black),
                  unselectedLabelStyle: TextStyle(fontSize: 17.0,color:Colors.black),
                  currentIndex: page,
                  onTap: (index){
                    setState(() {
                      page=index;
                    });
                  },
                  items: [
                    BottomNavigationBarItem(
                        title: Text('Home'),
                        icon: Icon(Icons.home,size: 25,)
                    ),
                    BottomNavigationBarItem(
                        title: Text('Request'),
                        icon: Icon(Icons.schedule,size: 25,)
                    ),
                    BottomNavigationBarItem(
                        title: Text('Schedule'),
                        icon: Icon(Icons.calendar_today,size: 25,)
                    ),
                    BottomNavigationBarItem(
                        title: Text('Video call'),
                        icon: Icon(Icons.video_call,size: 25,)
                    ),
                    BottomNavigationBarItem(
                        title: Text('Profile'),
                        icon: Icon(Icons.person,size: 25,)
                    )
                  ],
                ),
                body: pageoptions[page],
              ),
            ));
          }),
          GestureDetector(
            onHorizontalDragUpdate: (e){
              if(e.delta.dx>0){
                setState(() {
                  value = 1;
                });
              }
              else{
                setState(() {
                  value = 0;
                });
              }
            },
           /* onTap: (){
              setState(() {
                value == 0 ? value == 1 : value = 0;
              });
            },*/
          )
        ],
      ),
    );
  }

}
