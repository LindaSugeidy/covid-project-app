import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Answer extends Equatable {

  final String id;
  final String answer;
  final int order;
  final String idQuestion;

  Answer(
      {@required
        this.id,
        this.answer,
        this.order,
        this.idQuestion}
      );

  @override
  List<Object> get props => [
    id,
    answer,
    order,
    idQuestion,
  ];


  @override
  bool get stringify => true;
}