import 'package:covidapp/src/resources/authentication/authentication_repository.dart';
import 'package:covidapp/src/resources/db/db_repository.dart';
import 'package:covidapp/src/ui/screens/profile/widgets/profile_form.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class ProfileScreen extends StatelessWidget {
  final DbRepository _dbRepository;
  final AuthenticationRepository _authenticationRepository;

  ProfileScreen({
    Key key,
    @required DbRepository dbRepository,
    AuthenticationRepository authenticationRepository,
  })  : assert(dbRepository != null),
        assert(authenticationRepository != null),
        _dbRepository = dbRepository,
        _authenticationRepository = authenticationRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView(
        children: <Widget>[
          ProfileForm(
            dbRepository: _dbRepository,
            authenticationRepository: _authenticationRepository,
          ),
        ],
      ),
    );
  }
}
