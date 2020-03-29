import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile extends Equatable {
  final String uid;
  final String name;
  final num age;
  final String idCountry;
  final String country;
  final String email;
  final String gender;
  final String idRisk;
  final String risk;
  final String state;
  final String town;
  final String zip;
  final DateTime firstUpdate;
  final DateTime lastUpdate;

  Profile(
      {@required this.uid,
      this.name,
      this.age,
      this.idCountry,
      this.country,
      this.email,
      this.gender,
      this.idRisk,
      this.risk,
      this.state,
      this.town,
      this.zip,
      this.firstUpdate,
      this.lastUpdate});

  @override
  List<Object> get props => [
        uid,
        name,
        age,
        idCountry,
        country,
        email,
        gender,
        idRisk,
        risk,
        state,
        town,
        zip,
        firstUpdate,
        lastUpdate
      ];

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);

  @override
  bool get stringify => true;
}
