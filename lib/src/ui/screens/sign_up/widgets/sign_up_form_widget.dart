import 'package:covidapp/src/blocs/authentication/authentication_base.dart';
import 'package:covidapp/src/blocs/sign_up/sign_up_base.dart';
import 'package:covidapp/src/ui/widgets/app_snack_bar/app_sback_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpFormWidget extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  SignUpFormWidget({Key key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final SignUpBloc signUpBloc = BlocProvider.of<SignUpBloc>(context);

    _emailController.addListener(() {
      signUpBloc.add(SignUpEmailChanged(email: _emailController.text));
    });
    _passwordController.addListener(() {
      signUpBloc.add(SignUpPasswordChanged(password: _passwordController.text));
    });

    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if(state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context)
            .add(AuthenticationEvent.AuthenticationLoggedIn);
          
          Navigator.of(context).pop();
          return;
        }

        AppSnackBarHandler appSnackBarHandler = AppSnackBarHandler(context);

        if(state.isFailure) {
          appSnackBarHandler.showSnackBar(AppSnackBarWidget.failure(text: 'Failure Sign Up'));
        }

        if(state.isSubmitting) {
          appSnackBarHandler.showSnackBar(AppSnackBarWidget.load(text: 'Signining Up...'));
        }
      },
      child: BlocBuilder<SignUpBloc, SignUpState>(
        builder: (context, state) {
          return Form(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    labelText: 'Email',
                  ),
                  autovalidate: true,
                  autocorrect: false,
                  validator: (_) {
                    return !state.isEmailValid
                        ? 'Email is invalid.'
                        : null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  autovalidate: true,
                  autocorrect: false,
                  validator: (_) {
                    return !state.isPasswordValid
                        ? 'Password is invalid.'
                        : null;
                  },
                ),
                RaisedButton(
                  child: Text('Sign Up'),
                  onPressed: () {
                    if(_isSignInButtonEnabled(state)) {
                      signUpBloc.add(SignUpSubmitted(
                        email: _emailController.text,
                        password: _passwordController.text,
                      ));
                    }                    
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }

  bool get _isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool _isSignInButtonEnabled(SignUpState state) {
    return state.isFormValid && _isPopulated && !state.isSubmitting;
  }
}