import 'package:country_code_picker/country_code_picker.dart';
import 'package:covidapp/src/core/db_keys.dart';
import 'package:covidapp/src/resources/authentication/authentication_repository.dart';
import 'package:covidapp/src/resources/db/db_repository.dart';
import 'package:covidapp/src/ui/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class CountrySelectorScreen extends StatelessWidget {
  final DbRepository _dbRepository;
  final AuthenticationRepository _authenticationRepository;
  final String initialCountry = "México";
  final String initialCountryCode = "MX";

  CountrySelectorScreen({
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
    String _country = initialCountry;
    String _countryCode = initialCountryCode;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Center(
              child: Text(
                "Selecciona tu país de residencia",
                style: TextStyle(
                  fontSize: 30.0,
                  height: 2,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffC3BFC7)),
                borderRadius: BorderRadius.circular(18.0),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 25.0, 8.0),
                child: CountryCodePicker(
                  onChanged: (b) {
                    _country = b.name;
                    _countryCode = b.code;
                  },
                  initialSelection: initialCountryCode,
                  showCountryOnly: true,
                  showFlagMain: true,
                  flagWidth: (MediaQuery.of(context).size.aspectRatio * 200)
                      .truncateToDouble(),
                  showOnlyCountryWhenClosed: true,
                  favorite: [initialCountryCode, 'ES'],
                ),
              ),
            ),
            RaisedButton.icon(
              onPressed: () =>
                  _navigateToProfile(_country, _countryCode, context),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0)),
              icon: Icon(Icons.navigate_next),
              label: Text("Continuar"),
            )
          ],
        ),
      ),
    );
  }

  void _saveCountry(String country, String countryCode) {
    _dbRepository.put(DbKeys.countryUser.toString(), country);
    _dbRepository.put(DbKeys.countryCodeUser.toString(), countryCode);
    print(
        "${_dbRepository.get(DbKeys.countryCodeUser.toString())} ${_dbRepository.get(DbKeys.countryUser.toString())}");
  }

  void _navigateToProfile(
      String country, String countryCode, BuildContext context) {
    _saveCountry(country, countryCode);
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return ProfileScreen(
          dbRepository: _dbRepository,
          authenticationRepository: _authenticationRepository,
        );
      }),
    );
  }
}
