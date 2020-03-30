import 'package:covidapp/src/models/profile.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class ProfileStarted extends ProfileEvent {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class ProfileSavePressed extends ProfileEvent {
  final Profile profile;

  ProfileSavePressed({@required this.profile});

  @override
  List<Object> get props => [profile];

  @override
  bool get stringify => true;
}
