import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orenasolution/interviewee.dart';
import 'package:orenasolution/joinimeetings.dart';
import 'package:orenasolution/screens/login_screen.dart';
import 'package:orenasolution/videoconference.dart';
import 'package:orenasolution/videoconference/joinmeeting.dart';
import 'package:orenasolution/viewintervieweescheduled.dart';
import 'package:orenasolution/widgets/category_selector.dart';
import 'package:orenasolution/widgets/favorite_contacts.dart';
import 'package:orenasolution/widgets/recent_chats.dart';
import 'NavBar.dart';
import 'feedbacksystem.dart';
import 'interviewer.dart';

class IntervieweePage extends StatefulWidget {
  String intreviewe = FirebaseAuth.instance.currentUser.email;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Fluid Sidebar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IntervieweePage(),
    );
  }
  @override
  _IntervieweeState createState() => _IntervieweeState();
}

class _IntervieweeState extends State<IntervieweePage> {
  Offset _offset = Offset(0,0);
  GlobalKey globalKey = GlobalKey();
  List<double> limits = [];
  String intreviewe = FirebaseAuth.instance.currentUser.email;
  bool isMenuOpen = false;

  @override
  void initState() {
    limits= [0, 0, 0, 0, 0, 0];
    WidgetsBinding.instance.addPostFrameCallback(getPosition);
    super.initState();
  }

  getPosition(duration){
    RenderBox renderBox = globalKey.currentContext.findRenderObject();
    final position = renderBox.localToGlobal(Offset.zero);
    double start = position.dy - 20;
    double contLimit = position.dy + renderBox.size.height - 20;
    double step = (contLimit-start)/5;
    limits = [];
    for (double x = start; x <= contLimit; x = x + step) {
      limits.add(x);
    }
    setState(() {
      limits = limits;
    });

  }

  double getSize(int x){
    double size  = (_offset.dy > limits[x] && _offset.dy < limits[x + 1]) ? 25 : 20;
    return size;
  }


  double value = 0;
  int page=0;
  List pageoptions = [
    FavoriteContacts(),
    ViewInterVieweeScheduled(),
    JoinMeetings(),
    Interviewee(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),

      backgroundColor: Colors.grey[250],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        // selectedLabelStyle: mystyle(17,Colors.blue),
        selectedLabelStyle: TextStyle(fontSize: 17.0,fontFamily: 'Family Name',color:Colors.blue),
        unselectedItemColor: Colors.black,
        // unselectedLabelStyle: mystyle(17,Colors.black),
        unselectedLabelStyle: TextStyle(fontSize: 17.0,color:Colors.black),
        currentIndex: page,
        onTap: (index){
          setState(() {
            page=index;
          });
        },
        items: [
          BottomNavigationBarItem(
              title: Text('Home'),
              icon: Icon(Icons.home,size: 25,)
          ),
          BottomNavigationBarItem(
              title: Text('Schedule'),
              icon: Icon(Icons.schedule,size: 25,)
          ),
          BottomNavigationBarItem(
              title: Text('Video call'),
              icon: Icon(Icons.video_call,size: 25,)
          ),
          BottomNavigationBarItem(
              title: Text('Profile'),
              icon: Icon(Icons.person,size: 25,)
          )
        ],
      ),
      body: pageoptions[page],
    );
    /*return Scaffold(
      drawer: NavBar(),
      backgroundColor: Theme.of(context).primaryColor,
      /*appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          iconSize: 30.0,
          color: Colors.white,
          onPressed: () {},
        ),
        title: Text(
          'Chats',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),*/
      /*body: Column(
        children: <Widget>[
        //  CategorySelector(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                children: <Widget>[
                  FavoriteContacts(),
                 // RecentChats(),
                ],
              ),
            ),
          ),
        ],
      ),*/

      body: FavoriteContacts(),
    );*/

  }

}
class MyButton extends StatelessWidget {
  final String text;
  final IconData iconData;
  final double textSize;
  final double height;

  MyButton({this.text, this.iconData, this.textSize,this.height});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialButton(
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Icon(
            iconData,
            color: Colors.black,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: TextStyle(color: Colors.black45, fontSize: textSize),
          ),
        ],
      ),
      onPressed: () {},
    );
  }
}




class DrawerPainter extends CustomPainter {

  final Offset offset;

  DrawerPainter({this.offset});

  double getControlPointX(double width) {
    if (offset.dx == 0) {
      return width;
    } else {
      return offset.dx > width ? offset.dx : width + 75;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    Path path = Path();
    path.moveTo(-size.width, 0);
    path.lineTo(size.width, 0);
    path.quadraticBezierTo(
        getControlPointX(size.width), offset.dy, size.width, size.height);
    path.lineTo(-size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
