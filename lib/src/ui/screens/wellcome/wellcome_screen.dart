import 'package:covidapp/src/core/custom_localization.dart';
import 'package:covidapp/src/resources/authentication/authentication_repository.dart';
import 'package:covidapp/src/ui/screens/sign_in/sign_in_screen.dart';
import 'package:covidapp/src/ui/screens/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WellcomeScreen extends StatelessWidget {
  final AuthenticationRepository _authenticationRepository;

  WellcomeScreen({ Key key, AuthenticationRepository authenticationRepository })
    : assert(authenticationRepository != null),
      _authenticationRepository = authenticationRepository,
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 100),
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text('Covid App',
                  style: TextStyle(
                    fontFamily: 'Modak',
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 0, left: 10, bottom: 50, right: 10),
                child: SvgPicture.asset(
                    'assets/logo.svg',
                    semanticsLabel: 'Covid App',
                    height: MediaQuery.of(context).size.height / 3,
                ),
              ),
              _button(
                context: context,
                text: CustomLocalization.of(context).translate('wellcome_button_sign_in'),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return SignInScreen(authenticationRepository: _authenticationRepository);
                  }));
                }
              ),
              _button(
                context: context,
                text: CustomLocalization.of(context).translate('wellcome_button_sign_up'),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen(authenticationRepository: _authenticationRepository);
                  }));
                }
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _button({BuildContext context, String text, Function onPressed}) {
    return RaisedButton(
      child: Container(
        height: 32,
        width: 256,
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Center(
            child: Text(text,
              style: TextStyle(
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