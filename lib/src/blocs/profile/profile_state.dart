import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileSaveInProgress extends ProfileState {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class ProfileInProgress extends ProfileState {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class ProfileSaveSuccess extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileFailure extends ProfileState {
  @override
  List<Object> get props => [];
}
