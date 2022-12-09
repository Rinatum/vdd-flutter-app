import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageStorage extends ChangeNotifier {
  // map is for work within the app
  final List<File> _items = [];

  int length() {
    // return number of elements in the map
    return _items.length;
  }

  bool isNotEmpty() {
    return _items.isNotEmpty;
  }

  // should not be used outside of testing
  // List<File> get values => _Items;

  // get the element from the list with a given index
  File get(int index) {
    return _items[index];
  }

  // add element to the list
  void add(File item) {
    _items.add(item);

    notifyListeners();
  }

  // remove element from the list
  void remove(File item) {
    _items.remove(item);

    notifyListeners();
  }

  // check whether the provided key is present
  bool containsKey(File item) {
    return _items.contains(item);
  }

  @override
  String toString() {
    return _items.toString();
  }
}
