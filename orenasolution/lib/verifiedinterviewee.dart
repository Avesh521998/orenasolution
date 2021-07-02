import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:orenasolution/constants.dart';
class VerifiedInterviewee extends StatefulWidget {
  @override
  _VerifiedIntervieweeState createState() => _VerifiedIntervieweeState();
}

class _VerifiedIntervieweeState extends State<VerifiedInterviewee> {

  @override
  Widget build(BuildContext context) {
    File _image;
    return Scaffold(
      floatingActionButton: null,
      appBar: AppBar(
        title: Text('Interviewee Details'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('RegisterDetails').where('urole',isEqualTo: 'Interviewee').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final list = snapshot.data.docs;
          return  ListView.builder( padding: EdgeInsets.all(8.0),itemBuilder: (context,index){
            return GestureDetector(
              onTap: (){
                showDialogFunc(context,list[index]['FirstName'],list[index]['LastName'],list[index]['Email'],list[index]['Mobile'],list[index]['Password'],list[index]['urole'],list[index]['userstatus'],list[index]['profileurl'],list[index]['Experience']);
              },
              child: Card(
                color: Colors.white70,
                child:ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Color(0xff476cfb),
                    child: ClipOval(
                      child: new SizedBox(
                        width: 75.0,
                        height: 75.0,
                        child: (_image!=null)?Image.file(
                          _image,
                          fit: BoxFit.fill,
                        ):Image.network(
                          list[index]['profileurl'],
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  title: Text(list[index]['FirstName'] + '\t' + list[index]['LastName'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  subtitle: Text(list[index]['Email']),
                ),),
              // child: Text("First Name " + list[index]['FirstName'] + "Last Name " + list[index]['LastName']+ "Email " + list[index]['Email'] + "Mobile " + list[index]['Mobile'] + "User Role " + list[index]['urole']),
            );
          },
            itemCount: list.length,
          );
        },
      ),
    );
  }

  showDialogFunc(BuildContext context, fname,lname,email,mobile,password,role,status,profileurl,experience) {
    File _image;
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
        "profileurl":profileurl,
        "Experience":experience,
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
          return Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: Constants.padding,top: Constants.avatarRadius
                    + Constants.padding , right: Constants.padding,bottom: Constants.padding + Constants.padding
                ),
                margin: EdgeInsets.only(top: Constants.avatarRadius+Constants.padding+Constants.padding+Constants.padding),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Constants.padding),
                    boxShadow: [
                        BoxShadow(color: Colors.black,offset: Offset(0,10),
                          blurRadius: 10
                      ),
                    ]
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                            child: Text('First Name',style: TextStyle(fontSize: 14),)
                        ),
                        Container(
                            child: Text(fname,style: TextStyle(fontSize: 14),)
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            child: Text(' Last Name',style: TextStyle(fontSize: 14),)
                        ),
                        Container(
                            child: Text(lname,style: TextStyle(fontSize: 14),)
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                            child: Text('  Email',style: TextStyle(fontSize: 14),)
                        ),
                        Container(
                            child: Text(email,style: TextStyle(fontSize: 14),)
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                            child: Text('  Mobile',style: TextStyle(fontSize: 14),)
                        ),
                        Container(
                            child: Text(mobile,style: TextStyle(fontSize: 14),)
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child:FloatingActionButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.arrow_back),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: Constants.padding,
                right: Constants.padding,
                top: Constants.padding+Constants.padding+Constants.padding,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Color(0xff476cfb),
                  child: ClipOval(
                    child: new SizedBox(
                      width: 85.0,
                      height: 85.0,
                      child: (_image!=null)?Image.file(
                        _image,
                        fit: BoxFit.fill,
                      ):Image.network(
                        profileurl,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
         /* return Center(
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
                 mainAxisAlignment :MainAxisAlignment.center,
                 children: [

                 ],
               ),
               /* child: Column(
                  children: [
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
                    SizedBox(height: 5.0,),
                    Row( mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          // padding: EdgeInsets.only(left:30,right:30),

                            onPressed: (){Navigator.pop(context);},
                            child: Text('Reject',style: TextStyle(
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
                          // padding: EdgeInsets.only(left:30,right:30),
                            onPressed: (){
                              updateData();
                              Navigator.pop(context);
                            } ,
                            child: Text('Accept',style: TextStyle(
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
                ),*/
              ),
            ),
          );*/
        }
    );
  }
}
