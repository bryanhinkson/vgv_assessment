import 'dart:typed_data';

import 'package:vgv_assessment/services/storage.dart';

class CoffeeImage {
  final String imageUrl;
  final String fileName;
  final Uint8List? imageBytes;

  const CoffeeImage({
    required this.imageUrl,
    required this.fileName,
    this.imageBytes,
  });

  factory CoffeeImage.fromJson(Map<String, dynamic> json) {
    return CoffeeImage(
      imageUrl: json['file'],
      fileName: getFileNameFromUrl(json['file']),
    );
  }
}
