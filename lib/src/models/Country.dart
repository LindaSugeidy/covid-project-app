import 'package:covidapp/src/models/profile.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Country extends Equatable {

  final String id;
  final String name;
  final int confirmed;
  final int recovered;
  final int risk;
  final int riskFree;
  final int riskHigh;
  final int riskLow;
  final int total;
  final List<Profile> profilesLastConfirmed;


  Country(
  {@required
  this.id,
    this.name,
    this.confirmed,
    this.recovered,
    this.risk,
    this.riskFree,
    this.riskHigh,
    this.riskLow,
    this.total,
    this.profilesLastConfirmed
}
);

@override
List<Object> get props => [
  id,
  name,
  confirmed,
  recovered,
  risk,
  riskFree,
  riskHigh,
  riskLow,
  total,
  profilesLastConfirmed
];


@override
bool get stringify => true;
}