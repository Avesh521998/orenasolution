import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orenasolution/videoconference/createmeeting.dart';
import 'package:orenasolution/videoconference/joinmeeting.dart';

class VideoConference extends StatefulWidget {
  @override
  _VideoConferenceState createState() => _VideoConferenceState();
}

class _VideoConferenceState extends State<VideoConference> with SingleTickerProviderStateMixin{
  TabController tabController;
  buildtab(String name){
    return Container(
      width: 150,
      height: 50,
      child: Card(
        child: Center(
          child: Text(name),
        ),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        title:Text('From',style: TextStyle(fontSize: 20,color: Colors.white)),
        bottom: TabBar(
          controller: tabController,
          tabs: [
            buildtab("Join Meeting"),
            buildtab("Create Metting")
          ],
        ),
      ),
      body: TabBarView(
          controller: tabController,
          children: [
            JoinMeeting(),
            CreateMeeting(),
          ]),
    );
  }
}
