import 'dart:io';

import 'package:cpmdwithf_project/domain/image_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  final String title = 'Gallery Screen';

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
        title: const Text("Image Picker Example"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            MaterialButton(
                color: Colors.blue,
                child: const Text("Pick Image from Gallery",
                    style: TextStyle(
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
                      const SnackBar(
                        content: Text('Image saved'),
                        duration: Duration(seconds: 1),
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
                : const Text('No image selected'),
          ],
        ),
      ),
    );
  }
}
