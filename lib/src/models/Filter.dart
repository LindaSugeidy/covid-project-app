import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Filter   extends Equatable {

  final String name;
  final String comparator;
  final String value;
  final List<String> values;
  final int limit;

  Filter  (
  {@required
  this.name,
    this.comparator,
    this.value,
    this.values,
    this.limit
}
);

@override
List<Object> get props => [
  name,
  comparator,
  value,
  values,
  limit
];


@override
bool get stringify => true;
}