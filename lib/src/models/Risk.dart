import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Risk  extends Equatable {

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


@override
bool get stringify => true;
}