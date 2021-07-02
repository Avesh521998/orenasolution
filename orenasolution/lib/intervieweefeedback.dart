import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
class IntervieweeFeedback extends StatefulWidget {
  @override
  _IntervieweeFeedbackState createState() => _IntervieweeFeedbackState();
}

class _IntervieweeFeedbackState extends State<IntervieweeFeedback> {
  int _stackIndex = 0;
  String feedback;
  String _verticalGroupValue = "Excellent";
  String _verticalGroupValu = "Need improvement";

  List<String> _status = ["Excellent", "Good", "Could be better"];
  @override
  Widget build(BuildContext context) {
    getFeedback(feed){
      this.feedback = feed;
    }
    return Scaffold(
      backgroundColor: Colors.blue,
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15.0, left: 20.0,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20.0),

                  child: Row(
                    children: <Widget>[
                      SizedBox(height: 50.0),
                      Text('Feedback for candidate',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0)
                      ),
                    ],
                  ),),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height - 75.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
              ),
              child: ListView(
                primary: false,
                padding: EdgeInsets.only(left: 25.0, right: 20.0),
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 40.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height - 10.0,
                      child: ListView(
                        children: <Widget>[
                          Text('Interview'),
                          SizedBox(height: 5,),
                          RadioGroup<String>.builder(
                            groupValue: _verticalGroupValue,
                            onChanged: (value) => setState(() {
                              _verticalGroupValue = value;
                            }),
                            items: _status,
                            itemBuilder: (item) => RadioButtonBuilder(
                              item,
                            ),
                            activeColor: Colors.red,
                          ),
                          SizedBox(height: 5,),
                          const Divider(
                            height: 20,
                            thickness: 5,
                            indent: 20,
                            endIndent: 20,
                          ),
                          SizedBox(height: 5,),

                          Text('Interviewer'),
                          SizedBox(height: 5,),
                          RadioGroup<String>.builder(
                            groupValue: _verticalGroupValu,
                            onChanged: (value) => setState(() {
                              _verticalGroupValu = value;
                            }),
                            items: _status,
                            itemBuilder: (item) => RadioButtonBuilder(
                              item,
                            ),
                            activeColor: Colors.red,
                          ),
                          SizedBox(height: 5,),
                          const Divider(
                            height: 20,
                            thickness: 5,
                            indent: 20,
                            endIndent: 20,
                          ),
                          SizedBox(height: 5,),
                          TextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: 3,
                              decoration: InputDecoration(
                                  hintText: 'Any suggestions...',
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blue),
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                  )
                              ),
                              onChanged: (feed) {
                                getFeedback(feed);
                              }
                          ),
                          SizedBox(height: 10.0,),
                          RaisedButton(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                            onPressed: (){
                              // createData();
                              Navigator.pop(context);
                            },
                            color: Colors.blue,
                            child: Text('Submit',style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
