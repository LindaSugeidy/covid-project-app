// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Survey.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Survey _$SurveyFromJson(Map<String, dynamic> json) {
  return Survey(
    id: json['id'] as String,
    name: json['name'] as String,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    questions: (json['questions'] as List)
        ?.map((e) =>
            e == null ? null : Question.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SurveyToJson(Survey instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'date': instance.date?.toIso8601String(),
      'questions': instance.questions,
    };
