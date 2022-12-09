import 'package:cpmdwithf_project/data/damage_report.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as p;

// function to send images to the server
// later on this function will send images stored in image_storage.dart provided by ChangeNotifierProvider<ImageStorage>
analyzeImage() async {
  List<DamageResult> damageResultList;
  String baseUrl = 'http://188.72.108.88:8080';
  final Dio dio = Dio(BaseOptions(
    baseUrl: baseUrl,
  ));
  final Response<dynamic> response = await dio.get('/analyze');
  print(response.data.toString());
  DamageReport damageReport = DamageReport.fromJson(response.data);
  print(baseUrl + p.join(damageReport.inputsPrefix, damageReport.imgNames[0]));
  damageResultList = damageReport.imgNames
      .map((imgName) => DamageResult(
          NetworkImage(
              baseUrl + p.join(baseUrl, damageReport.inputsPrefix, imgName)),
          NetworkImage(
              baseUrl + p.join(baseUrl, damageReport.damagePrefix, imgName))))
      .toList();
  return damageResultList;
}

class DamageResult {
  final originalImg;
  final damageImg;

  const DamageResult(this.originalImg, this.damageImg);
}
