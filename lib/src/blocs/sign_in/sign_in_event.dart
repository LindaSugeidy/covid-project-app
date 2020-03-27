// This file has been written trying to follow the naming conventions for blocs

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SignInEvent extends Equatable {
  const SignInEvent();
}

class SignInEmailChanged extends SignInEvent {
  final String email;

  SignInEmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => '$runtimeType { email: $email }';
}

class SignInPasswordChanged extends SignInEvent {
  final String password;

  SignInPasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => '$runtimeType { password: $password }';
}

class SignInSubmitted extends SignInEvent {
  final String email;
  final String password;

  SignInSubmitted({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];

  @override
  String toString() {
    return '$runtimeType { email: $email, password: $password }';
  }
}

class SignInPressed extends SignInEvent {
  final String email;
  final String password;

  SignInPressed({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];

  @override
  String toString() {
    return '$runtimeType { email: $email, password: $password }';
  }
}
