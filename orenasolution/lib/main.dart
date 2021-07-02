import 'package:firebase_core/firebase_core.dart';
import 'package:orenasolution/application/app_sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:orenasolution/screens/onboarding_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orena solutions',

      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),
      debugShowCheckedModeBanner: false,
      home:OnboardingScreen(),
    );
  }
}
