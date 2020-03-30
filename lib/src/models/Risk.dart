import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Risk.g.dart';

@JsonSerializable()
class Risk extends Equatable {

  final String id;
  final String name;
  final int minRange;
  final int maxRange;
  final String message;

  Risk (
  {@required
  this.id,
    this.name,
    this.minRange,
    this.maxRange,
    this.message
}
);

@override
List<Object> get props => [
  id,
  name,
  minRange,
  maxRange,
  message
];


  factory Risk.fromJson(Map<String, dynamic> json) =>
      _$RiskFromJson(json);

  Map<String, dynamic> toJson() => _$RiskToJson(this);


  @override
  bool get stringify => true;

  @override
  String toString() {
    return 'Risk{id: $id, name: $name, minRange: $minRange, maxRange: $maxRange, message: $message}';
  }


}