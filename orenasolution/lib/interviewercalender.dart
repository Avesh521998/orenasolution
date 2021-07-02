import 'package:orenasolution/page/event_editing_page.dart';
import 'package:orenasolution/provider/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:orenasolution/widget/calender_widget.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class InterviewerCalender extends StatelessWidget {
  static final String title = 'Add Calender scheduled';
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context)=>EventProvider(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        accentColor: Colors.white,
        primaryColor: Colors.blue,
      ),
      home: MainPage(),
    ),
  );

}
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Add Calender scheduled'),
      centerTitle: true,
    ),
    body: CalendarWidget(),
    floatingActionButton: FloatingActionButton(
      child: Icon(Icons.add,color: Colors.white,),
      backgroundColor: Colors.red,
      onPressed: ()=>{
        //MaterialPageRoute(builder: (context)=>EventEditingPage())
        Navigator.push(context, MaterialPageRoute(builder: (context) => EventEditingPage())),
      },
    ),
  );
}