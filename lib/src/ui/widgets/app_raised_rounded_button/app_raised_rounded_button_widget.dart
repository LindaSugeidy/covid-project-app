import 'package:flutter/material.dart';

class AppRaisedRoundedButtonWidget extends StatelessWidget {
  final String text;
  final Function onPressed;

  AppRaisedRoundedButtonWidget({
    @required this.text,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Container(
        height: 32,
        width: 256,
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Center(
            child: Text(text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
      onPressed: onPressed,
    );
  }
}