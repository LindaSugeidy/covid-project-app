import 'package:covidapp/src/blocs/authentication/authentication_base.dart';
import 'package:covidapp/src/blocs/profile/profile_base.dart';
import 'package:covidapp/src/core/custom_localization.dart';
import 'package:covidapp/src/core/db_keys.dart';
import 'package:covidapp/src/resources/authentication/authentication_repository.dart';
import 'package:covidapp/src/resources/db/db_repository.dart';
import 'package:covidapp/src/resources/db/hive_repository_impl.dart';
import 'package:covidapp/src/resources/profile/profile_repository_impl.dart';
import 'package:covidapp/src/ui/screens/country_selector/country_selector_screen.dart';
import 'package:covidapp/src/ui/screens/home/home_screen.dart';
import 'package:covidapp/src/ui/screens/splash/splash_screen.dart';
import 'package:covidapp/src/ui/screens/wellcome/wellcome_screen.dart';
import 'package:covidapp/src/ui/widgets/hex_color.dart';
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
    return BlocProvider<ProfileBloc>(
      create: (BuildContext context) => ProfileBloc(
        profileRepository: ProfileRepositoryImpl(
            authenticationRepository: _authenticationRepository),
      ),
      child: MaterialApp(
        theme: ThemeData(
           fontFamily: 'Futura',
          brightness: Brightness.light,
          primaryColor: HexColor('6244b3'),
          buttonColor: HexColor('6244b3'),
          accentColor: Colors.cyanAccent[400],
          indicatorColor: Colors.cyanAccent[200],
          backgroundColor: HexColor('f6eeff'),
          textTheme: TextTheme(
            body1: TextStyle(color: Color(0xff6345B4)),
          ),
        ),
        supportedLocales: [Locale('es', 'MX'), Locale('en', 'US')],
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
            if (state is AuthenticationInitial) {
              return SplashScreen();
            }

            if (state is AuthenticationFailure) {
              return WellcomeScreen(
                  authenticationRepository: _authenticationRepository);
            }

            if (state is AuthenticationSuccess) {
              DbRepository dbRepository =
                  HiveRepositoryImpl(tableName: DbKeys.covidDb.toString());
              String emailUser = state.user.email;
              if (_isFirstTime(dbRepository, emailUser)) {
                return CountrySelectorScreen(
                  dbRepository: dbRepository,
                  authenticationRepository: _authenticationRepository,
                );
              } else {
                return HomeScreen(
                  authenticationRepository: _authenticationRepository,
                  user: state.user,
                  dbRepository: dbRepository,
                );
              }
            }
            return SplashScreen();
          },
        ),
      ),
    );
  }

  bool _isFirstTime(DbRepository dbRepository, String email) {
    if (dbRepository.get(DbKeys.firstTime.toString()) == null ||
        dbRepository.get(DbKeys.emailUser.toString()) != email) {
      return true;
    }
    return false;
  }
}
