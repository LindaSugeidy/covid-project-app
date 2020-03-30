import 'package:covidapp/src/blocs/authentication/authentication_base.dart';
import 'package:covidapp/src/blocs/sign_in/sign_in_base.dart';
import 'package:covidapp/src/core/custom_localization.dart';
import 'package:covidapp/src/ui/widgets/app_raised_rounded_button/app_raised_rounded_button_widget.dart';
import 'package:covidapp/src/ui/widgets/app_snack_bar/app_sback_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInFormWidget extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  SignInFormWidget({Key key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final SignInBloc signInBloc = BlocProvider.of<SignInBloc>(context);

    _emailController.addListener(() {
      signInBloc.add(SignInEmailChanged(email: _emailController.text));
    });
    _passwordController.addListener(() {
      signInBloc.add(SignInPasswordChanged(password: _passwordController.text));
    });

    return BlocListener<SignInBloc, SignInState>(
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
              text: CustomLocalization.of(context).translate('sign_in_snackbar_failure'),
          ));
        }

        if(state.isSubmitting) {
          appSnackBarHandler.showSnackBar(AppSnackBarWidget.load(
              text: CustomLocalization.of(context).translate('sign_in_snackbar_loading'),
          ));
        }
      },
      child: BlocBuilder<SignInBloc, SignInState>(
        builder: (context, state) {
          return Form(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    labelText: CustomLocalization.of(context).translate('sign_in_placeholder_email'),
                  ),
                  autovalidate: true,
                  autocorrect: false,
                  validator: (_) {
                    return !state.isEmailValid
                        ? CustomLocalization.of(context).translate('sign_in_label_error_email')
                        : null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText: CustomLocalization.of(context).translate('sign_in_placeholder_password'),
                  ),
                  obscureText: true,
                  autovalidate: true,
                  autocorrect: false,
                  validator: (_) {
                    return !state.isPasswordValid
                        ? CustomLocalization.of(context).translate('sign_in_label_error_password')
                        : null;
                  },
                ),
                AppRaisedRoundedButtonWidget(
                  text: CustomLocalization.of(context).translate('sign_in_button_sign_in'),
                  onPressed: _isSignInButtonEnabled(state) ? () =>
                      signInBloc.add(SignInPressed(
                        email: _emailController.text,
                        password: _passwordController.text,
                      )) : null,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  bool get _isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool _isSignInButtonEnabled(SignInState state) {
    return state.isFormValid && _isPopulated && !state.isSubmitting;
  }
}