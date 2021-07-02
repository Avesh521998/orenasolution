import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:orenasolution/model/EventDataSource.dart';
import 'package:orenasolution/page/event_viewing_page.dart';
import 'package:orenasolution/provider/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';
class TasksWidget extends StatefulWidget {
  @override
  _TasksWidgetState createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
    final selectedEvents = provider.eventsOfSelectedDate;

    if (selectedEvents.isEmpty) {
      return Center(
        child: Text(
          'No Event found!',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
      );
    }

    return SfCalendarTheme(
      data : SfCalendarThemeData(),
      child:SfCalendar(
        view: CalendarView.timelineDay,
        dataSource: EventDataSource(provider.events),
        initialDisplayDate: provider.selectedDate,
        appointmentBuilder: appointmentBuilder,
        headerHeight: 0,
        todayHighlightColor: Colors.black,
        selectionDecoration: BoxDecoration(
          color: Colors.transparent,

        ),
        onTap: (details){
            if(details.appointments == null ) return;

            final event = details.appointments.first;
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EventViewingPage(event:event)));
        },
      )
    );
  }
  Widget appointmentBuilder(BuildContext context,CalendarAppointmentDetails details){
    final event = details.appointments.first;

    return Container(
      width: details.bounds.width,
      height: details.bounds.height,
      decoration: BoxDecoration(
        color: event.backgroundColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
       // child: Text(event.title,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('InterviewerScheduleDetails').doc(FirebaseAuth.instance.currentUser.email).collection('ScheduleDetails').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final list = snapshot.data.docs;
          return  ListView.builder( padding: EdgeInsets.all(8.0),itemBuilder: (context,index){
            return GestureDetector(
              child: Text(list[index]['Title'] ,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
              );
          },
            itemCount: list.length,
          );
        },
      ),
      )
    );
  }
}
