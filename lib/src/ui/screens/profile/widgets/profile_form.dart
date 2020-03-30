import 'package:covidapp/src/blocs/profile/profile_base.dart';
import 'package:covidapp/src/core/db_keys.dart';
import 'package:covidapp/src/models/profile.dart';
import 'package:covidapp/src/models/user.dart';
import 'package:covidapp/src/resources/authentication/authentication_repository.dart';
import 'package:covidapp/src/resources/db/db_repository.dart';
import 'package:covidapp/src/ui/screens/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gender_picker/gender_picker.dart';
import 'package:gender_picker/source/enums.dart';

class ProfileForm extends StatelessWidget {
  final DbRepository _dbRepository;
  final AuthenticationRepository _authenticationRepository;

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final zipController = TextEditingController();
  final stateController = TextEditingController();
  final townController = TextEditingController();

  ProfileForm({
    Key key,
    @required DbRepository dbRepository,
    AuthenticationRepository authenticationRepository,
  })  : assert(dbRepository != null),
        assert(authenticationRepository != null),
        _dbRepository = dbRepository,
        _authenticationRepository = authenticationRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    ProfileBloc profileBloc = BlocProvider.of<ProfileBloc>(context);
    String _gender;
    Profile _profile;
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileSaveSuccess) {
          _navigateToProfile(context, _profile.email);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 60.0, right: 60.0, top: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(
                "Por favor completa tu información",
                style: TextStyle(
                    fontSize: 25.0, height: 1.5, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20.0,
              ),
              _createTextFormField(
                text: "Nombre completo",
                controller: nameController,
                autofocus: true,
              ),
              Divider(),
              _createNumberTextFormField(
                text: "Edad",
                controller: ageController,
              ),
              GenderPickerWithImage(
                maleText: "Hombre",
                femaleText: "Mujer",
                verticalAlignedText: true,
                selectedGender: null,
                selectedGenderTextStyle: TextStyle(
                  color: Color(0xFF6345B4),
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
                unSelectedGenderTextStyle: TextStyle(
                  color: Color(0xFF6345B4),
                  fontWeight: FontWeight.normal,
                  fontSize: 25,
                ),
                onChanged: (Gender gender) {
                  _gender = gender.toString();
                },
                //Alignment between icons
                equallyAligned: true,
                animationDuration: Duration(milliseconds: 400),
                opacityOfGradient: 0.2,
                padding: const EdgeInsets.fromLTRB(55, 0, 15, 30),
                size: 100, //default : 40
              ),
              _createTextFormField(
                text: "Código Postal",
                controller: zipController,
                keyboardType: TextInputType.number,
              ),
              Divider(),
              _createTextFormField(
                text: "Estado",
                controller: stateController,
              ),
              Divider(),
              _createTextFormField(
                text: "Delegación / Municipio",
                controller: townController,
                autofocus: true,
              ),
              SizedBox(
                height: 30.0,
              ),
              RaisedButton.icon(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    if (_gender == null) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red[300],
                          content: Text("Por favor seleccione un sexo.")));
                    } else {
                      _profile = await _buildProfile(_gender);
                      _save(_profile, profileBloc);
                    }
                  }
                },
                icon: Icon(Icons.save),
                label: Text("Guardar"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _save(Profile profile, ProfileBloc profileBloc) {
    print(profile.toJson());
    profileBloc.add(ProfileSavePressed(profile: profile));
  }

  void _navigateToProfile(BuildContext context, String emailUser) {
    _dbRepository.put(DbKeys.firstTime.toString(), false);
    _dbRepository.put(DbKeys.emailUser.toString(), emailUser);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) {
        return HomeScreen(
          dbRepository: _dbRepository,
          authenticationRepository: _authenticationRepository,
          user: User(email: emailUser),
        );
      }),
    );
  }

  Future<Profile> _buildProfile(String gender) async {
    User user = await _authenticationRepository.getCurrentUser();
    Profile profile = Profile(
      uid: user.id,
      email: user.email,
      name: nameController.text,
      age: num.tryParse(ageController.text),
      gender: gender,
      zip: zipController.text,
      state: stateController.text,
      town: townController.text,
      country: _dbRepository.get(DbKeys.countryUser.toString()),
      idCountry: _dbRepository.get(DbKeys.countryCodeUser.toString()),
    );
    return profile;
  }

  TextFormField _createTextFormField(
      {String text,
      TextEditingController controller,
      bool autofocus = false,
      TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: text,
        filled: true,
        fillColor: Colors.white,
      ),
      autofocus: autofocus,
      validator: _isValidEmpty,
    );
  }

/*
  TextFormField _createEmailTextFormField(
      {String text, TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: text,
        filled: true,
        fillColor: Colors.white,
      ),
      validator: _isValidEmail,
    );
  }*/

  TextFormField _createNumberTextFormField(
      {String text, TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: text,
        filled: true,
        fillColor: Colors.white,
      ),
      validator: _isValidAge,
      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
    );
  }

  /*String _isValidEmail(String email) {
    if (email == null || email.isEmpty) return "El email no puede ser vacio";
    final RegExp emailRegExp = RegExp(
        r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
    return emailRegExp.hasMatch(email) ? null : "El email no es válido";
  }*/

  String _isValidAge(String age) {
    String empty = _isValidEmpty(age);
    if (empty != null) {
      return empty;
    }
    num ageNumber = num.tryParse(age);
    if (ageNumber < 10) {
      return "La edad no es valida para realizar el test";
    }
    return null;
  }

  String _isValidEmpty(String value) {
    if (value.isEmpty) {
      return "No puede ser vacío";
    }
    return null;
  }
}
