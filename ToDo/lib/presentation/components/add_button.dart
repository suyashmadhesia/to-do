import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SubmitButton extends StatelessWidget {
  final Function onPressed;
  final Color buttonColor;
  final String buttonName;

  SubmitButton(
      {@required this.onPressed,
      @required this.buttonName,
      @required this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      color: buttonColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide.none,
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 16),
          child: Text(
            buttonName,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
