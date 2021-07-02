import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: null,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('RegisterDetails').where('urole',isEqualTo: 'Interviewer').where('userstatus',isEqualTo: 'notverified').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          /* return ListView(
         children: snapshot.data.docs.map((document) {
          final list = snapshot.data.docs;
           return Center(

             child: Container(

               width: MediaQuery.of(context).size.width / 1.2,
               height: MediaQuery.of(context).size.height / 10,
               child:(document['urole'] == 'Interviewer') ? Text("First Name " + document['FirstName'] + "Last Name " + document['LastName']+ "Email " + document['Email'] + "Mobile " + document['Mobile'] + "User Role " + document['urole']):Wrap(),
             ),
           );
         }).toList(),
        );*/
          final list = snapshot.data.docs;
          return ListView.builder(itemBuilder: (context,index){

            /*  return ListTile(
             title: Text("First Name " + list[index]['FirstName'] + "Last Name " + list[index]['LastName']+ "Email " + list[index]['Email'] + "Mobile " + list[index]['Mobile'] + "User Role " + list[index]['urole'])
          );*/
            return GestureDetector(
              onTap: (){
               // print(list[index].data());
              //  print(list[index]['FirstName'],);
                showDialogFunc(context,list[index]['FirstName'],list[index]['LastName'],list[index]['Email'],list[index]['Mobile'],list[index]['Password'],list[index]['urole'],list[index]['userstatus']);
              },
             /* child:ListTile(
                  title: Text("First Name :"+ '\t' + list[index]['FirstName'] + '\n' + "Last Name :"+ '\t' + list[index]['LastName'] + '\n'+ "Email :"+ '\t' + list[index]['Email'] + '\n' + "Mobile :"+ '\t' + list[index]['Mobile'] + '\n' + "User Role :" + '\t'+ list[index]['urole'] + '\n'+ "User Status :" + '\t'+ list[index]['userstatus'],style: TextStyle(fontWeight: FontWeight.bold),)
              ),*/
              child: Card(
                  child:ListTile(
                      title: Text("First Name :"+ '\t' + list[index]['FirstName'] + '\n' + "Last Name :"+ '\t' + list[index]['LastName'] + '\n'+ "Email :"+ '\t' + list[index]['Email'] + '\n' + "Mobile :"+ '\t' + list[index]['Mobile'] + '\n' + "User Role :" + '\t'+ list[index]['urole'] + '\n'+ "User Status :" + '\t'+ list[index]['userstatus'],style: TextStyle(fontWeight: FontWeight.bold),)
                  ),
              ),
              // child: Text("First Name " + list[index]['FirstName'] + "Last Name " + list[index]['LastName']+ "Email " + list[index]['Email'] + "Mobile " + list[index]['Mobile'] + "User Role " + list[index]['urole']),
            );
          },
            itemCount: list.length,
          );
        },
      ),
    );
  }
}

showDialogFunc(BuildContext context, fname,lname,email,mobile,password,role,status) {
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
      "profileurl":"",
      "Experience":"",
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
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width * 0.7,
            height: 320,
            child: Column(
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
            ),
          ),
        ),
      );
    }
  );
}

