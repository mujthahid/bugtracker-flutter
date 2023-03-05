import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hive_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class ResponseData extends HiveObject{
  
  @JsonKey(name:"_id")
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @JsonKey(name:"due_date",includeIfNull: false)
  @HiveField(3)
  String? dueDate;

  @JsonKey(includeIfNull: false)
  @HiveField(4)
  String? project;

  @JsonKey(includeIfNull: false)
  @HiveField(5)
  String? reporter;

  @JsonKey(includeIfNull: false)
  @HiveField(6)
  String?fileUrl;
  

  ResponseData({
    required this.id,
    required this.title,
    required this.description,
    this.dueDate,
    this.project,
    this.reporter,
    this.fileUrl
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) =>
      _$ResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseDataToJson(this);
}

