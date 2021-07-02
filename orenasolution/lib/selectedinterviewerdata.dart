import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:intl/intl.dart';
import 'package:orenasolution/acceptrequest.dart';
import 'package:orenasolution/date_range_picker_widget.dart';
import 'package:orenasolution/page/event_editing_page.dart';
import 'package:orenasolution/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'buttonheaderwidget.dart';
import 'models/message_model.dart';
class SelectedInterviewerData extends StatefulWidget {
  String role;
  SelectedInterviewerData({Key key, @required this.role}) :super(key: key);
  @override
  _SelectedInterviewerDataState createState() => _SelectedInterviewerDataState();
}

class _SelectedInterviewerDataState extends State<SelectedInterviewerData> {
  String username,profile,email;
  bool dataisthere=false;
  File _image;
  EventEditingPage eventEditingPage;
  DateTimeRange dateRange;
  DateTime dateTime;



  String getText() {
    if (dateTime == null) {
      return 'Select DateTime';
    } else {
      return DateFormat('MM/dd/yyyy HH:mm').format(dateTime);
    }
  }
  Future pickDateTime(BuildContext context) async {
    final date = await pickDate(context);
    if (date == null) return;

    final time = await pickTime(context);
    if (time == null) return;

    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  Future<DateTime> pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: dateTime ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return null;

    return newDate;
  }

  Future<TimeOfDay> pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: dateTime != null
          ? TimeOfDay(hour: dateTime.hour, minute: dateTime.minute)
          : initialTime,
    );

    if (newTime == null) return null;

    return newTime;
  }



  @override
  Widget build(BuildContext context) {
    email = FirebaseAuth.instance.currentUser.email;
    String image;
    return Scaffold(
      backgroundColor: Colors.grey[250],

      body: dataisthere == true ? Center(
        child: CircularProgressIndicator(),
      ):Stack(
        children: [
          ClipPath(
            clipper: OvalBottomBorderClipper(),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height/3.0,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xff33eeff),
                      Color(0xffffffff),
                    ],
                  )
              ),
            ),
          ),
         // Text(widget.role),

          StreamBuilder(
            stream: FirebaseFirestore.instance.collection("RegisterDetails").where('Email',isEqualTo: widget.role).snapshots(),
            builder: (context,snapshot){
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
                                  margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height/5.1,
                                  ),
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
                            // image = documentSnapshot["profileurl"],
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
                                        Row(
                                          // margin: const EdgeInsets.only(top: 10.0),
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(left: 30.0),
                                              child: Text(
                                                'Experience',
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
                                                  documentSnapshot['Experience'],
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
                              child: SizedBox(height: 150.0,
                                child: StreamBuilder(
                                  stream: FirebaseFirestore.instance.collection('InterviewerScheduleDetails').doc(widget.role).collection('ScheduleDetails').snapshots(),
                                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    final list = snapshot.data.docs;
                                    return  ListView.builder(
                                      padding: EdgeInsets.all(8.0),itemBuilder: (context,index){
                                      String email = list[index]['Email'].toString();
                                      String titles = list[index]['Title'].toString();
                                      String froms = list[index]['From'].toDate().toString();
                                      String tos = list[index]['To'].toDate().toString();
                                      return GestureDetector(
                                        onTap: (){
                                          showDialogFunc(context,email,titles,froms,tos);
                                        },
                                        child: Card(
                                          color: Colors.white70,
                                          child:ListTile(
                                            title: Text(titles,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                            subtitle: Text('From :' + '\t' + froms + '\n' + 'To :' + '\t' + tos),
                                          ),),
                                        // child: Text("First Name " + list[index]['FirstName'] + "Last Name " + list[index]['LastName']+ "Email " + list[index]['Email'] + "Mobile " + list[index]['Mobile'] + "User Role " + list[index]['urole']),
                                      );
                                    },
                                      itemCount: list.length,
                                    );
                                  },
                                ),),),
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
        ],
      ),
    );
  }
  showDialogFunc(BuildContext context,email,titles,froms,tos){
    String valueChoose;
    updateData() async{
      String sts = 'pending';
      DocumentReference  documentReference = FirebaseFirestore.instance.collection("IntervieweeRequest").doc();
      Map<String, dynamic> students = {
        "Title": titles,
        "From" : froms,
        "To": tos,
        "IntervieweeEmail": FirebaseAuth.instance.currentUser.email,
        "Email":email,
        "IntervieweeRequest": sts,
        "IntervieweeTime":getText(),
        "requestid": documentReference.id,
      };
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("key",documentReference.id);
     // Get.to(AcceptRequest());
      documentReference.set(students).whenComplete(() {
        print("Request send") ;
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
                height: 400,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("RegisterDetails").where('Email',isEqualTo: widget.role).snapshots(),
                    builder: (context,snapshot){
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
                                                documentSnapshot["FirstName"] + "  " + documentSnapshot["LastName"],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Center(
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
                                              height: 320,
                                              child: Column(
                                                children: [
                                                  Text('Interviewer Mail : '+ email),
                                                  SizedBox(height: 5.0,),
                                                  Text('Title :' + titles),
                                                  SizedBox(height: 5.0,),
                                                  Text('From : '+ froms),
                                                  SizedBox(height: 5.0,),
                                                  Text('To : '+ tos),
                                                  SizedBox(height: 5.0,),
                                                  ButtonHeaderWidget(
                                                    title: 'DateTime',
                                                    text: getText(),
                                                    onClicked: () => pickDateTime(context),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 10, right: 10),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.white, width: 1),
                                                      borderRadius: BorderRadius.circular(
                                                          10.0),
                                                    ),
                                                  ),
                                                  Row( mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      RaisedButton(
                                                        // padding: EdgeInsets.only(left:30,right:30),
                                                          onPressed: (){
                                                            updateData();
                                                            Navigator.pop(context);
                                                          } ,
                                                          child: Text('Request for Interview',style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.white,
                                                          ),),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(10.0),
                                                          ),
                                                          color: Colors.lightBlue
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
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
                    }),
              ),
            ),
          );
        }
    );
  }
}
