import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orenasolution/Intervieweepage.dart';
import 'package:orenasolution/interviewer.dart';
import 'package:orenasolution/screens/login_screen.dart';
import 'package:orenasolution/utilities/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email, password;
  String groupValue;
  int selectedRadio;
  int selectedRadioTile;
  bool _isObscure = true;
  String userstatus = "notverified";
  String default_choice="Interviewer";
  int default_index = 0;
  bool _isHidden = true;
  // MyChoice default_choice = choices[0];
  List<MyChoice> choices = [
    MyChoice(index:0,choice:"Interviewer"),
    MyChoice(index:1,choice:"Interviewee"),
  ];

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    selectedRadioTile = 0;
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }
  final auth = FirebaseAuth.instance;

  String fname, lname, ProgramId,urole;
  String mobile;
  getFirstName(fname){
    this.fname = fname;
  }

  getLastName(lname){
    this.lname = lname;
  }
  getMobile(mobile){
    this.mobile= mobile;
  }
  getRole(urole){
    this.urole = urole;
  }

  createData() {
    DocumentReference documentReference = FirebaseFirestore.instance.collection(
        "RegisterDetails").doc(email);
    Map<String, dynamic> students = {
      "FirstName": fname,
      "LastName": lname,
      "Email": email,
      "Mobile": mobile,
      "Password": password,
      "urole" : urole,
      "userstatus": userstatus,
      "profileurl":"",
      "Experience":"",
      "Domain":"",
      "Location":"",
      "Education":"",
    };
    documentReference.set(students).whenComplete(() {
      print("$email created");
      }
    );
  }

verifieduser(){
  auth.createUserWithEmailAndPassword(email: email, password: password).then((_){
    createData();
    auth.signOut();
    Navigator.pop(context);
  });
}

  Widget _buildFirstNameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your First Name',
              hintStyle: kHintTextStyle,
            ),
            onChanged: (value) =>{
              fname = value.trim(),
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLatNameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Last Name',
              hintStyle: kHintTextStyle,
            ),
            onChanged: (value) =>{
              lname = value.trim(),
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),
            onChanged: (value) =>{
              email = value.trim(),
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMobileTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.phone,
                color: Colors.white,
              ),
              hintText: 'Enter your Mobile',
              hintStyle: kHintTextStyle,
            ),
            onChanged: (value) =>{
              mobile = value.trim(),
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    bool _secureText = true;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: <Widget>[

        Text(
          'Password',
          style: kLabelStyle,
       ),
        SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.only(top: 8.0),
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,

          child: TextField(
            obscureText: _isObscure,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),

            decoration: InputDecoration(
             // contentPadding: EdgeInsets.only(top: 1.0),

              border: InputBorder.none,
              suffix: IconButton(

                      icon: Icon(
                            _isObscure ? Icons.visibility : Icons.visibility_off),
                            onPressed: () {
                            setState(() {
                                _isObscure = !_isObscure;
                            });
              }),
             // contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
            ),
            onChanged: (value) =>{
              password = value.trim(),
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          auth.createUserWithEmailAndPassword(email: email, password: password).then((_){
           createData();
            auth.signOut();
            Navigator.pop(context);
          });
          },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'Register',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _SelectedRole(){

    return Row(
      children: [
        Flexible(
          fit: FlexFit.loose,
          child:
          RadioListTile(
            value: 1,
            groupValue: selectedRadioTile,
            title: Text("Interviewer",style: TextStyle(
              color: Colors.white,
            ),
            ),
            onChanged: (val) {
              setSelectedRadioTile(val);
              if(val == 1)
                {
                  urole = 'Interviewer';
                }
             // return urole;
            },
            activeColor: Colors.red,
            selected: true,
          ),
        ),
        Flexible(
          fit: FlexFit.loose,
          child:
          RadioListTile(
            value: 2,
            groupValue: selectedRadioTile,
            title: Text("Interviewee",style: TextStyle(
              color: Colors.white,
            ),
            ),
            onChanged: (val) {
              setSelectedRadioTile(val);
              if(val == 2)
              {
                urole = 'Interviewee';
              }
            },
            activeColor: Colors.white,
            selected: false,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var _formKey = GlobalKey<FormState>();
    var isLoading = false;
    void _submit() {
      final isValid = _formKey.currentState.validate();
      if (!isValid) {
        return;
      }
      _formKey.currentState.save();
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
                    vertical: 10.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              //First Name
                            Container(
                              alignment: Alignment.centerLeft,
                              decoration: kBoxDecorationStyle,
                              height: 60.0,
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'OpenSans',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return '  Enter a First Name';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 14.0),
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  ),
                                  hintText: 'Enter your First Name',
                                  hintStyle: kHintTextStyle,
                                ),
                                onChanged: (value) =>{
                                  fname = value.trim(),
                                },
                              ),
                            ),
                            SizedBox(height: 20.0,),

                              //Last Name
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: kBoxDecorationStyle,
                                height: 60.0,
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'OpenSans',
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return '  Enter a Last Name';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: 14.0),
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Colors.white,
                                    ),
                                    hintText: 'Enter your Last Name',
                                    hintStyle: kHintTextStyle,
                                  ),
                                  onChanged: (value) =>{
                                    lname = value.trim(),
                                  },
                                ),
                              ),
                              SizedBox(height: 20.0,),

                              //Email
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: kBoxDecorationStyle,
                                height: 60.0,
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'OpenSans',
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty ||
                                        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                            .hasMatch(value)) {
                                      return '  Enter a valid email!';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: 14.0),
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Colors.white,
                                    ),
                                    hintText: 'Enter your Email',
                                    hintStyle: kHintTextStyle,
                                  ),
                                  onChanged: (value) =>{
                                    email = value.trim(),
                                  },
                                ),
                              ),
                              SizedBox(height: 20.0,),

                              //MObile
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: kBoxDecorationStyle,
                                height: 60.0,
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'OpenSans',
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return '  Enter a Mobile';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: 14.0),
                                    prefixIcon: Icon(
                                      Icons.phone,
                                      color: Colors.white,
                                    ),
                                    hintText: 'Enter your Mobile',
                                    hintStyle: kHintTextStyle,
                                  ),
                                  onChanged: (value) =>{
                                    mobile = value.trim(),
                                  },
                                ),
                              ),
                              SizedBox(height: 20.0,),

                              //password
                              Container(
                                padding: const EdgeInsets.only(top: 8.0),
                                alignment: Alignment.centerLeft,
                                decoration: kBoxDecorationStyle,
                                height: 60.0,

                                child: TextFormField(
                                  obscureText: _isObscure,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'OpenSans',
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty ||
                                        !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                            .hasMatch(value)) {
                                      return '  Enter a valid password';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    // contentPadding: EdgeInsets.only(top: 1.0),

                                    border: InputBorder.none,
                                    suffix: IconButton(

                                        icon: Icon(
                                            _isObscure ? Icons.visibility : Icons.visibility_off),
                                        onPressed: () {
                                          setState(() {
                                            _isObscure = !_isObscure;
                                          });
                                        }),
                                    // contentPadding: EdgeInsets.only(top: 14.0),
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.white,
                                    ),
                                    hintText: 'Enter your Password',
                                    hintStyle: kHintTextStyle,
                                  ),
                                  onChanged: (value) =>{
                                    password = value.trim(),
                                  },
                                ),
                              ),
                              SizedBox(height: 20.0,),
                              _SelectedRole(),
                              SizedBox(height: 20.0,),
                              Container(
                          padding: EdgeInsets.symmetric(vertical: 25.0),
                          width: double.infinity,
                          child: RaisedButton(
                            elevation: 5.0,
                            onPressed: () {
                              _submit();
                              auth.createUserWithEmailAndPassword(email: email, password: password).then((_){
                                createData();
                              });
                              Navigator.pop(context);
                            },
                            padding: EdgeInsets.all(15.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            color: Colors.white,
                            child: Text(
                              'Register',
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
                          ),
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
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}

class MyChoice {
  String choice;
  int index;
  MyChoice({this.index,this.choice});
}

