import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();
}

class ForgotPasswordEmailChanged extends ForgotPasswordEvent {
  final String email;

  ForgotPasswordEmailChanged({@required this.email});

  @override
  String toString() => '$runtimeType { email :$email }';

  @override
  List<Object> get props => [email];
}

class ForgotPasswordSubmitted extends ForgotPasswordEvent {
  final String email;

  ForgotPasswordSubmitted({@required this.email});

  @override
  String toString() => '$runtimeType { email: $email }';

  @override
  List<Object> get props => [email];
}

class ForgotPasswordPressed extends ForgotPasswordEvent {
  final String email;

  ForgotPasswordPressed({@required this.email});

  @override
  String toString() => '$runtimeType { email: $email }';

  @override
  List<Object> get props => [email];
}
