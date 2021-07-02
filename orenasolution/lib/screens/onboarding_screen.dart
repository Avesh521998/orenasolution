import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orenasolution/start.dart';
import 'package:orenasolution/utilities/styles.dart';
import 'package:lottie/lottie.dart';
import 'package:orenasolution/application/app_sign_in/sign_in_page.dart';
import '../Intervieweepage.dart';
import '../mainadmin.dart';
import '../navigationdrawer.dart';
import 'login_screen.dart';


class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  bool isSigned = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if(user!=null){
        setState(() {
          isSigned = true;
        });
      }
      else{
        setState(() {
          isSigned = false;
        });
      }
    });
  }
  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xFF7B51D3),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                Color(0xFF3594DD),
                Color(0xFF4563DB),
                Color(0xFF5036D5),
                Color(0xFF5B16D0),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  height: 30.0,
                  child: FlatButton(
                    onPressed: () {
                      //isSigned == false ? LoginScreen() : LoginScreen();
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>isSigned == false ? LoginScreen():LoginScreen()));
                      if(isSigned == true){
                        DocumentReference documentReference = FirebaseFirestore.instance.collection("RegisterDetails").doc(FirebaseAuth.instance.currentUser.email);
                        documentReference.get().then((datasnapshot) {
                          if(datasnapshot.data()["urole"] == "Interviewer" && datasnapshot.data()["userstatus"] == "verified"){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>NavigationDrawer()));
                          }
                          if(datasnapshot.data()["urole"] == "Interviewee" && datasnapshot.data()["userstatus"] == "notverified"){
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => IntervieweePage()));
                          }
                          if(datasnapshot.data()["urole"] == "admin" && datasnapshot.data()["userstatus"] == "adminverified"){
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainAdmin()));
                          }
                          if(isSigned == false){
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
                          }
                        });
                      }
                      if(isSigned == false){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
                      }
                    },
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 600.0,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Container(
                                height: 300.0,
                                width: 300.0,
                                // child: Lottie.network('https://assets6.lottiefiles.com/packages/lf20_r8nda3zk.json')
                                child: Lottie.asset('assets/interview.json'),
                              ),
                            ),

                            SizedBox(height: 30.0),
                            Text(
                              'Connect people\naround the world',
                              style: kTitleStyle,
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'Get connected with the people who can test knowledge unbiasedly.',
                              style: kSubtitleStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Container(
                                height: 300.0,
                                width: 300.0,
                                //child: Lottie.network('https://assets5.lottiefiles.com/packages/lf20_YPllbK.json')
                                child: Lottie.asset('assets/abc.json'),
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Text(
                              'Live your life smarter\nwith us!',
                              style: kTitleStyle,
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'Practice more and more and get smarter day by day with us.',
                              style: kSubtitleStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Container(
                                  height: 300.0,
                                  width: 300.0,
                                  child: Lottie.network('https://assets5.lottiefiles.com/packages/lf20_YPllbK.json')
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Text(
                              'Get a new experience\n',
                              style: kTitleStyle,
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'Make "cracking job interviews" easier.',
                              style: kSubtitleStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage != _numPages - 1
                    ? Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomRight,
                    child: FlatButton(
                      onPressed: () {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Next',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 30.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                    : Text(''),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
        height: 50.0,
        width: double.infinity,
        color: Colors.white,
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
          },
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                'Get started',
                style: TextStyle(
                  color: Color(0xFF5B16D0),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      )
          : Text(''),
    );
  }
}