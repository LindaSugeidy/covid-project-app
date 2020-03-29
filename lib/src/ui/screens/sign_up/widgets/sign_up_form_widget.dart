import 'package:covidapp/src/blocs/authentication/authentication_base.dart';
import 'package:covidapp/src/blocs/sign_up/sign_up_base.dart';
import 'package:covidapp/src/core/custom_localization.dart';
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
          appSnackBarHandler.showSnackBar(AppSnackBarWidget.failure(
              text: CustomLocalization.of(context).translate('sign_up_snackbar_failure'),
          ));
        }

        if(state.isSubmitting) {
          appSnackBarHandler.showSnackBar(AppSnackBarWidget.load(
              text: CustomLocalization.of(context).translate('sign_up_snackbar_loading'),
          ));
        }
      },
      child: BlocBuilder<SignUpBloc, SignUpState>(
        builder: (context, state) {
          return Form(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    labelText: CustomLocalization.of(context).translate('sign_up_placeholder_email'),
                  ),
                  autovalidate: true,
                  autocorrect: false,
                  validator: (_) {
                    return !state.isEmailValid
                        ? CustomLocalization.of(context).translate('sign_up_label_error_email')
                        : null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText: CustomLocalization.of(context).translate('sign_up_placeholder_password'),
                  ),
                  obscureText: true,
                  autovalidate: true,
                  autocorrect: false,
                  validator: (_) {
                    return !state.isPasswordValid
                        ? CustomLocalization.of(context).translate('sign_up_label_error_password')
                        : null;
                  },
                ),
                RaisedButton(
                  child: Text(CustomLocalization.of(context).translate(
                      'sign_up_button_sign_up')),
                  onPressed: _isSignInButtonEnabled(state) ? () =>
                      _onFormSubmitted(signUpBloc) : null,
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

  void _onFormSubmitted(SignUpBloc signUpBloc) {
    signUpBloc.add(SignUpSubmitted(
      email: _emailController.text,
      password: _passwordController.text,
    ));
  }
}