import 'dart:async';

import 'package:covidapp/src/models/user.dart';
import 'package:covidapp/src/resources/authentication/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'authentication_base.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;

  AuthenticationBloc({@required AuthenticationRepository authenticationRepository})
    : assert(authenticationRepository != null),
      _authenticationRepository = authenticationRepository;

  @override
  AuthenticationState get initialState => AuthenticationInitial();

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event == AuthenticationEvent.AuthenticationAppStarted) {
      yield* _mapAuthenticationAppStartedToState();
    } else if (event == AuthenticationEvent.AuthenticationLoggedIn) {
      yield* _mapAuthenticationLoggedInToState();
    } else if (event == AuthenticationEvent.AuthenticationLoggedOut) {
      yield* _mapAuthenticationLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationAppStartedToState() async* {
    try {
      final bool isSignedIn = await _authenticationRepository.isSignedIn();
      if(isSignedIn) {
        final User user = await _authenticationRepository.getCurrentUser();
        yield AuthenticationSuccess(user);
      } else {
        yield AuthenticationFailure();
      }
    } catch(_) {
      yield AuthenticationFailure();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationLoggedInToState() async* {
    User user = await _authenticationRepository.getCurrentUser();
    yield AuthenticationSuccess(user);
  }

  Stream<AuthenticationState> _mapAuthenticationLoggedOutToState() async* {
    _authenticationRepository.signOut();
    yield AuthenticationFailure();
  }
}
