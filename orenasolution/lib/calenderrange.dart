import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CalenderRange extends StatefulWidget {
  //CalenderRange({Key ? key, required this.title}) : super(key: key);
  //final String title;
  @override
  _CalenderRangeState createState() => _CalenderRangeState();
}

class _CalenderRangeState extends State<CalenderRange> {
  DateRangePickerController _datePickerController = DateRangePickerController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: SfDateRangePicker(
            view: DateRangePickerView.month,
            monthViewSettings: DateRangePickerMonthViewSettings(firstDayOfWeek: 6),
            selectionMode: DateRangePickerSelectionMode.multiRange,
            onSelectionChanged: _onSelectionChanged,
            showActionButtons: true,
            controller: _datePickerController,
            onSubmit: (Object val) {
              print(val);
            },
            onCancel: () {
              _datePickerController.selectedRanges = null;
            },
          ),
        )
    );
  }
 void _onSelectionChanged(
    DateRangePickerSelectionChangedArgs dateRangePickerSelectionChangedArgs) {
    print(dateRangePickerSelectionChangedArgs.value);
    DocumentReference documentReference = FirebaseFirestore.instance.collection("InterviewerScheduled").doc(FirebaseAuth.instance.currentUser.email);
    Map<String, dynamic> students = {
      "SelecetedDate": dateRangePickerSelectionChangedArgs.value,
    };
}
}
