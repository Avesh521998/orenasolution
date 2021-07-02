import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:orenasolution/utilities/constants.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:image_downloader/image_downloader.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Interviewee extends StatefulWidget {
  String role;
  Interviewee({Key key, @required this.role}) :super(key: key);
  @override
  _IntervieweeState createState() => _IntervieweeState();
}
final Color yellow = Color(0xfffbc31b);
final Color orange = Color(0xFF64B5F6);
final Color blue = Color(0xFF2196F3);


class _IntervieweeState extends State<Interviewee> {
  Future<String> getIntFromLocalMemory(String key) async {
    var pref = await SharedPreferences.getInstance();
    String number = pref.getString(key) ?? FirebaseAuth.instance.currentUser.email;
    return number;
  }

/*
  * It returns the saved the int value from the memory.
  * */
  Future<void> saveIntInLocalMemory(String key, String value) async {
    var pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
  }
  String email = "";
  File _image;
  String dropdownvalue = 'dropdownvalue';
  final picker = ImagePicker();
  String todoTitle = "";
  Reference imgRef;
  String valueChoose;
  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_image.path);
    DocumentReference  documentReference = FirebaseFirestore.instance.collection("RegisterDetails").doc(FirebaseAuth.instance.currentUser.email);
    Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('uploads/$fileName');
    firebaseStorageRef.putFile(_image).whenComplete(() async {
      await firebaseStorageRef.getDownloadURL().then((value) =>
          documentReference.update({'profileurl': value}),
      );}
    );
  }
  @override
  Widget build(BuildContext context) {

    List listItem1 = [
      "0-1",
      "1-2",
      "3-4",
      "5-6",
      "7-8",
      "9-10",
      "10-12",
      "13-15",
      "16-18",
      "19-20",
      "20 Above"
    ];
    return Scaffold(
      backgroundColor: Colors.grey[250],
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('RegisterDetails').where('Email',isEqualTo: FirebaseAuth.instance.currentUser.email).get(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return Container(
              child: ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
                    final list = snapshot.data.docs;
                    String inter = list[index]['Email'];
                    return GestureDetector(
                      child: Stack(
                        children: [
                          ClipPath(
                            clipper: OvalBottomBorderClipper(),
                            child: Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height/4.5,
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
                          Container(
                            margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width/2-60,
                              top: MediaQuery.of(context).size.height/7.1,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 55,
                                      backgroundColor: Color(0xFF2196F3),
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
                                    Padding(
                                      padding: EdgeInsets.only(top: 80.0),
                                      child: IconButton(
                                        icon: Icon(
                                          FontAwesomeIcons.camera,
                                          size: 30.0,
                                        ),
                                        onPressed: (){
                                          pickImage();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      child: RaisedButton(
                                        color: Color(0xFF2196F3),
                                        onPressed: ()=>uploadImageToFirebase(context),
                                        child: Text(
                                          "Upload Image",
                                          style: TextStyle(fontSize: 20,color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 300,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Column(
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text('First Name',
                                                  style: TextStyle(
                                                      color: Colors.blueGrey, fontSize: 10.0)),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(documentSnapshot['FirstName'],
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15.0,
                                                      fontWeight: FontWeight.bold)),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text('Last Name',
                                                  style: TextStyle(
                                                      color: Colors.blueGrey, fontSize: 10.0)),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(documentSnapshot['LastName'],
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15.0,
                                                      fontWeight: FontWeight.bold)),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text('Email',
                                                  style: TextStyle(
                                                      color: Colors.blueGrey, fontSize: 10.0)),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(documentSnapshot['Email'],
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15.0,
                                                      fontWeight: FontWeight.bold)),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text('Mobile',
                                                  style: TextStyle(
                                                      color: Colors.blueGrey, fontSize: 10.0)),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(documentSnapshot['Mobile'],
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15.0,
                                                      fontWeight: FontWeight.bold)),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text('Experience',
                                                  style: TextStyle(
                                                      color: Colors.blueGrey, fontSize: 10.0)),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(documentSnapshot['Experience'],
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15.0,
                                                      fontWeight: FontWeight.bold)),
                                            ),
                                            SizedBox(height: 5.0,),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    // Add your onPressed code here!
                                    print('button press');
                                    showDialogFunc(context,list[index]['FirstName'],list[index]['LastName'],list[index]['Email'],list[index]['Mobile'],list[index]['Password'],list[index]['urole'],list[index]['userstatus'],list[index]['profileurl'],valueChoose);
                                  },
                                  child: FloatingActionButton.extended(
                                    label: Text('Edit'),
                                    icon: Icon(Icons.edit),
                                    backgroundColor: Colors.blue,
                                  ),
                                ),


                                //   Text(documentSnapshot['FirstName'],),
                                //   Text(documentSnapshot['LastName'],),
                                //    Text(documentSnapshot['Email'],),
                                //    Text(documentSnapshot['Mobile'],),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
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
    );
  }
  showDialogFunc(BuildContext context, fname,lname,email,mobile,password,role,status,profile,valueChoose) async{
    String valueChoose;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("profile",profile);
    List listItem1 = [
      "0-1",
      "1-2",
      "3-4",
      "5-6",
      "7-8",
      "9-10",
      "10-12",
      "13-15",
      "16-18",
      "19-20",
      "20 Above"
    ];
    TextEditingController finame = TextEditingController(text: fname);
    TextEditingController liname = TextEditingController(text: lname);
    TextEditingController emails = TextEditingController(text: email);
    TextEditingController mobiles = TextEditingController(text: mobile);
    updateData(){
      String sts = 'verified';
      DocumentReference  documentReference = FirebaseFirestore.instance.collection("RegisterDetails").doc(email);
      Map<String, dynamic> students = {
        "FirstName": fname,
        "LastName" : lname,
        "Email": email,
        "Mobile": mobile,
        "Password":password,
        "urole": role,
        "userstatus": sts,
        "profileurl":profile,
        "Experience":valueChoose,
        "Domain":"",
        "Location":"",
        "Education":"",
      };
      documentReference.set(students).whenComplete(() {
        print("$sts updated");
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
                height: 640,
                child: Column(
                  children: [
                    TextField(
                      controller: finame,
                      onChanged: (finame) {
                        fname = finame.toString();
                      },
                    ),
                    SizedBox(height: 5.0,),
                    TextField(
                      controller: liname,
                      onChanged: (liname) {
                        lname = liname.toString();
                      },
                    ),
                    SizedBox(height: 5.0,),
                    TextField(
                      controller: emails,
                      onChanged: (emails) {
                        email = emails.toString();
                      },
                    ),
                    SizedBox(height: 5.0,),
                    TextField(
                      controller: mobiles,
                      onChanged: (mobiles) {
                        mobile = mobiles.toString();
                      },
                    ),
                    SizedBox(height: 5.0,),
                    Text(
                      'Experience',
                      style: kLabelStyle,
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
                            child: Text('update Data',style: TextStyle(
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
            ),
          );
        }
    );
  }
}
