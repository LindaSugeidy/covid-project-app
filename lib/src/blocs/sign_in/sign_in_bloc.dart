import 'dart:async';
import 'package:covidapp/src/blocs/sign_in/sign_in_base.dart';
import 'package:covidapp/src/resources/authentication/authentication_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  AuthenticationRepository _authenticationRepository;

  SignInBloc({ @required AuthenticationRepository authenticationRepository })  
    : assert(authenticationRepository != null),
      _authenticationRepository = authenticationRepository;

  @override
  SignInState get initialState => SignInState.initial();

  @override
  Stream<SignInState> transformEvents(
    Stream<SignInEvent> events,
    Stream<SignInState> Function(SignInEvent event) next,
  ) {
    final observableStream = events;
    final nonDebounceStream = observableStream.where((event) {
      return (event is! SignInEmailChanged && event is! SignInPasswordChanged);
    });
    final debounceStream = observableStream.where((event) {
      return (event is SignInEmailChanged || event is SignInPasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    if (event is SignInEmailChanged) {
      yield* _mapSignInEmailChangedToState(event.email);
    } else if (event is SignInPasswordChanged) {
      yield* _mapSignInPasswordChangedToState(event.password);
    } else if (event is SignInPressed) {
      yield* _mapSignInPressedToState(event.email, event.password);
    }
  }

  Stream<SignInState> _mapSignInEmailChangedToState(String email) async* {
    yield state.update(isEmailValid: _isValidEmail(email));
  }

  Stream<SignInState> _mapSignInPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: _isValidPassword(password),
    );
  }

  Stream<SignInState> _mapSignInPressedToState(String email, String password) async* {
    yield SignInState.loadInProgress();
    try {
      await _authenticationRepository.signIn(email, password);
      yield SignInState.success();
    } catch (_) {
      yield SignInState.failure();
    }
  }

  bool _isValidEmail(String email) {
    final RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
    return emailRegExp.hasMatch(email);
  }

  bool _isValidPassword(String password) {
    final RegExp passwordRegExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
    return passwordRegExp.hasMatch(password);
  }
}