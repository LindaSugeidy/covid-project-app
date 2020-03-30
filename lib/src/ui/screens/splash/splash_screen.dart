import 'package:covidapp/src/ui/widgets/hex_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double heightContainer = MediaQuery.of(context).size.height / 3.0;

    return Scaffold(
      backgroundColor: HexColor("f6eeff"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: heightContainer,
            ),
            Container(
              height: heightContainer,
              child: Column(
                children: <Widget>[
                  SvgPicture.asset('assets/images/coronavirus.svg',
                    width: 150,
                    height: 150,
                  ),
                  Text('Covid App',
                    style: TextStyle(
                      fontFamily: 'Avalon',
                      color: HexColor('5839ae'),
                      fontSize: 32.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text('Coronavirus',
                      style: TextStyle(
                        fontFamily: 'Avalon',
                        color: HexColor('5839ae'),
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: heightContainer,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SvgPicture.asset('assets/images/coronavirus-bottom.svg',
                  width: MediaQuery.of(context).size.width,
                  height: heightContainer / 2,
                  allowDrawingOutsideViewBox: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}