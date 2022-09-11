import 'package:flutter/material.dart';
import 'package:vgv_assessment/models/coffee_image.dart';
import 'package:vgv_assessment/services/storage.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  bool initialized = false;
  late List<CoffeeImage> images;

  @override
  void initState() {
    getAllFavoritedImageBytes().then((imageResults) {
      setState(() {
        images = imageResults;
        initialized = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      return ListView(
        children: [
          for (var image in images)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Image.memory(
                      image.imageBytes!,
                      height: 300,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        removeImage(fileName: image.fileName);
                        setState(() {
                          images
                              .removeWhere((i) => i.fileName == image.fileName);
                        });
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red.shade300)),
                      icon: const Icon(
                        Icons.delete_forever,
                        color: Colors.white,
                        size: 35,
                      ),
                      label: const Text('Delete'),
                    ),
                  ],
                ),
              ),
            ),
        ],
      );
    }
    if (initialized && images.isEmpty) {
      return const Center(
        child: Text('Looks like you haven\'t favorited any images'),
      );
    }

    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
