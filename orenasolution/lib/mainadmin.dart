import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orenasolution/addlanguage.dart';
import 'package:orenasolution/interviewer.dart';
import 'package:orenasolution/mainpage.dart';
import 'package:orenasolution/screens/login_screen.dart';
import 'package:orenasolution/showadminview.dart';
import 'package:orenasolution/showfeedback.dart';
import 'package:orenasolution/verifiedinterviewee.dart';
import 'package:orenasolution/verifiedinterviewer.dart';
class MainAdmin extends StatefulWidget {
  @override
  _MainAdminState createState() => _MainAdminState();
}

class _MainAdminState extends State<MainAdmin> {


  @override
  Widget build(BuildContext context) {
    _signOut() async{
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen()), (Route<dynamic> route) => false);
    }
    return Scaffold(

      appBar:  AppBar(
          title: Text("Welcome Admin"),
          backgroundColor: Colors.blue,
          actions: <Widget>[
           // IconButton(icon: Icon(Icons.videocam), onPressed: () => { }),
            IconButton(icon: Icon(Icons.logout), onPressed: () => {
                      _signOut()
            })
          ]
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      /*Color(0xFF73AEF5),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE5),*/
                      Color(0xffffffff),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),

              Container(
                height: double.infinity,
                margin: const EdgeInsets.all(30.0),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 50.0,
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(height: 20,width: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      FlatButton(
                        textColor: Colors.white,
                        height: 125.0,
                        minWidth: 125.0,
                        color: Color(0xFF61A4F1),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddLanguage()));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.add, color: Colors.white,),
                            ),
                            Text('Add Language', )
                          ],
                        ),
                      ),
                      SizedBox(width: 30.0),
                      FlatButton(
                        textColor: Colors.white,
                        height: 125.0,
                        minWidth: 125.0,
                        color: Color(0xFF61A4F1),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage()));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.person_add, color: Colors.white,),
                            ),
                            Text('Interviewer\n \t Request', )
                          ],
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 20,width: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        textColor: Colors.white,
                        height: 125.0,
                        minWidth: 125.0,
                        color:Color(0xFF61A4F1),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifiedInterviewee()));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.person_outline, color: Colors.white,),
                            ),
                            Text(' \t\t\t\t Show \n interviewee', )
                          ],
                        ),
                      ),
                      SizedBox(width: 30.0),
                      FlatButton(
                        textColor: Colors.white,
                        height: 125.0,
                        minWidth: 125.0,
                        color: Color(0xFF61A4F1),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifiedInterviewer()));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.person, color: Colors.white,),
                            ),
                            Text('\t\t\t\t Show \n interviewer', )
                          ],
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 20,width: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      FlatButton(
                        textColor: Colors.white,
                        height: 125.0,
                        minWidth: 125.0,
                        color: Color(0xFF61A4F1),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowFeedback()));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.rate_review, color: Colors.white,),
                            ),
                            Text('Show Rating', )
                          ],
                        ),
                      ),
                      SizedBox(width: 30.0),
                      FlatButton(
                        textColor: Colors.white,
                        height: 125.0,
                        minWidth: 125.0,
                        color: Color(0xFF61A4F1),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowAdminView()));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.calendar_today, color: Colors.white,),
                            ),
                            Text('\t  Interviewer\n \t Scheduled', )
                          ],
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 20,width: 20,),
                /*  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                          textColor: Colors.white,
                          height: 125.0,
                          minWidth: 125.0,
                          color: Colors.redAccent,
                          onPressed: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.email, color: Colors.white,),
                              ),
                              Text('EMAIL', )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),*/
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
