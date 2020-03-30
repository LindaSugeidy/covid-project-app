import 'dart:convert';
import 'dart:io';

import 'package:covidapp/src/models/profile.dart';
import 'package:covidapp/src/resources/authentication/authentication_repository.dart';
import 'package:covidapp/src/resources/profile/profile_repository.dart';
import 'package:http/http.dart' as http;

class ProfileRepositoryImpl implements ProfileRepository {
  final AuthenticationRepository _authenticationRepository;

  ProfileRepositoryImpl({AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository;

  @override
  Future<Profile> get({String uid}) {
    return null;
  }

  @override
  Future save({Profile profile}) async {
    final String url =
        'https://us-central1-covid-project-2020.cloudfunctions.net/api/profiles/${profile.uid}';
    String jsonEcondeText = jsonEncode(profile);
    print("jsonEncode(profile): $jsonEcondeText");
    print("jsonEncode(profile.toJson()): ${jsonEncode(profile.toJson())}");
    final response = await http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader:
            await _authenticationRepository.getCurrentToken()
      },
      body: jsonEcondeText,
    );
    print("ProfileRepositoryImpl SAVE response.body: ${response.body}");
    final responseJson = json.decode(response.body);
    print("ProfileRepositoryImpl SAVE responseJson: $responseJson");
    return responseJson;
  }
}
