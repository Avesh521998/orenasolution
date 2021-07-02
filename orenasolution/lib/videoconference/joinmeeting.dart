import 'package:flutter/material.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart';
import 'dart:io';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:orenasolution/interviewerfeedback.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';
class JoinMeeting extends StatefulWidget {
  @override
  _JoinMeetingState createState() => _JoinMeetingState();
}

class _JoinMeetingState extends State<JoinMeeting> {
  String code = '';
  String a = '';
  void initState() {
    super.initState();
    setState(() {
      code = Uuid().v1().substring(0,6);
    });
  }
  createcode(){
    setState(() {
      code = Uuid().v1().substring(0,6);
    });
  }
  sharecode() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String a = prefs.getString('stringValue');
    return a;
  }
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
    Navigator.push(context, MaterialPageRoute(builder: (context)=>InterviewerFeedback()));
  }
  @override
  Widget build(BuildContext context) {
    roomcontroller.text = a;
    return Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                /*Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Code: ",style: TextStyle(fontSize: 30)),
                    Text(code,style: TextStyle(fontSize: 20,color: Colors.black))
                  ],
                ),*/
                SizedBox(height: 24,),
                Text("Room code",style: TextStyle(fontSize: 20)),
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
                      child: Text("Join Meeting",style: TextStyle(fontSize: 20,color: Colors.white)),
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
