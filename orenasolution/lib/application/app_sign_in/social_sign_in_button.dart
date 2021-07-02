import 'package:orenasolution/common_widgets/custom_raised_button.dart';
import 'package:flutter/material.dart';
class SocialSignInButton extends CustomRaiseButton {
  SocialSignInButton({
    String text,
    String assetName,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  }) : super(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image.asset(assetName),
        Text(text,
          style: TextStyle(color: textColor,fontSize: 15.0,fontWeight: FontWeight.w600),),
        Opacity(
          opacity: 0.0,
          child: Image.asset(assetName),
        ),

      ],
    ),
    color: color,
    borderRadius: 4.0,
    onPressed: onPressed,
  );
}
