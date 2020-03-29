import 'package:country_code_picker/country_code_picker.dart';
import 'package:covidapp/src/core/db_keys.dart';
import 'package:covidapp/src/resources/db/db_repository.dart';
import 'package:covidapp/src/ui/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class CountrySelectorScreen extends StatelessWidget {
  final DbRepository _dbRepository;
  final String initialCountry = "México";
  final String initialCountryCode = "MX";

  CountrySelectorScreen({Key key, @required DbRepository dbRepository})
      : assert(dbRepository != null),
        _dbRepository = dbRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    String _country = initialCountry;
    String _countryCode = initialCountryCode;
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
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(18.0),
                color: Colors.grey[100],
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
        );
      }),
    );
  }
}
