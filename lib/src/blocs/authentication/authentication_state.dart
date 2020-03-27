// This file has been written trying to follow the naming conventions for blocs

import 'package:covidapp/src/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {
  @override
  String toString() => '$runtimeType';

  @override
  List<Object> get props => [];
}

class AuthenticationFailure extends AuthenticationState {
  @override
  String toString() => '$runtimeType';

  @override
  List<Object> get props => [];
}

class AuthenticationSuccess extends AuthenticationState {
  final User user;

  AuthenticationSuccess(this.user);

  @override
  String toString() => '$runtimeType { email: ${user.email} }';

  @override
  List<Object> get props => [user];
}