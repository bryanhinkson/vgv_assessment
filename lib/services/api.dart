import 'dart:convert';

import 'package:http/http.dart';
import 'package:vgv_assessment/models/coffee_image.dart';

Future<CoffeeImage> getCoffeeImage() async {
  final response =
      await get(Uri.parse('https://coffee.alexflipnote.dev/random.json'));
  if (response.statusCode == 200) {
    return CoffeeImage.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load image data');
  }
}
