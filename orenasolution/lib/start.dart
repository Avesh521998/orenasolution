import 'package:flutter/material.dart';
import 'package:orenasolution/application/app_sign_in/sign_in_page.dart';
import 'package:orenasolution/application/app_sign_in/social_sign_in_button.dart';
import 'package:lottie/lottie.dart';
import 'package:orenasolution/screens/login_screen.dart';
import 'package:orenasolution/src/screens/login.dart';
import 'package:orenasolution/register.dart';
class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {

  navigateToLogin()async{

    Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
  }

  navigateToRegister()async{

    Navigator.push(context, MaterialPageRoute(builder: (context)=> Register()));
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(

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
        child: Column(
          children: <Widget>[
           Center(

              child: Container(
                  margin: EdgeInsets.only(top : 200.0),
                  height: 200.0,
                  width: 300.0,
                  child: Lottie.asset('assets/welcomepage.json'),
              ),
            ),
            SizedBox(height: 150.0),

           /* Container(
              height: 100,
              child: Image(image: AssetImage("assets/start.jpg"),
                fit: BoxFit.contain,
              ),
            ),*/

            RichText(

                text: TextSpan(
                    text: 'Welcome to ', style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),

                    children: <TextSpan>[
                      TextSpan(
                          text: 'Orena Solutions', style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color:Colors.orange)
                      )
                    ]
                )
            ),
            SizedBox(height: 10.0),

            Text('',style: TextStyle(color:Colors.white),),

            SizedBox(height: 30.0),


           Row( mainAxisAlignment: MainAxisAlignment.center,

              children: <Widget>[

                RaisedButton(
                    padding: EdgeInsets.only(left:30,right:30),

                    onPressed: navigateToLogin,
                    child: Text('LOGIN',style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.orange
                ),

                SizedBox(width:20.0),

                RaisedButton(
                    padding: EdgeInsets.only(left:30,right:30),

                    onPressed: navigateToRegister,
                    child: Text('REGISTER',style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.orange
                ),
              ],
            ),
          ],
        ),
      ),

    );
  }
}