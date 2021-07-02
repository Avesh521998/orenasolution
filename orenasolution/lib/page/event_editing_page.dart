import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:orenasolution/model/event.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils.dart';
import 'package:orenasolution/provider/event_provider.dart';
import 'package:sqflite/sqflite.dart';
class EventEditingPage extends StatefulWidget {
  final Event event;
  const EventEditingPage({
    Key key,
    this.event,
}):super(key: key);
  @override
  _EventEditingPageState createState() => _EventEditingPageState();
}
class _EventEditingPageState extends State<EventEditingPage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

    DateTime fromDate;
    DateTime toDate;

    addDataToFirestore() async{
    CollectionReference documentReference = FirebaseFirestore.instance.collection('InterviewerScheduleDetails').doc(FirebaseAuth.instance.currentUser.email).collection('ScheduleDetails');
    documentReference.add({'Email':FirebaseAuth.instance.currentUser.email,'Title':titleController.text,'From':fromDate,'To':toDate}
    );
   }
  sqlData(){

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.event==null){
      fromDate = DateTime.now();
      toDate = DateTime.now().add(Duration(hours:1));
    }else{
      final event=widget.event;
      titleController.text = event.title;
      descriptionController.text = event.description;
      fromDate = event.from;
      toDate = event.to;
    }
  }
  @override
  void dispose() {
    titleController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      leading: CloseButton(),
      actions: buildEditingActions(),
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(12),
      child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTitle(),
              SizedBox(height: 12,),
              buildDateTimePickers(),
            ],
          )),
    ),
  );
  List<Widget> buildEditingActions() => [
    ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            shadowColor: Colors.transparent
        ),
        onPressed: saveFrom, icon: Icon(Icons.done), label: Text('Save'))
  ];
  Widget buildTitle()=> TextFormField(
    style: TextStyle(fontSize: 24),
    decoration: InputDecoration(
      border: UnderlineInputBorder(),
      hintText: 'Add Title',
    ),
    onFieldSubmitted: (_)=>saveFrom(),
    validator: (title)=>
      title != null && title.isEmpty ? 'Title cannot be empty' : null,
      controller: titleController,
  );
  Widget buildDateTimePickers()=>Column(
    children: [
      buildForm(),
      buildTo(),
    ],
  );
  Widget buildForm()=> buildHeader(
       header:'FROM',
      child:Row(
        children: [
          Expanded(
            flex: 2,
            child: buildDropdownField(
                text:Utils.toDate(fromDate),
              onClicked:()=>pickfromDateTime(pickDate:true),
            ),),
          Expanded(
            child: buildDropdownField(
                text:Utils.toTime(fromDate),
              onClicked:()=>pickfromDateTime(pickDate:false),
            ),),
        ],
      ),
     );
  Widget buildTo()=> buildHeader(
    header:'To',
    child:Row(
      children: [
        Expanded(
          flex: 2,
          child: buildDropdownField(
              text:Utils.toDate(toDate),
            onClicked:()=>pickToDateTime(pickDate:true),
          ),),
        Expanded(
          child: buildDropdownField(
              text:Utils.toTime(toDate),
              onClicked:()=>pickToDateTime(pickDate:false),
          ),),
      ],
    ),
  );

  Future pickfromDateTime({@required bool pickDate}) async {
    final date = await pickDateTime(fromDate,pickDate : pickDate,firstDate: pickDate ? fromDate :null,);
    if(date == null) return;

    if(date.isAfter(toDate)){
      toDate = DateTime(date.year,date.month,date.day,toDate.hour,toDate.minute);
    }
    setState(() => fromDate = date);
  }

  Future pickToDateTime({@required bool pickDate}) async {
    final date = await pickDateTime(toDate,pickDate : pickDate,firstDate: pickDate ? fromDate :null,);
    if(date == null) return;

    if(date.isAfter(toDate)){
      toDate = DateTime(date.year,date.month,date.day,toDate.hour,toDate.minute);
    }
    setState(() => toDate = date);
  }
  Future <DateTime> pickDateTime(
      DateTime initialDate,{
      @required bool pickDate,
      DateTime firstDate,
      }) async {
    if(pickDate){
      final date = await showDatePicker(context: context, initialDate: initialDate, firstDate: firstDate ?? DateTime(2000,8), lastDate: DateTime(2101));
      if(date == null)
        return null;
      final time = Duration(hours: initialDate.hour,minutes: initialDate.minute);
      return date.add(time);
    }else{
      final timeOfDay = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(initialDate));
      if(timeOfDay == null) return null;

      final date = DateTime(initialDate.year,initialDate.month,initialDate.day);
      final time = Duration(hours: timeOfDay.hour,minutes: timeOfDay.minute);
      return date.add(time);
    }

  }
  Widget buildDropdownField({
    @required String text,
    @required VoidCallback onClicked,
  })=>ListTile( title: Text(text),
  trailing: Icon(Icons.arrow_drop_down),
  onTap: onClicked,);

  Widget buildHeader({
  @required String header,
    @required Widget child,
}) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
        Text(header,style: TextStyle(fontWeight: FontWeight.bold),),
        child,
    ],
  );
  Future saveFrom() async {
    final isValid = _formKey.currentState.validate();
    if(isValid){
      final event = Event(
        title: titleController.text,
        description: descriptionController.text,
        from: fromDate,
        to: toDate,
        isAllDay: false,
      );

      final isEditing = widget.event!=null;
      final provider = Provider.of<EventProvider>(context,listen: false);
      if(isEditing){
            provider.editEvent(event,widget.event);
            Navigator.of(context).pop();
      }else{provider.addEvents(event);}
      Navigator.of(context).pop();
     // createData();
      addDataToFirestore();
      sqlData();
    }
  }
}
