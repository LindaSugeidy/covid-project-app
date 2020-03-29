import 'dart:async';
import 'package:covidapp/src/blocs/sign_up/sign_up_base.dart';
import 'package:covidapp/src/resources/authentication/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthenticationRepository _authenticationRepository;

  SignUpBloc({@required AuthenticationRepository authenticationRepository})
      : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository;

  @override
  SignUpState get initialState => SignUpState.initial();

  @override
  Stream<SignUpState> transformEvents(
    Stream<SignUpEvent> events,
    Stream<SignUpState> Function(SignUpEvent event) next,
  ) {
    final observableStream = events;
    final nonDebounceStream = observableStream.where((event) {
      return (event is! SignUpEmailChanged && event is! SignUpPasswordChanged);
    });
    final debounceStream = observableStream.where((event) {
      return (event is SignUpEmailChanged || event is SignUpPasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super
        .transformEvents(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUpEmailChanged) {
      yield* _mapSignUpEmailChangedToState(event.email);
    } else if (event is SignUpPasswordChanged) {
      yield* _mapSignUpPasswordChangedToState(event.password);
    } else if (event is SignUpSubmitted) {
      yield* _mapFormSubmittedToState(event.email, event.password);
    }
  }

  Stream<SignUpState> _mapSignUpEmailChangedToState(String email) async* {
    yield state.update(isEmailValid: _isValidEmail(email));
  }

  Stream<SignUpState> _mapSignUpPasswordChangedToState(String password) async* {
    yield state.update(isPasswordValid: _isValidPassword(password));
  }

  Stream<SignUpState> _mapFormSubmittedToState(String email, String password) async* {
    yield SignUpState.loadInProgress();
    try {
      await _authenticationRepository.signUp(email, password);
      yield SignUpState.success();
    } catch (_) {
      yield SignUpState.failure();
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
