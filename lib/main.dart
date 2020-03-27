import 'package:bloc/bloc.dart';
import 'package:covidapp/src/app.dart';
import 'package:covidapp/src/blocs/authentication/authentication_base.dart';
import 'package:covidapp/src/blocs/base_bloc_delegate.dart';
import 'package:covidapp/src/resources/authentication/authentication_repository.dart';
import 'package:covidapp/src/resources/authentication/authentication_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  BlocSupervisor.delegate = BaseBlocDelegate();
  final AuthenticationRepository authenticationRepository = AuthenticationRepositoryImpl();

  runApp(
      BlocProvider<AuthenticationBloc>(
        create: (context) =>
        AuthenticationBloc(authenticationRepository: authenticationRepository)
          ..add(AuthenticationEvent.AuthenticationAppStarted),
        child: App(authenticationRepository: authenticationRepository),
      )
  );
}