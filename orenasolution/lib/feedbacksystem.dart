
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';


class FeedbackSystem extends StatefulWidget {
  @override
  _FeedbackSystemState createState() => _FeedbackSystemState();
}

class _FeedbackSystemState extends State<FeedbackSystem> {
  String feedback;
  double rating;
  String email = FirebaseAuth.instance.currentUser.email;
  getRating(rate){
    this.rating = rate;
  }

  getFeedback(feed){
    this.feedback = feed;
  }
  createData(){
    DocumentReference  documentReference = FirebaseFirestore.instance.collection("FeedbackforSystem").doc(email);
    Map<String, dynamic> students = {
      "Email":email,
      "rating": rating,
      "feedback" : feedback,

    };
    documentReference.set(students).whenComplete(() {
      print("Feedback Submitted");
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15.0, left: 20.0,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(icon: Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                  onPressed: (){
                  Navigator.pop(context);
                  },
                ),
                Container(
                  width: 125.0,
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                    /*  IconButton(icon: Icon(Icons.filter_list),
                        color: Colors.white,
                        onPressed: (){},
                      ),
                      IconButton(icon: Icon(Icons.menu),
                        color: Colors.white,
                        onPressed: (){},
                      ),*/
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 25.0,),
          Padding(
            padding: EdgeInsets.only(left: 40.0),
            child: Row(
              children: <Widget>[
                Text('Rate',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0)),
                SizedBox(height: 10.0),
                Text(' Us',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0)),

              ],
            ),),
          SizedBox(height: 40.0),
          Container(
            height: MediaQuery.of(context).size.height - 185.0,
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
                    height: MediaQuery.of(context).size.height - 30.0,
                    child: ListView(
                      children: <Widget>[
                        smoothstarrating(),
                      ],
                    ),
                  ),)
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget smoothstarrating(){
    double rating = 4.0;
    return Padding(padding: EdgeInsets.only(left: 10.0, right: 10.0,top: 10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Center(

                    child: Text('Ratings',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    )
                ),
              ),
              SizedBox(height: 10.0,),
              SmoothStarRating(
                rating: rating,
                starCount: 5,
                isReadOnly: false,
                size: 45,
                color: Colors.blue,
                borderColor: Colors.blue,
                spacing: 2,
                onRated:(rate) {
                  setState(() {
                    rating = rate;
                    print(rating);
                    getRating(rate);
                  });
                },

              ),
              SizedBox(height: 20.0,),
              Container(
                child: Center(

                    child: Text('Feedback',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    )
                ),
              ),
              SizedBox(height: 10.0,),
              TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      )
                  ),
                  onChanged: (feed) {
                    getFeedback(feed);
                  }
              ),
              SizedBox(height: 20.0,),
              RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                onPressed: (){
                  createData();
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
        )
    );
  }
}
