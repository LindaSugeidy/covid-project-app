import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarWidget extends PreferredSize {
  AppBarWidget({
    Key key,
    @required Size preferredSize,
  }) : super(
    key: key,
    preferredSize: preferredSize,
    child: _AppBarInternalWidget(),
  );
}

class _AppBarInternalWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            bottomLeft: const Radius.circular(40.0),
            bottomRight: const Radius.circular(40.0)
        ),
      ),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10.0, left: 20.0),
            child: Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/man.png'),
                  )
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 35.0, left: 50.0),
            child: Column(
              children: <Widget>[
                Text('Covid App',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.purple,
                  ),
                ),
                Text('Coronavirus',
                  style: TextStyle(
                    color: Colors.purple,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0, left: 30.0),
            child: Container(
              child: Row(
                children: <Widget>[
                  Text('MX',
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.grey,
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/images/world.svg',
                    width: 30.0,
                    height: 30.0,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}