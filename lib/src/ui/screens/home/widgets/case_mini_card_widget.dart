import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CaseMiniCardWidget extends StatelessWidget {
  final Color iconColor;
  final String svgPath;
  final String text;
  final String value;

  CaseMiniCardWidget({
    @required this.iconColor,
    @required this.svgPath,
    @required this.text,
    @required this.value
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      width: 150.0,
      height: 60.0,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  svgPath,
                  color: iconColor,
                  width: 40.0,
                  height: 40.0,
                ),
              ),
              Column(
                children: <Widget>[
                  Text(text, style:
                    TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(value, style:
                  TextStyle(
                    color:  Colors.grey[800],
                    fontWeight: FontWeight.w800,
                    fontSize: 24.0,
                  ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}