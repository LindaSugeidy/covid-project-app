import 'package:covidapp/src/ui/widgets/hex_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppScaffoldWidget extends StatelessWidget {
  final Widget child;
  final double screenStretch;

  AppScaffoldWidget({
    @required this.child,
    this.screenStretch = 4.0
  });

  @override
  Widget build(BuildContext context) {
    final double heightContainer = MediaQuery.of(context).size.height / screenStretch;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: HexColor("f6eeff"),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: screenStretch > 3.0 ? heightContainer : 0,
                ),
                Container(
                  padding: screenStretch > 3.0 ? EdgeInsets.all(0.0) : EdgeInsets.only(top: heightContainer / 4),
                  height: heightContainer,
                  child: Column(
                    children: <Widget>[
                      SvgPicture.asset('assets/images/coronavirus.svg',
                        width: 100,
                        height: 100,
                      ),
                      Text('Covid App',
                        style: TextStyle(
                          fontFamily: 'Avalon',
                          color: HexColor('5839ae'),
                          fontSize: 28.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Text('Coronavirus',
                          style: TextStyle(
                            fontFamily: 'Avalon',
                            color: HexColor('5839ae'),
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: heightContainer,
                  child: child,
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
        ),
      ),
    );
  }
}