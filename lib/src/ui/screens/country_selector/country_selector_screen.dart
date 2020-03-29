import 'package:country_code_picker/country_code_picker.dart';
import 'package:covidapp/src/core/db_keys.dart';
import 'package:covidapp/src/resources/db/db_repository.dart';
import 'package:covidapp/src/ui/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class CountrySelectorScreen extends StatelessWidget {
  final DbRepository _dbRepository;

  CountrySelectorScreen({Key key, @required DbRepository dbRepository})
      : assert(dbRepository != null),
        _dbRepository = dbRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    String _country;
    String _countryCode;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Center(
              child: Text(
                "Selecciona tu país de nacimiento",
                style: TextStyle(fontSize: 30.0),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CountryCodePicker(
                onInit: (b) {
                  _country = b.name;
                  _countryCode = b.code;
                },
                onChanged: (b) {
                  _country = b.name;
                  _countryCode = b.code;
                },
                initialSelection: "MX",
                showCountryOnly: true,
                showFlagMain: true,
                flagWidth: (MediaQuery.of(context).size.aspectRatio * 200)
                    .truncateToDouble(),
                showOnlyCountryWhenClosed: true,
                favorite: ['MX', 'ES'],
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
        );
      }),
    );
  }
}
