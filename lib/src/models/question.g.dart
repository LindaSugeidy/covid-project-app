// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) {
  return Question(
    id: json['id'] as String,
    order: json['order'] as int,
    question: json['question'] as String,
    type: json['type'] as String,
    subQuestion: json['subQuestion'] as bool,
    answer: json['answer'] as String,
    answers: (json['answers'] as List)
        ?.map((e) =>
            e == null ? null : Answer.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'order': instance.order,
      'question': instance.question,
      'type': instance.type,
      'subQuestion': instance.subQuestion,
      'answer': instance.answer,
      'answers': instance.answers,
    };
