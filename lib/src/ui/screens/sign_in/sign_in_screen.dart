import 'package:covidapp/src/blocs/sign_in/sign_in_base.dart';
import 'package:covidapp/src/resources/authentication/authentication_repository.dart';
import 'package:covidapp/src/ui/screens/sign_in/widgets/sign_in_form_widget.dart';
import 'package:covidapp/src/ui/widgets/app_scaffold/app_scaffold_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SignInScreen extends StatelessWidget {
  final AuthenticationRepository _authenticationRepository;

  SignInScreen({Key key, @required AuthenticationRepository authenticationRepository})
      : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      screenStretch: 3.0,
      child: BlocProvider<SignInBloc>(
        create: (context) => SignInBloc(authenticationRepository: _authenticationRepository),
        child: SignInFormWidget(),
      ),
    );
  }
}