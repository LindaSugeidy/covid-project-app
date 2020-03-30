import 'package:covidapp/src/models/Answer.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Question extends Equatable {

  final String id;
  final int order;
  final String question;
  final String type;
  final bool subQuestion;
  final String answer;
  final List<Answer> answers;

  Question(
  {@required
  this.id,
    this.order,
    this.question,
    this.type,
    this.subQuestion,
    this.answer,
    this.answers
  }
      );


  @override
  List<Object> get props => [
    order,
    question,
    type,
    subQuestion,
    answer,
    answers
  ];




  @override
  bool get stringify => true;

}