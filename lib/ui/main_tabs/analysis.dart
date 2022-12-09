import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cpmdwithf_project/domain/image_storage.dart';
import 'package:cpmdwithf_project/domain/server_connection.dart';
import 'package:before_after/before_after.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});

  final String title = 'Analysis Screen';

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
        title: Text(widget.title),
      ),
      body: SafeArea(
        // SafeArea to make sure the user can see the whole app without obstructions
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              MaterialButton(
                  color: Colors.blue,
                  child: const Text("Send images to analysis",
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold)),
                  onPressed: () async {
                    _damageResultList = await analyzeImage();
                    _buttonClicked = true;
                    setState(() {});
                  }),
              const Padding(padding: EdgeInsets.all(10.0)),
              Text(
                'This is Analysis Screen',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              _buttonClicked
                  ? DamageResultList(
                      damageResultList: _damageResultList,
                    )
                  : imagesList.isNotEmpty()
                      ? const Text("Files ready to be sent")
                      : const Text("Add photos before sending!"),
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
          return Container(
            child: Center(
                child: BeforeAfter(
              beforeImage: Image(image: damageResultList[index].originalImg),
              afterImage: Image(image: damageResultList[index].damageImg),
            )),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
