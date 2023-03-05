// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseData _$ResponseDataFromJson(Map<String, dynamic> json) => ResponseData(
      id: json['_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      dueDate: json['due_date'] as String?,
      project: json['project'] as String?,
      reporter: json['reporter'] as String?,
      fileUrl: json['fileUrl'] as String?,
    );

Map<String, dynamic> _$ResponseDataToJson(ResponseData instance) {
  final val = <String, dynamic>{
    '_id': instance.id,
    'title': instance.title,
    'description': instance.description,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('due_date', instance.dueDate);
  writeNotNull('project', instance.project);
  writeNotNull('reporter', instance.reporter);
  writeNotNull('fileUrl', instance.fileUrl);
  return val;
}
