import 'package:json_annotation/json_annotation.dart';

part 'damage_report.g.dart';

@JsonSerializable()
class DamageReport {
  @JsonKey(name: 'img_names')
  final List<String> imgNames;

  @JsonKey(name: 'inputs_prefix')
  final String inputsPrefix;

  @JsonKey(name: 'details_prefix')
  final String detailsPrefix;

  @JsonKey(name: 'damage_prefix')
  final String damagePrefix;

  DamageReport(
      {required this.imgNames,
      required this.inputsPrefix,
      required this.detailsPrefix,
      required this.damagePrefix});

  factory DamageReport.fromJson(Map<String, dynamic> json) =>
      _$DamageReportFromJson(json);

  Map<String, dynamic> toJson() => _$DamageReportToJson(this);
}
