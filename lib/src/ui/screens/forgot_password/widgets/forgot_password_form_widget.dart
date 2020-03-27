import 'package:covidapp/src/blocs/authentication/authentication_base.dart';
import 'package:covidapp/src/blocs/forgot_password/forgot_password_base.dart';
import 'package:covidapp/src/ui/widgets/app_snack_bar/app_sback_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordFormWidget extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  ForgotPasswordFormWidget({Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final ForgotPasswordBloc forgotPasswordBloc = BlocProvider.of<ForgotPasswordBloc>(context);

    _emailController.addListener(() {
      forgotPasswordBloc.add(ForgotPasswordEmailChanged(email: _emailController.text));
    });

    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context)
              .add(AuthenticationEvent.AuthenticationLoggedIn);
          Navigator.of(context).pop();
        }

        AppSnackBarHandler appSnackBarHandler = AppSnackBarHandler(context);

        if(state.isFailure) {
          appSnackBarHandler.showSnackBar(AppSnackBarWidget.failure(text: 'Failure forgot password.'));
        }

        if(state.isSubmitting) {
          appSnackBarHandler.showSnackBar(AppSnackBarWidget.load(text: 'Recovering...'));
        }
      },
      child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
        builder: (context, state) {
          return Form(
            child: Column(children: <Widget>[
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
              RaisedButton(
                child: Text('Forgot Password'),
                onPressed: () {
                  if(_isForgotPasswordButtonEnabled(state)) {
                    forgotPasswordBloc.add(ForgotPasswordPressed(email: _emailController.text));
                  }
                },
              )
            ]),
          );
        },
      ),
    );
  }

  bool get _isPopulated => _emailController.text.isNotEmpty;

  bool _isForgotPasswordButtonEnabled(ForgotPasswordState state) {
    return state.isFormValid && _isPopulated && !state.isSubmitting;
  }
}