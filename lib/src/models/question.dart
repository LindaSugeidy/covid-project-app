import 'package:covidapp/src/models/answer.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

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


  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);


  @override
  bool get stringify => true;

  @override
  String toString() {
    return 'Question{id: $id, order: $order, question: $question, type: $type, subQuestion: $subQuestion, answer: $answer, answers: $answers}';
  }


}