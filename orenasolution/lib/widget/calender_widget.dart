
import 'package:orenasolution/model/EventDataSource.dart';
import 'package:orenasolution/provider/event_provider.dart';
import 'package:orenasolution/widget/tasks_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
class CalendarWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;
    return SfCalendar(
      view: CalendarView.month,
      dataSource: EventDataSource(events),
      initialSelectedDate: DateTime.now(),
      cellBorderColor: Colors.transparent,
      onLongPress: (details){
        final provider = Provider.of<EventProvider>(context,listen: false);
        provider.setDate(details.date);
        showModalBottomSheet(context: context, builder: (context)=>TasksWidget());
      },
    );

  }
}
