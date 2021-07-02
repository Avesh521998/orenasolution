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

class Interviewer extends StatefulWidget {
  String role;
  Interviewer({Key key, @required this.role}) :super(key: key);
  @override
  _InterviewerState createState() => _InterviewerState();
}
final Color yellow = Color(0xfffbc31b);
final Color orange = Color(0xFF64B5F6);
final Color blue = Color(0xFF2196F3);

class _InterviewerState extends State<Interviewer> {
  String email = "";
  File _image;
  final picker = ImagePicker();
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
     /* body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance.collection("RegisterDetails").doc().snapshots(),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    return Container(

                      child: ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                          DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
                          return GestureDetector(
                            child: Column(
                              children: [
                            //    Text(documentSnapshot['FirstName'],)
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
          ],
        ),
      ),*/
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
                    return GestureDetector(
                      child: Stack(
                        children: [
                            // Text(documentSnapshot['Email'],),
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


                                    /*Stack(
                                      children: [
                                        Container(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(30.0),
                                            child: _image != null
                                                ? Image.file(_image)
                                                : FlatButton(
                                              child: Icon(
                                                Icons.add_a_photo,
                                                size: 30,
                                              ),
                                              onPressed: pickImage,
                                            ),
                                          ),
                                        ),
                                        uploadImageButton(context),
                                        // uploadImageToFirebase(context)
                                      ],
                                    ),*/
                                  ],
                                ),
                                Row(
                                  children: [
                                    //Padding(padding: EdgeInsets.only(top: 80.0),
                                  /*  Container(
                    padding:
                    const EdgeInsets.only(left: 0.0),
                    margin: const EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                    gradient: LinearGradient(
                    colors: [blue,orange],
                    ),
                    borderRadius: BorderRadius.circular(10.0)),
                      child:FlatButton(
                        onPressed: () => uploadImageToFirebase(context),
                        child: Text(
                          "Upload Image",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),),*/
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

                                  ],),
                              ],
                            ),
                            /*child: CircleAvatar(
                              radius: 65,
                              backgroundColor: Color(0xff476cfb),
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
                            ),*/

                          ),
                         /* Stack(
                            children: [
                              Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: _image != null
                                      ? Image.file(_image)
                                      : FlatButton(
                                    child: Icon(
                                      Icons.add_a_photo,
                                      size: 50,
                                    ),
                                    onPressed: pickImage,
                                  ),
                                ),
                              ),
                              uploadImageButton(context),
                              // uploadImageToFirebase(context)
                            ],
                          ),*/
                          /*Expanded(child: Stack(
                            children: [
                              Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30.0),
                              child: _image != null
                                  ? Image.file(_image)
                                  : FlatButton(
                                child: Icon(
                                  Icons.add_a_photo,
                                  size: 50,
                                ),
                                onPressed: pickImage,
                              ),
                            ),
                          ),
                              uploadImageButton(context),
                             // uploadImageToFirebase(context)
                            ],
                          )),*/
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

                                          ],
                                        ),
                                      ),
                                    ),
                                   /* Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        child: IconButton(
                                          icon: Icon(Icons.edit),
                                         // FontAwesomeIcons.pen,
                                          color: Color(0xff476cfb),
                                          onPressed: (){
                                            showFirstnameFunc(context,documentSnapshot[index]['FirstName']);
                                          },
                                        ),
                                      ),
                                    ),*/
                                   /* DropdownButton(
                                      hint: Text('Select Your Experience'),
                                      dropdownColor: Colors.blue,
                                      icon: Icon(Icons.arrow_drop_down),
                                      iconSize: 30,
                                      isExpanded: true,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20
                                      ),
                                      value: valueChoose,
                                      onChanged: (newValue) {
                                        setState(() {
                                          valueChoose = newValue;
                                        });
                                      },
                                      items: listItem1.map((valueItem) {
                                        return DropdownMenuItem(
                                            value: valueItem,
                                            child: Text(valueItem));
                                      }).toList(),
                                    ),*/
                                  ],
                                ),
                              /*  DropdownButton(
                                  hint: Text('Select Your Experience'),
                                  dropdownColor: Colors.blue,
                                  icon: Icon(Icons.arrow_drop_down),
                                  iconSize: 30,
                                  isExpanded: true,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20
                                  ),
                                  value: valueChoose,
                                  onChanged: (newValue) {
                                    setState(() {
                                      valueChoose = newValue;
                                      valueChoose = newValue.toString();
                                    });
                                  },
                                  items: listItem1.map((valueItem) {
                                    return DropdownMenuItem(
                                        value: valueItem,
                                        child: Text(valueItem));
                                  }).toList(),
                                ),*/
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
                                )

                             //   Text(documentSnapshot['FirstName'],),
                             //   Text(documentSnapshot['LastName'],),
                            //    Text(documentSnapshot['Email'],),
                            //    Text(documentSnapshot['Mobile'],),
                              ],
                            ),
                          )
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
  /*Widget uploadImageButton(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            padding:
            const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
            margin: const EdgeInsets.only(
                top: 30, left: 20.0, right: 20.0, bottom: 20.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [yellow, orange],
                ),
                borderRadius: BorderRadius.circular(30.0)),
            child: FlatButton(
              onPressed: () => uploadImageToFirebase(context),
              child: Text(
                "Upload Image",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }*/
}
showDialogFunc(BuildContext context, fname,lname,email,mobile,password,role,status,profile,valueChoose) {
  String valueChoose;
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
  /*String sts = 'verified';
  DocumentReference  documentReference = FirebaseFirestore.instance.collection("RegisterDetails").doc(email);
  Map<String, dynamic> students = {
    "FirstName": fname,
    "LastName" : lname,
    "Email": email,
    "Mobile": mobile,
    "urole": role,
    "userstatus": sts,
  };
  documentReference.set(students).whenComplete(() {
    print("$sts updated");
  });*/
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
                 /* SizedBox(height: 5.0,),
                  Text(fname),
                  SizedBox(height: 5.0,),
                  Text(lname),
                  SizedBox(height: 5.0,),
                  Text(email),
                  SizedBox(height: 5.0,),
                  Text(mobile),
                  SizedBox(height: 5.0,),
                  Text(password),
                  SizedBox(height: 5.0,),
                  Text(role),
                  SizedBox(height: 5.0,),
                  Text(status),
                  SizedBox(height: 5.0,),*/
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
/*showDialogFunc(BuildContext context, fname,lname,email,mobile){
  TextEditingController finame = TextEditingController(text: fname);
  TextEditingController liname = TextEditingController(text: lname);
  TextEditingController emails = TextEditingController(text: email);
  TextEditingController mobiles = TextEditingController(text: mobile);
  updateData(){
    String Experience = '13-16';
    DocumentReference  documentReference = FirebaseFirestore.instance.collection("InterviewerDetails").doc(FirebaseAuth.instance.currentUser.email);
    Map<String, dynamic> students = {
      "FirstName": fname,
      "LastName" : lname,
      "Email": email,
      "Mobile": mobile,
    };
    documentReference.set(students).whenComplete(() {
      print("$fname updated");
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
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.7,
              height: 320,
              child: Column(
                children: [
                  Row(
                    children: [
                      TextField(
                        controller: finame,
                      ),
                    ],
                  ),
                  SizedBox(height: 5.0,),
                  Row(
                    children: [
                      TextField(
                        controller: liname,
                      ),
                    ],
                  ),
                  SizedBox(height: 5.0,),
                  Row(
                    children: [
                      TextField(
                        controller: emails,
                      ),
                    ],
                  ),
                  SizedBox(height: 5.0,),
                  Row(
                    children: [
                      TextField(
                        controller: mobiles,
                      ),
                    ],
                  ),
                  SizedBox(height: 5.0,),
                  Text(fname),
                  SizedBox(height: 5.0,),
                 /* Text(lname),
                  SizedBox(height: 5.0,),
                  Text(email),
                  SizedBox(height: 5.0,),
                  Text(mobile),
                  SizedBox(height: 5.0,),
                  Text(password),
                  SizedBox(height: 5.0,),
                  Text(role),
                  SizedBox(height: 5.0,),
                  Text(status),
                  SizedBox(height: 5.0,),*/
                  Row( mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                     RaisedButton(
                        // padding: EdgeInsets.only(left:30,right:30),
                          onPressed: (){
                            updateData();
                            Navigator.pop(context);
                          } ,
                          child: Text('update',style: TextStyle(
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
}*/

/*
import 'AddImage.dart';
class Animal {
  final int id;
  final String name;

  Animal({
    this.id,
    this.name,
  });
}
class Interviewer extends StatefulWidget {
  String role;
  Reference imgRef;
  Interviewer({Key key, @required this.role}) :super(key: key);
  String valueChoose;
  int selectedRadio;
  int selectedRadioTile;
  @override
  _InterviewerState createState() => _InterviewerState();

}
readData(){
  DocumentReference documentReference = FirebaseFirestore.instance.collection("Languages").doc();
  documentReference.get().then((datasnapshot) {
    print(datasnapshot.data()["Languages"]);
  }
  );
}
class _InterviewerState extends State<Interviewer> {
  String valueChoose;
  int selectedRadio;
  int selectedRadioTile;
  CollectionReference imgRef;
  File _image;
  String iurl;
  static List<Animal> _animals = [
    //readData()
    Animal(id: 1, name: "c++"),
    Animal(id: 2, name: "Java"),
    Animal(id: 3, name: "C#"),
    Animal(id: 4, name: "Python"),
    Animal(id: 5, name: "Angular"),
  ];
  final _items = _animals
      .map((animal) => MultiSelectItem<Animal>(animal, animal.name))
      .toList();
//  DocumentReference documentReference = FirebaseFirestore.instance.collection("Languages").doc();
  List<Animal> _selectedAnimals = [];
  List<Animal> _selectedAnimals2 = [];
  List<Animal> _selectedAnimals3 = [];
  List<Animal> _selectedAnimals4 = [];
  List<Animal> _selectedAnimals5 = [];
  final _multiSelectKey = GlobalKey<FormFieldState>();
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      print('Image Path $_image');
    });
  }
  Future uploadPic(BuildContext context) async{
    String fileName = basename(_image.path);
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = firebaseStorageRef.putFile(_image);
    uploadTask.then((res) {
      res.ref.getDownloadURL().then((value) => imgRef.add({'url': value}));
    });
    // StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
    setState(() {
      print("Profile Picture uploaded");
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
    });
  }
  @override
  void initState() {
    super.initState();
    imgRef = FirebaseFirestore.instance.collection('InterviewerDetails');
  }
  @override
  Widget build(BuildContext context) {
    String ProgramId;
    File _image;
    String _url;
    String fname, lname, email, mobile, finame, liname, iemail, imobile,imgRef;
    TextEditingController firstnameController = TextEditingController();
    TextEditingController lastnameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController mobileController = TextEditingController();
    Color secondaryColor = Color(0xFF73AEF5);
    List listItem = [
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
    String em = widget.role;
    String urole;
    createData() {
      DocumentReference documentReference = FirebaseFirestore.instance.collection(
          "InterviewerDetails").doc(widget.role);
      Map<String, dynamic> students = {
        "Email": email,
        "Experience": valueChoose,
        "FirstName": finame,
        "LastName": liname,
        "profileurl" : imgRef,
        "username":valueChoose,
      //  "Experience": valueChoose,
      //  "Selected Language":_selectedAnimals3,
      };
      documentReference.set(students).whenComplete(() {
        print("$email created");
      }
      );
    }
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(

          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF73AEF5),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE5),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                margin: const EdgeInsets.only(top: 30.0),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 50.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Profile Details',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      //    SizedBox(height: 30.0),
                      //  _buildTextField(firstnameController, 'FirstName'),
                      //    SizedBox(height: 10.0),
                      //  _buildTextField(lastnameController, 'LastName'),
                      //   SizedBox(height: 10.0),
                      //   _buildTextField(emailController, 'Email'),
                      //   SizedBox(height: 10.0),
                      //   _buildTextField(mobileController, 'Mobile'),
                      //   SizedBox(height: 10.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                        //SizedBox(height: 20.0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.center,
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Color(0xff476cfb),
                                  child: ClipOval(
                                    child: new SizedBox(
                                      width: 50.0,
                                      height: 50.0,
                                      child: (_image!=null)?Image.file(
                                        _image,
                                        fit: BoxFit.fill,
                                      ):Image.asset('assets/user.png',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 50.0),
                                child: IconButton(
                                  icon: Icon(
                                    FontAwesomeIcons.camera,
                                    size: 20.0,
                                  ),
                                  onPressed: () {
                                    getImage();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      StreamBuilder(
                          stream: FirebaseFirestore.instance.collection(
                              "RegisterDetails")
                              .where('Email', isEqualTo: widget.role)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot documentSnapshot = snapshot
                                        .data.docs[index];
                                    //   firstnameController.text  = documentSnapshot["LastName"].toString();
                                    /*  return Center(
                              child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(documentSnapshot["FirstName"] ?? 'default'),
                                    ),
                                    Expanded(
                                      child: Text(documentSnapshot["LastName"] ?? 'default'),
                                    ),
                                    Expanded(
                                      child: Text(documentSnapshot["Email"] ?? 'default'),
                                    ),
                                    Expanded(
                                      child: Text(documentSnapshot["Mobile"].toString() ?? 'default'),
                                    ),
                                  ]
                              ),
                            );*/
                                    //  createData();

                                    fname = (documentSnapshot["FirstName"] ??
                                        'default').toString();
                                    firstnameController.text = fname;
                                    lname = (documentSnapshot["LastName"] ??
                                        'default').toString();
                                    lastnameController.text = lname;
                                    email =
                                        (documentSnapshot["Email"] ?? 'default')
                                            .toString();
                                    emailController.text = email;
                                    mobile = (documentSnapshot["Mobile"] ??
                                        'default').toString();
                                    mobileController.text = mobile;

                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: <Widget>[

                                        Text(
                                          'First Name',
                                          style: kLabelStyle,
                                        ),
                                        SizedBox(height: 10.0),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          decoration: kBoxDecorationStyle,
                                          height: 60.0,
                                          child: TextField(
                                            controller: firstnameController,
                                            keyboardType: TextInputType
                                                .emailAddress,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'OpenSans',
                                            ),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.only(
                                                  top: 14.0),
                                              prefixIcon: Icon(
                                                Icons.email,
                                                color: Colors.white,
                                              ),
                                              hintText: 'Enter your FirstName',
                                              hintStyle: kHintTextStyle,
                                              //  prefixText: documentSnapshot["LastName"] ?? 'default',
                                            ),

                                            onChanged: (value) =>
                                            {
                                              finame = firstnameController.text
                                            },
                                          ),
                                        ),

                                        Text(
                                          'Last Name',
                                          style: kLabelStyle,
                                        ),
                                        SizedBox(height: 10.0),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          decoration: kBoxDecorationStyle,
                                          height: 60.0,
                                          child: TextField(
                                            controller: lastnameController,
                                            keyboardType: TextInputType
                                                .emailAddress,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'OpenSans',
                                            ),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.only(
                                                  top: 14.0),
                                              prefixIcon: Icon(
                                                Icons.email,
                                                color: Colors.white,
                                              ),
                                              hintText: 'Enter your LastName',
                                              hintStyle: kHintTextStyle,
                                              //  prefixText: documentSnapshot["LastName"] ?? 'default',
                                            ),
                                            onChanged: (value) =>
                                            {
                                              liname = lastnameController.text
                                            },
                                          ),
                                        ),

                                        Text(
                                          'Email',
                                          style: kLabelStyle,
                                        ),
                                        SizedBox(height: 10.0),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          decoration: kBoxDecorationStyle,
                                          height: 60.0,
                                          child: TextField(
                                            controller: emailController,
                                            keyboardType: TextInputType
                                                .emailAddress,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'OpenSans',
                                            ),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.only(
                                                  top: 14.0),
                                              prefixIcon: Icon(
                                                Icons.email,
                                                color: Colors.white,
                                              ),
                                              hintText: 'Enter your Email',
                                              hintStyle: kHintTextStyle,
                                              //  prefixText: documentSnapshot["LastName"] ?? 'default',
                                            ),

                                            onChanged: (value) =>
                                            {
                                              iemail = emailController.text
                                            },
                                          ),
                                        ),

                                        Text(
                                          'Mobile',
                                          style: kLabelStyle,
                                        ),
                                        SizedBox(height: 10.0),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          decoration: kBoxDecorationStyle,
                                          height: 60.0,
                                          child: TextField(
                                            controller: mobileController,
                                            keyboardType: TextInputType
                                                .emailAddress,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'OpenSans',
                                            ),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.only(
                                                  top: 14.0),
                                              prefixIcon: Icon(
                                                Icons.phone,
                                                color: Colors.white,
                                              ),
                                              hintText: 'Enter your Mobile',
                                              hintStyle: kHintTextStyle,
                                              //  prefixText: documentSnapshot["LastName"] ?? 'default',
                                            ),
                                            onChanged: (value) =>
                                            {
                                              imobile = mobileController.text
                                            },
                                          ),
                                        ),
                                        SizedBox(height: 10.0),
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
                                          child: DropdownButton(
                                            hint: Text('Select Your Experience'),
                                            dropdownColor: Colors.blue,
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 30,
                                            isExpanded: true,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20
                                            ),
                                            value: valueChoose,
                                            onChanged: (newValue) {
                                              setState(() {
                                                valueChoose = newValue;
                                              });
                                            },
                                            items: listItem.map((valueItem) {
                                              return DropdownMenuItem(
                                                  value: valueItem,
                                                  child: Text(valueItem));
                                            }).toList(),
                                          ),
                                        ),
                                        SizedBox(height: 10.0),
                                        MultiSelectBottomSheetField<Animal>(
                                          key: _multiSelectKey,
                                          initialChildSize: 0.7,
                                          maxChildSize: 0.95,
                                          title: Text("Specifications"),
                                          buttonText: Text("Select Language"),
                                          items: _items,
                                          searchable: true,
                                          validator: (values) {
                                            if (values == null || values.isEmpty) {
                                              return "Required";
                                            }
                                            List<String> names = values.map((e) => e.name).toList();
                                            if (names.contains("Frog")) {
                                              return "Please Select Language!";
                                            }
                                            return null;
                                          },
                                          onConfirm: (values) {
                                            setState(() {
                                              _selectedAnimals3 = values;
                                            });
                                            _multiSelectKey.currentState.validate();
                                          },
                                          chipDisplay: MultiSelectChipDisplay(
                                            onTap: (item) {
                                              setState(() {
                                                _selectedAnimals3.remove(item);
                                              });
                                              _multiSelectKey.currentState.validate();
                                            },
                                          ),
                                        ),
                                        SizedBox(height: 10.0),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 25.0),
                                          width: double.infinity,
                                          child: RaisedButton(
                                            elevation: 5.0,
                                            onPressed: () {
                                             // uploadPic(context);
                                              createData();
                                            },
                                            padding: EdgeInsets.all(15.0),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius
                                                  .circular(30.0),
                                            ),
                                            color: Colors.white,
                                            child: Text(
                                              'Submit',
                                              style: TextStyle(
                                                color: Color(0xFF527DAA),
                                                letterSpacing: 1.5,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'OpenSans',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                              );
                            }
                            else {
                              return Align(
                                alignment: FractionalOffset.bottomCenter,
                                child: CircularProgressIndicator(),
                              );
                            }
                          }
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
*/