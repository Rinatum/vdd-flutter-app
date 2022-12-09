// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'damage_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DamageReport _$DamageReportFromJson(Map<String, dynamic> json) => DamageReport(
      imgNames:
          (json['img_names'] as List<dynamic>).map((e) => e as String).toList(),
      inputsPrefix: json['inputs_prefix'] as String,
      detailsPrefix: json['details_prefix'] as String,
      damagePrefix: json['damage_prefix'] as String,
    );

Map<String, dynamic> _$DamageReportToJson(DamageReport instance) =>
    <String, dynamic>{
      'img_names': instance.imgNames,
      'inputs_prefix': instance.inputsPrefix,
      'details_prefix': instance.detailsPrefix,
      'damage_prefix': instance.damagePrefix,
    };
