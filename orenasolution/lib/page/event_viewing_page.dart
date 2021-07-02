import 'package:flutter/cupertino.dart';
import 'package:orenasolution/model/event.dart';
import 'package:orenasolution/page/event_editing_page.dart';
import 'package:orenasolution/provider/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:orenasolution/utils.dart';

class EventViewingPage extends StatelessWidget {
  final Event event;
  const EventViewingPage({
    Key key,
    @required this.event,
  }):super(key:key);
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      leading: CloseButton(),
      //actions: buildViewingActions(context, event),
      actions: <Widget>[
    IconButton(
    icon: Icon(Icons.edit),
    onPressed: ()=>Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context)=>EventEditingPage(event:event),
      ),
    ),
  ),
  IconButton(icon: Icon(Icons.delete),
  onPressed: (){
  final provider = Provider.of<EventProvider>(context,listen: false);
  provider.deleteEvent(event);

  }),
      ],
    ),
    body: ListView(
      padding: EdgeInsets.all(32),
      children: <Widget>[
      //  buildDateTime(event),
        SizedBox(height: 32,),
        Align(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('From',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              Text(event.from.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
            ],
          ),
        ),
        SizedBox(height: 32,),
        Align(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('TO',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              Text(event.to.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
            ],
          ),
        ),
        SizedBox(height: 32,),
        Text(event.title,style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
        const SizedBox(height: 24,),
        Text(event.description,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
      ],
    ),
  );
  Widget buildDateTime(Event event){
    return Column(
      children: [
        buildDate(event.isAllDay ? 'All-day' : 'From', event.from),
        if(!event.isAllDay) buildDate('TO',event.to),
      ],
    );
  }
  Widget buildDate(String title,DateTime date){
    return Column(
      children: [
        buildDate(event.isAllDay ? 'All-day' : 'From', event.from),
        if(!event.isAllDay) buildDate('TO',event.to),
      ],
    );
  }
  List<Widget> buildViewingActions (BuildContext context,Event event){

    IconButton(
      icon: Icon(Icons.edit),
      onPressed: ()=>Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context)=>EventEditingPage(event:event),
        ),
      ),
    );
    IconButton(icon: Icon(Icons.delete),
        onPressed: (){
      final provider = Provider.of<EventProvider>(context,listen: false);
      provider.deleteEvent(event);

    });
    return buildViewingActions(context, event);
  }
}
