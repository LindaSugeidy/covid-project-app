import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class ForgotPasswordState extends Equatable {
  final bool isEmailValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isEmailValid;

  ForgotPasswordState({
    @required this.isEmailValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure
  });

  factory ForgotPasswordState.initial() {
    return ForgotPasswordState(
      isEmailValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false
    );
  }

  factory ForgotPasswordState.loadInProgress(){
    return ForgotPasswordState(
      isEmailValid: true,
      isSubmitting: true,
      isSuccess:  false,
      isFailure: false
    );
  }

  factory ForgotPasswordState.failure(){
    return ForgotPasswordState(
      isEmailValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: true
    );
  }

  factory ForgotPasswordState.success(){
    return ForgotPasswordState(
        isEmailValid: true,
        isSubmitting: true,
        isSuccess: true,
        isFailure: false
    );
  }

  ForgotPasswordState update({
    bool isEmailValid,
    bool isPasswordValid,
  }) {
    return copyWith(
      isEmailValid: isEmailValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  ForgotPasswordState copyWith({
    bool isEmailValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return ForgotPasswordState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() => 
    '$runtimeType { isEmailValid: $isEmailValid, isSubmitting: $isSubmitting, isSuccess: $isSuccess, isFailure: $isFailure }';

  @override
  List<Object> get props => [isEmailValid, isSubmitting, isSuccess, isFailure];
}