import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Text(
              "Por favor completa tu información",
              style: TextStyle(fontSize: 25.0),
              textAlign: TextAlign.center,
            ),
            _createTextFormField(
                text: "Nombre completo",
                controller: nameController,
                autofocus: true),
            _createEmailTextFormField(
                text: "Email", controller: emailController),
            _createTextFormField(
                text: "Edad",
                keyboardType: TextInputType.number,
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly]),
            RaisedButton.icon(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  print("${nameController.text}");
                }
              },
              icon: Icon(Icons.save),
              label: Text("Guardar"),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField _createTextFormField(
      {String text,
      TextEditingController controller,
      bool autofocus = false,
      TextInputType keyboardType = TextInputType.text,
      List<TextInputFormatter> inputFormatters,
      Function validator}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: text,
      ),
      autofocus: autofocus,
      validator: validator ??
          (value) {
            if (value.isEmpty) {
              return "No puede ser vacío";
            }
            return null;
          },
      inputFormatters: inputFormatters,
    );
  }

  TextFormField _createEmailTextFormField(
      {String text, TextEditingController controller}) {
    return TextFormField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: text,
        ),
        validator: _isValidEmail);
  }

  String _isValidEmail(String email) {
    if (email == null || email.isEmpty) return "El email no puede ser vacio";
    final RegExp emailRegExp = RegExp(
        r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
    return emailRegExp.hasMatch(email) ? null : "El email no es válido";
  }
}
