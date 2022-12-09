import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageStorage extends ChangeNotifier {
  // map is for work within the app
  final List<File> _Items = [];

  int length() {
    // return number of elements in the map
    return _Items.length;
  }

  bool isNotEmpty() {
    return _Items.isNotEmpty;
  }

  // should not be used outside of testing
  // List<File> get values => _Items;

  // get the element from the list with a given index
  File get(int index) {
    return _Items[index];
  }

  // add element to the list
  void add(File item) {
    _Items.add(item);

    notifyListeners();
  }

  // remove element from the list
  void remove(File item) {
    _Items.remove(item);

    notifyListeners();
  }

  // check whether the provided key is present
  bool containsKey(File item) {
    return _Items.contains(item);
  }

  @override
  String toString() {
    return _Items.toString();
  }
}
