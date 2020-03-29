import 'package:bloc/bloc.dart';
import 'package:covidapp/src/app.dart';
import 'package:covidapp/src/blocs/authentication/authentication_base.dart';
import 'package:covidapp/src/blocs/base_bloc_delegate.dart';
import 'package:covidapp/src/core/db_keys.dart';
import 'package:covidapp/src/resources/authentication/authentication_repository.dart';
import 'package:covidapp/src/resources/authentication/authentication_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await Hive.initFlutter();
  await Hive.openBox(DbKeys.covidDb.toString());

  BlocSupervisor.delegate = BaseBlocDelegate();
  final AuthenticationRepository authenticationRepository =
      AuthenticationRepositoryImpl();

  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context) =>
          AuthenticationBloc(authenticationRepository: authenticationRepository)
            ..add(AuthenticationEvent.AuthenticationAppStarted),
      child: App(authenticationRepository: authenticationRepository),
    ),
  );
}
