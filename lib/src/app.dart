import 'package:covidapp/src/blocs/authentication/authentication_base.dart';
import 'package:covidapp/src/core/custom_localization.dart';
import 'package:covidapp/src/core/db_keys.dart';
import 'package:covidapp/src/resources/authentication/authentication_repository.dart';
import 'package:covidapp/src/resources/db/db_repository.dart';
import 'package:covidapp/src/resources/db/hive_repository_impl.dart';
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
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'Futura',
          brightness: Brightness.light,
          primaryColor: HexColor('6244b3'),
          backgroundColor: HexColor('f6eeff'),
          buttonColor: HexColor('6244b3'),
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
            if (!_isFirstTime(dbRepository)) {
              return CountrySelectorScreen(
                dbRepository: dbRepository,
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
    );
  }

  bool _isFirstTime(DbRepository dbRepository) {
    print(DbKeys.covidDb.toString());
    if (dbRepository.get(DbKeys.firstTime.toString()) == null) {
      return true;
    }
    return false;
  }
}
