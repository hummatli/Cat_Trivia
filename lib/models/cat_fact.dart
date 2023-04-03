import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

part 'cat_fact.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class CatFact {
  @JsonKey(name: '_id')
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String text;

  @HiveField(2)
  final DateTime createdAt;

  CatFact({required this.id, required this.text, required this.createdAt});

  factory CatFact.fromJson(Map<String, dynamic> json) => _$CatFactFromJson(json);

  Map<String, dynamic> toJson() => _$CatFactToJson(this);
}