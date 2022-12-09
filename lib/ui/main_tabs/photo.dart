import 'dart:io';

import 'package:cpmdwithf_project/domain/image_storage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({super.key});

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late ImagePicker _picker;
  late XFile photo;

  @override
  void initState() {
    super.initState();
    // init the ImagePicker to allow the app to take pictures
    _picker = ImagePicker();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var to keep track of current images
    final imagesList = context.watch<ImageStorage>();

    return Scaffold(
      appBar: AppBar(
        title: Text("photo_title".tr()),
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
      // for testing purposes this will be like that
      body: SafeArea(
        child: imagesList.isNotEmpty()
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
              )
            : Text('error_no_image'.tr()),
      ),
      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        onPressed: () async {
          // take the photo from the camera and make sure that the photo was taken (not null)
          photo = (await _picker.pickImage(source: ImageSource.camera))!;
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
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('display_picture'.tr())),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}
