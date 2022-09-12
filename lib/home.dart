import 'package:flutter/material.dart';
import 'package:vgv_assessment/models/coffee_image.dart';
import 'package:vgv_assessment/services/api.dart';
import 'package:vgv_assessment/services/storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CoffeeImage? coffeeImage;
  bool isFavorited = false;
  late Future<CoffeeImage> imageFuture;

  void _getNewImage() {
    setState(() {
      isFavorited = false;
      imageFuture = getCoffeeImage();
    });
  }

  favoriteImage() {
    if (isFavorited) {
      removeImage(url: coffeeImage!.imageUrl);
      setState(() {
        isFavorited = false;
      });
    } else {
      setState(() {
        isFavorited = true;
      });
      if (coffeeImage != null) {
        saveImage(coffeeImage!.imageUrl);
      }
    }
  }

  @override
  void initState() {
    imageFuture = getCoffeeImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              FutureBuilder(
                  future: imageFuture,
                  builder: (context, AsyncSnapshot<CoffeeImage> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.data != null) {
                      coffeeImage = snapshot.data!;

                      return Image.network(
                        snapshot.data!.imageUrl,
                        height: 300,
                        frameBuilder:
                            (context, child, frame, wasSynchronouslyLoaded) {
                          if (wasSynchronouslyLoaded) {
                            return child;
                          }
                          return AnimatedOpacity(
                            child: child,
                            opacity: frame == null ? 0 : 1,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeIn,
                          );
                        },
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return const SizedContainer(text: 'Whoops...');
                        },
                      );
                    } else {
                      return const SizedContainer(
                        text: 'Loading Image',
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        favoriteImage();
                      },
                      child: Icon(
                        isFavorited ? Icons.favorite : Icons.favorite_border,
                        color: Colors.pink.shade200,
                        size: 35,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _getNewImage,
                      child: const Text('Next Image'),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class SizedContainer extends StatelessWidget {
  final String? text;
  final Widget? child;

  const SizedContainer({
    this.text,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      color: Colors.black87,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (text != null)
            Padding(
              padding: const EdgeInsets.only(
                bottom: 25,
              ),
              child: Text(
                text!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          if (child != null) child!,
        ],
      ),
    );
  }
}
