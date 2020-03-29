// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile(
    uid: json['uid'] as String,
    name: json['name'] as String,
    age: json['age'] as num,
    idCountry: json['idCountry'] as String,
    country: json['country'] as String,
    email: json['email'] as String,
    gender: json['gender'] as String,
    idRisk: json['idRisk'] as String,
    risk: json['risk'] as String,
    state: json['state'] as String,
    town: json['town'] as String,
    zip: json['zip'] as String,
    firstUpdate: json['firstUpdate'] == null
        ? null
        : DateTime.parse(json['firstUpdate'] as String),
    lastUpdate: json['lastUpdate'] == null
        ? null
        : DateTime.parse(json['lastUpdate'] as String),
  );
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'age': instance.age,
      'idCountry': instance.idCountry,
      'country': instance.country,
      'email': instance.email,
      'gender': instance.gender,
      'idRisk': instance.idRisk,
      'risk': instance.risk,
      'state': instance.state,
      'town': instance.town,
      'zip': instance.zip,
      'firstUpdate': instance.firstUpdate?.toIso8601String(),
      'lastUpdate': instance.lastUpdate?.toIso8601String(),
    };
