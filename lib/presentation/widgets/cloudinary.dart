import 'dart:convert';

import 'package:http/http.dart' as http;

Future uploadImage(image) async {
  final url = Uri.parse('https://api.cloudinary.com/v1_1/djruiydrx/upload');
  // final file =await image.file;
  try {
    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = 'jk7jrg3d'
      ..files.add(await http.MultipartFile.fromPath(
        'file',
        image!.path,
      ));
    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      final Map<String, dynamic> json = jsonDecode(responseString);
      return json['secure_url'];
    } else {
      throw Exception('Failed to upload image');
    }
  } catch (e) {
    throw Exception('Failed to upload image: $e');
  }
}
