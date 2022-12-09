import 'dart:io';

import 'package:cpmdwithf_project/domain/image_storage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  late ImagePicker _picker;
  late XFile photo;

  @override
  void initState() {
    // init the ImagePicker to allow the app to take from gallery
    _picker = ImagePicker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final imagesList = context.watch<ImageStorage>();

    return Scaffold(
      appBar: AppBar(
        title: Text("gallery_title".tr()),
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
        child: Column(
          children: [
            MaterialButton(
                color: Colors.blue,
                child: Text("gallery_pick".tr(),
                    style: const TextStyle(
                        color: Colors.white70, fontWeight: FontWeight.bold)),
                onPressed: () async {
                  // take the photo from the gallery and make sure that the photo was taken (not null)
                  photo =
                      (await _picker.pickImage(source: ImageSource.gallery))!;
                  // save the photo
                  imagesList.add(File(photo.path));
                  // update the look of the screen and display a snack-bar message
                  setState(() {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('snackbar_image_saved'.tr()),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  });
                }),
            const Padding(padding: EdgeInsets.all(10)),
            imagesList.isNotEmpty()
                ? Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                        crossAxisCount: 3,
                      ),
                      itemCount: imagesList.length(),
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.all(8),
                          child: Image.file(imagesList.get(index)),
                        );
                      },
                    ),
                  )
                : Text('error_no_image'.tr()),
          ],
        ),
      ),
    );
  }
}
