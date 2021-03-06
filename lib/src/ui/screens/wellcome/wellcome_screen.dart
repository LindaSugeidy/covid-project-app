import 'package:covidapp/src/core/custom_localization.dart';
import 'package:covidapp/src/resources/authentication/authentication_repository.dart';
import 'package:covidapp/src/ui/screens/sign_in/sign_in_screen.dart';
import 'package:covidapp/src/ui/screens/sign_up/sign_up_screen.dart';
import 'package:covidapp/src/ui/widgets/app_raised_rounded_button/app_raised_rounded_button_widget.dart';
import 'package:covidapp/src/ui/widgets/app_scaffold/app_scaffold_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WellcomeScreen extends StatelessWidget {
  final AuthenticationRepository _authenticationRepository;

  WellcomeScreen({ Key key, AuthenticationRepository authenticationRepository })
    : assert(authenticationRepository != null),
      _authenticationRepository = authenticationRepository,
      super(key: key);

  @override
  Widget build(BuildContext context) {

    return AppScaffoldWidget(
      child: Column(
        children: <Widget>[
          AppRaisedRoundedButtonWidget(
              text: CustomLocalization.of(context).translate('wellcome_button_sign_in'),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return SignInScreen(authenticationRepository: _authenticationRepository);
                    }));
              }
          ),
          AppRaisedRoundedButtonWidget(
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
    );
  }
}