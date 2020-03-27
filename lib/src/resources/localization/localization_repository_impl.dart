import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'localization_repository.dart';

class LocalizationRepositoryImpl implements LocalizationRepository {
  final Locale _locale;

  LocalizationRepositoryImpl({@required Locale locale})
    : _locale = locale;

  Map<String, String> _localizedStrings;

  /// Gets file with language code and loads it in a map[_localizedStrings]
  Future<bool> load() async {
    String jsonString =
    await rootBundle.loadString('lang/${_locale.languageCode}.json');

    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  /// Gets translate by key[key]
  String translate(String key) {
    return _localizedStrings[key];
  }
}