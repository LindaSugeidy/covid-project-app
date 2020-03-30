// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) {
  return Country(
    id: json['id'] as String,
    name: json['name'] as String,
    confirmed: json['confirmed'] as int,
    recovered: json['recovered'] as int,
    risk: json['risk'] as int,
    riskFree: json['riskFree'] as int,
    riskHigh: json['riskHigh'] as int,
    riskLow: json['riskLow'] as int,
    total: json['total'] as int,
    profilesLastConfirmed: (json['profilesLastConfirmed'] as List)
        ?.map((e) =>
            e == null ? null : Profile.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'confirmed': instance.confirmed,
      'recovered': instance.recovered,
      'risk': instance.risk,
      'riskFree': instance.riskFree,
      'riskHigh': instance.riskHigh,
      'riskLow': instance.riskLow,
      'total': instance.total,
      'profilesLastConfirmed': instance.profilesLastConfirmed,
    };
