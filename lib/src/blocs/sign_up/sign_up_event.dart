// This file has been written trying to follow the naming conventions for blocs

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
}

class SignUpEmailChanged extends SignUpEvent {
  final String email;

  SignUpEmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => '$runtimeType { email: $email }';
}

class SignUpPasswordChanged extends SignUpEvent {
  final String password;

  SignUpPasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => '$runtimeType { password: $password }';
}

class SignUpSubmitted extends SignUpEvent {
  final String email;
  final String password;

  SignUpSubmitted({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];

  @override
  String toString() {
    return '$runtimeType { email: $email, password: $password }';
  }
}