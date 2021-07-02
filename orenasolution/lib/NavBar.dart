import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orenasolution/Intervieweepage.dart';
import 'package:orenasolution/screens/login_screen.dart';

import 'feedbacksystem.dart';
import 'models/message_model.dart';

class NavBar extends StatefulWidget {
  String role;
  String inter;
  String intreviewe;
  NavBar({Key key, @required this.intreviewe}) :super(key: key);
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  //final db = FirebaseFirestore.instance;
  String username='';
  bool dataisthere=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserdata();
  }
  getuserdata() async{
    DocumentSnapshot userdoc = await FirebaseFirestore.instance.doc(FirebaseAuth.instance.currentUser.email).get();
    setState(() {
      username = userdoc.data()['FirstName'];
      return username;
      dataisthere = true;
    });
  }
  final User user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    _signOut() async{
      await FirebaseAuth.instance.signOut();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
    final db = FirebaseFirestore.instance;
    String documentReference = FirebaseAuth.instance.currentUser.email;
    //String mob = FirebaseAuth.instance.currentUser.displayName;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("${user?.email}"),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            /*decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage('https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
            ),*/
          ),
          ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>IntervieweePage()));
            },
            leading: Icon(Icons.home,color: Colors.black,),
            title: Text("Home",style: TextStyle(color: Colors.black),),
          ),

          ListTile(
            onTap: ()=>{
              Navigator.push(context, MaterialPageRoute(builder: (context)=>FeedbackSystem()))
            },
            leading: Icon(Icons.feedback,color: Colors.black,),
            title: Text("Feedback",style: TextStyle(color: Colors.black),),
          ),
          ListTile(
            onTap: (){
              _signOut();
            },
            leading: Icon(Icons.logout,color: Colors.black,),
            title: Text("Logout",style: TextStyle(color: Colors.black),),
          )
        ],
      ),
    );
  }
}

/*class NavBar extends StatelessWidget {
  String username;

  @override
  Widget build(BuildContext context) {

    return Drawer(
        child: ListView(
      // Remove padding
      padding: EdgeInsets.zero,
      children: [
        UserAccountsDrawerHeader(
          accountName: Text('Oflutter.com'),
          accountEmail: Text('example@gmail.com'),
          currentAccountPicture: CircleAvatar(
            child: ClipOval(
              child: Image.network(
                'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                fit: BoxFit.cover,
                width: 90,
                height: 90,
              ),
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.blue,
            image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
          ),
        ),
        ListTile(
          leading: Icon(Icons.favorite),
          title: Text('Favorites'),
          onTap: () => null,
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text('Friends'),
          onTap: () => null,
        ),
        ListTile(
          leading: Icon(Icons.share),
          title: Text('Share'),
          onTap: () => null,
        ),
        ListTile(
          leading: Icon(Icons.notifications),
          title: Text('Request'),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Settings'),
          onTap: () => null,
        ),
        ListTile(
          leading: Icon(Icons.description),
          title: Text('Policies'),
          onTap: () => null,
        ),
        Divider(),
        ListTile(
          title: Text('Exit'),
          leading: Icon(Icons.exit_to_app),
          onTap: () => null,
        ),
      ],
    ),
    );
  }
}*/