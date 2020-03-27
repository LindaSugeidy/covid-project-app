import 'package:covidapp/src/models/user.dart';
import 'package:covidapp/src/resources/authentication/authentication_repository.dart';
import 'package:covidapp/src/blocs/authentication/authentication_base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  final User _user;
  final AuthenticationRepository _authenticationRepository;

  HomeScreen({Key key, @required AuthenticationRepository authenticationRepository, @required User user})
    : assert(authenticationRepository != null),
      assert(user != null),
      _authenticationRepository = authenticationRepository,
      _user = user,
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Covid Project'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 100),
        child: Center(
          child: Column(
            children: <Widget>[
              Text('${_user.email}'),
              RaisedButton(
                child: Text('Sign Out'),
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(
                    AuthenticationEvent.AuthenticationLoggedOut,
                  );
                },
              )
            ],
          ),
        ),
      )
    );
  }
}