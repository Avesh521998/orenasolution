import 'package:flutter/material.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart';
import 'dart:io';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:orenasolution/intervieweefeedback.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'interviewerfeedback.dart';
class JoinMeetings extends StatefulWidget {
  @override
  _JoinMeetingsState createState() => _JoinMeetingsState();
}

class _JoinMeetingsState extends State<JoinMeetings> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController roomcontroller = TextEditingController();
  bool isVideoMuted = true;
  bool isAudioMuted = true;
  String username = '';
  String email = '';
  String currentText= '';
  joinmeeting() async{
    try{
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      Map<FeatureFlagEnum,bool> feautueflags = {FeatureFlagEnum.WELCOME_PAGE_ENABLED:false};
      if(Platform.isAndroid){
        feautueflags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      }
      else if(Platform.isIOS){
        feautueflags[FeatureFlagEnum.PIP_ENABLED] = false;
      }

      var options = JitsiMeetingOptions()
        ..room = roomcontroller.text
        ..userEmail = email
        ..userDisplayName = namecontroller.text == '' ? username : namecontroller.text
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted;
      //..featureFlags.addAll(feautueflags);
      // ..featureFlag = featureFlag;
      await JitsiMeet.joinMeeting(options);
    }catch(e){
      print("Error $e");
    }
    Navigator.push(context, MaterialPageRoute(builder: (context)=>IntervieweeFeedback()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text('Join Meeting'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 24,),
              Text("Room code",style: TextStyle(fontSize: 20)),
              SizedBox(height: 20,),
              PinCodeTextField(appContext: context,controller: roomcontroller,
                length: 6, autoDisposeControllers: false,animationType: AnimationType.fade,pinTheme: PinTheme(
                  shape: PinCodeFieldShape.underline,
                ),animationDuration: Duration(milliseconds: 300),onChanged: (value){},),
              SizedBox(height: 10,),
              TextField(

                controller: namecontroller,
                decoration: InputDecoration(border: OutlineInputBorder(),labelText: "Name (Leave if you want your username)"),
              ),
              SizedBox(height: 16,),
              CheckboxListTile(value: isVideoMuted, onChanged: (value){
                setState(() {
                  isVideoMuted = value;
                });
              },title: Text("Video Muted",style: TextStyle(fontSize: 18,color: Colors.black)),),
              SizedBox(height: 16,),
              CheckboxListTile(value: isAudioMuted, onChanged: (value){
                setState(() {
                  isAudioMuted = value;
                });
              },title: Text("Audio Muted",style: TextStyle(fontSize: 18,color: Colors.black)),),
              SizedBox(height: 20,),
              Text("of course you can customer your setting in the meeting",
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.center,),
              Divider(
                height: 48,
                thickness: 2.0,
              ),
              InkWell(
                onTap: ()=>joinmeeting(),
                child: Container(
                  width: double.maxFinite,
                  height: 64,
                  decoration: BoxDecoration(
                    gradient:  LinearGradient(colors: <Color>[
                      Color(0xFF478DE0),
                      Color(0xffeeee00)
                    ],
                    ),
                  ),
                  child: Center(
                    child: Text("Join",style: TextStyle(fontSize: 20,color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
