import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vgv_assessment/models/coffee_image.dart';

Future<bool> saveImage(String url) async {
  final fileName = getFileNameFromUrl(url);
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  Response response = await get(
    Uri.parse(url),
  );
  String base64Image = base64Encode(response.bodyBytes);
  return preferences.setString(fileName, base64Image);
}

Future<bool> removeImage({String? url, String? fileName}) async {
  if (url == null && fileName == null) {
    return false;
  }
  if (url != null) {
    fileName = getFileNameFromUrl(url);
  }
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.remove(fileName!);
}

Future<Uint8List> getFavoritedImageBytes(String fileName) async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  Uint8List bytes = base64Decode(preferences.getString(fileName)!);
  return bytes;
}

Future<List<CoffeeImage>> getAllFavoritedImageBytes() async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  final fileNames = preferences.getKeys();
  final images = <CoffeeImage>[];
  for (var file in fileNames) {
    Uint8List bytes = base64Decode(preferences.getString(file)!);
    images.add(CoffeeImage(
      // This would need to change if the domain changes
      imageUrl: 'https://coffee.alexflipnote.dev/$file',
      fileName: file,
      imageBytes: bytes,
    ));
  }
  return images;
}

Future<List<String>> getFavoritedImageFileNames() async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  final fileNames = preferences.getKeys();
  final files = <String>[];
  for (var file in fileNames) {
    files.add(file);
  }
  return files;
}

String getFileNameFromUrl(String url) {
  // This is assuming that the filenames such as
  // https://coffee.alexflipnote.dev/jTzYVaU7szc_coffee.png
  // Are unique. If not then we could potentially overwrite data downstream
  return url.split('/').last;
}
