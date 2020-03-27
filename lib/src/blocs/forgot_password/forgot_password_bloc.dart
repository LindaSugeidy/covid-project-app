import 'dart:async';
import 'package:covidapp/src/blocs/forgot_password/forgot_password_base.dart';
import 'package:covidapp/src/resources/authentication/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  AuthenticationRepository _authenticationRepository;

  ForgotPasswordBloc({@required AuthenticationRepository authenticationRepository,})  
    : assert(authenticationRepository != null),
      _authenticationRepository = authenticationRepository;

  @override
  ForgotPasswordState get initialState => ForgotPasswordState.initial();

  @override
  Stream<ForgotPasswordState> transformEvents(
      Stream<ForgotPasswordEvent> events,
      Stream<ForgotPasswordState> Function(ForgotPasswordEvent event) next) {
    final observableStream = events as Observable<ForgotPasswordEvent>;
    final nonDebounceStream = observableStream.where((event) {
      return (event is! ForgotPasswordEmailChanged);
    });
    final debounceStream = observableStream.where((event) {
      return (event is ForgotPasswordEmailChanged);
    }).debounceTime(Duration(microseconds: 300));
    return super
        .transformEvents(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<ForgotPasswordState> mapEventToState(ForgotPasswordEvent event) async* {
    if (event is ForgotPasswordEmailChanged) {
      yield* _mapForgotPasswordEmailChangedToState(event.email);
    } else if (event is ForgotPasswordPressed) {
      yield* _mapForgotPasswordPressedToState(event.email);
    }
  }

  Stream<ForgotPasswordState> _mapForgotPasswordEmailChangedToState(String email) async* {
    yield state.update(isEmailValid: _isValidEmail(email));
  }

  Stream<ForgotPasswordState> _mapForgotPasswordPressedToState(String email) async* {
    yield ForgotPasswordState.loadInProgress();
    try {
      await _authenticationRepository.forgotPassword(email);
      yield ForgotPasswordState.success();
    } catch (_) {
      yield ForgotPasswordState.failure();
    }
  }

  bool _isValidEmail(String email) {
    final RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
    return emailRegExp.hasMatch(email);
  }
}