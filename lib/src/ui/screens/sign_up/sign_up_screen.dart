import 'package:covidapp/src/blocs/sign_up/sign_up_base.dart';
import 'package:covidapp/src/resources/authentication/authentication_repository.dart';
import 'package:covidapp/src/ui/screens/sign_up/widgets/sign_up_form_widget.dart';
import 'package:covidapp/src/ui/widgets/app_scaffold/app_scaffold_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  final AuthenticationRepository _authenticationRepository;

  SignUpScreen({Key key, @required AuthenticationRepository authenticationRepository})
      : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      screenStretch: 3.0,
      child: BlocProvider<SignUpBloc>(
        create: (context) => SignUpBloc(authenticationRepository: _authenticationRepository),
        child: SignUpFormWidget(),
      ),
    );
  }
}