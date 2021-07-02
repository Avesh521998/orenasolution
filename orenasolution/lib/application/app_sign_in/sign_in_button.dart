import 'package:orenasolution/common_widgets/custom_raised_button.dart';
import 'package:flutter/cupertino.dart';

class SignInButton extends CustomRaiseButton{
  SignInButton({
    String text,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  }) : super(child: Text(text,style: TextStyle(color: textColor,fontSize: 15.0,fontWeight: FontWeight.w600),
  ),
    color: color,
    borderRadius: 4.0,

    onPressed: onPressed,
  );
}