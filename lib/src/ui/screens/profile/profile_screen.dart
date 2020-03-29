import 'package:covidapp/src/resources/db/db_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class ProfileScreen extends StatelessWidget {
  final DbRepository _dbRepository;

  ProfileScreen({Key key, @required DbRepository dbRepository})
      : assert(dbRepository != null),
        _dbRepository = dbRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Profile"),
      ),
    );
  }
}