import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File> pickImage() async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  return File(pickedFile!.path);
}