import 'package:covidapp/src/blocs/forgot_password/forgot_password_base.dart';
import 'package:covidapp/src/resources/authentication/authentication_repository.dart';
import 'package:covidapp/src/ui/screens/forgot_password/widgets/forgot_password_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPassword extends  StatelessWidget {
  final AuthenticationRepository _authenticationRepository;

  ForgotPassword({Key key, @required AuthenticationRepository authenticationRepository})
    : assert(authenticationRepository != null),
      _authenticationRepository = authenticationRepository,
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: BlocProvider<ForgotPasswordBloc>(
          create: (context) => ForgotPasswordBloc(authenticationRepository: _authenticationRepository),
          child: ForgotPasswordFormWidget(),
        ),
      ),
    );
  }
}