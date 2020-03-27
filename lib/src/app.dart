import 'package:covidapp/src/blocs/authentication/authentication_base.dart';
import 'package:covidapp/src/core/custom_localization.dart';
import 'package:covidapp/src/resources/authentication/authentication_repository.dart';
import 'package:covidapp/src/ui/screens/home/home_screen.dart';
import 'package:covidapp/src/ui/screens/splash/splash_screen.dart';
import 'package:covidapp/src/ui/screens/wellcome/wellcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  final AuthenticationRepository _authenticationRepository;

  App({Key key, @required AuthenticationRepository authenticationRepository})
    : assert(authenticationRepository != null),
      _authenticationRepository = authenticationRepository,
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        accentColor: Colors.blueAccent,
        indicatorColor: Colors.blueGrey
      ),
      supportedLocales: [Locale('es', 'MX')],
      localizationsDelegates: [
        CustomLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if(state is AuthenticationInitial) {
            return SplashScreen();
          }

          if(state is AuthenticationFailure) {
            return WellcomeScreen(authenticationRepository: _authenticationRepository);
          }

          if(state is AuthenticationSuccess) {
            return HomeScreen(authenticationRepository: _authenticationRepository,user: state.user);
          }

          return SplashScreen();
        },
      ),
    );
  }
}