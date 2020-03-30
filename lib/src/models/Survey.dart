import 'package:covidapp/src/models/Question.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Survey.g.dart';

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


  factory Survey.fromJson(Map<String, dynamic> json) =>
      _$SurveyFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyToJson(this);

  @override
  bool get stringify => true;

  @override
  String toString() {
    return 'Survey{id: $id, name: $name, date: $date, questions: $questions}';
  }


}