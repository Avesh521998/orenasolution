import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CreateMeeting extends StatefulWidget {
  @override
  _CreateMeetingState createState() => _CreateMeetingState();
}

class _CreateMeetingState extends State<CreateMeeting> {
  String code = '';
  /*createcode(){
    setState(() {
      code = Uuid().v1().substring(0,6);
    });
  }*/
  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      code = Uuid().v1().substring(0,6);
    });
    prefs.setString('stringValue', code);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text('Create a code and share it with your friends',style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Code: ",style: TextStyle(fontSize: 30)),
                      Text(code,style: TextStyle(fontSize: 20,color: Colors.purple))
                    ],
                  ),
                  SizedBox(height: 25,),
                  InkWell(
                    onTap: ()=>addStringToSF(),
                    child: Container(
                      width: MediaQuery.of(context).size.width/2,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient:  LinearGradient(colors: <Color>[
                          Color(0xFF478DE0),
                          Color(0xffeeee00)
                        ],
                        ),
                      ),
                      child: Center(
                        child: Text("Create Code",style: TextStyle(fontSize: 20,color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
