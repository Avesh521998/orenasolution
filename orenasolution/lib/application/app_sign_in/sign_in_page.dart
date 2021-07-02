import 'package:orenasolution/application/app_sign_in/sign_in_button.dart';
import 'package:orenasolution/application/app_sign_in/social_sign_in_button.dart';
import 'package:orenasolution/common_widgets/custom_raised_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('orena solutions'),
        elevation: 2.0,
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: _buildContent(),
    );
  }
  Widget _buildContent(){
    return Container(
      padding: EdgeInsets.all(10.0),
      color: Colors.blue,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Image(image: NetworkImage('https://orena.solutions/img/bg-theme/training_vector_2.png'),),
          Text('Sign In',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 35.0),


          SocialSignInButton(
            assetName: 'assets/google-logo.png',
            text: 'Sign in with Google',
            textColor: Colors.black87,
            color: Colors.white,
            onPressed: (){},
          ),
          SizedBox(height: 8.0),


          SocialSignInButton(
            assetName: 'assets/facebook-logo.png',
            text: 'Sign in with Facebook',
            textColor: Colors.white,
            color: Color(0xFF334D92),
            onPressed: (){},
          ),
          SizedBox(height: 8.0),



          SignInButton(

              text: 'Sign in with Email',
              textColor: Colors.white,
              color: Colors.teal,
              onPressed: (){}
          ),
          SizedBox(height: 8.0),
          Text('OR',
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0,fontStyle: FontStyle.italic,color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.0),
          SignInButton(
              text: 'Go with Anonymous',
              textColor: Colors.black87,
              color: Colors.limeAccent,
              onPressed: (){}
          ),
          SizedBox(height: 8.0),
        ],
      ),
    );

  }
}
