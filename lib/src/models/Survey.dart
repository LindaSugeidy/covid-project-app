import 'package:covidapp/src/models/Question.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Survey extends Equatable {

  final String id;
  final String name;
  final DateTime date;
  final List<Question> questions;


  Survey(
      {@required
      this.id,
      this.name,
      this.date,
      this.questions
      }
      );

  @override
  List<Object> get props => [
    id,
    name,
    date,
    questions
  ];


  @override
  bool get stringify => true;
}