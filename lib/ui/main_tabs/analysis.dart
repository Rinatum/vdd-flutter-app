// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cpmdwithf_project/domain/image_storage.dart';
import 'package:cpmdwithf_project/domain/server_connection.dart';
import 'package:before_after/before_after.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  late List<DamageResult> _damageResultList;
  bool _buttonClicked = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var to keep track of current favourites
    final imagesList = context.watch<ImageStorage>();

    return Scaffold(
      appBar: AppBar(
        title: Text("analysis_title".tr()),
        actions: [
          IconButton(
              onPressed: () {
                if (context.locale.toString() == "en_US") {
                  setState(() {
                    context.setLocale(const Locale("ru", "RU"));
                  });
                } else {
                  setState(() {
                    context.setLocale(const Locale("en", "US"));
                  });
                }
              },
              icon: const Icon(Icons.language))
        ],
      ),
      body: SafeArea(
        // SafeArea to make sure the user can see the whole app without obstructions
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              MaterialButton(
                  color: Colors.blue,
                  child: Text("analysis_send".tr(),
                      style: const TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold)),
                  onPressed: () async {
                    _damageResultList = await analyzeImage();
                    _buttonClicked = true;
                    setState(() {});
                  }),
              const Padding(padding: EdgeInsets.all(10.0)),
              Text(
                'analysis_info'.tr(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              _buttonClicked
                  ? DamageResultList(
                      damageResultList: _damageResultList,
                    )
                  : imagesList.isNotEmpty()
                      ? Text("analysis_ready_to_send".tr())
                      : Text("error_analysis_no_files".tr()),
            ],
          ),
        ),
      ),
    );
  }
}

class DamageResultList extends StatelessWidget {
  const DamageResultList({super.key, required this.damageResultList});

  final List<DamageResult> damageResultList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: damageResultList.length,
        itemBuilder: (BuildContext context, int index) {
          return Center(
              child: BeforeAfter(
            beforeImage: Image(image: damageResultList[index].originalImg),
            afterImage: Image(image: damageResultList[index].damageImg),
          ));
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
