import 'package:flutter/material.dart';
class CustomRaiseButton extends StatelessWidget {
  CustomRaiseButton({
    this.child,
    this.color,
    this.borderRadius:4.0,
    this.onPressed,
    this.height:50.0,

});
  final Widget child;
  final Color color;
  final double borderRadius;
  final double height;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height:height,
      child: RaisedButton(
        child: child,
        color: color,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius))
        ),
        onPressed: onPressed,
      ),
    );
  }
}
