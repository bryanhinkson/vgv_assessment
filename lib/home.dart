import 'package:flutter/material.dart';
import 'package:vgv_assessment/models/coffee_image.dart';
import 'package:vgv_assessment/services/api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CoffeeImage coffeeImage;
  bool _initialized = false;
  bool _fetchingImage = false;

  void _getNewImage() {
    setState(() {
      _fetchingImage = true;
      getCoffeeImage().then((ci) {
        setState(() {
          coffeeImage = ci;
          _initialized = true;
          _fetchingImage = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!_initialized)
            GestureDetector(
              onTap: _getNewImage,
              child: const SizedContainer(text: 'Click to Get Started'),
            ),
          if (_initialized && _fetchingImage)
            const SizedContainer(
              text: 'Loading Image',
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          if (_initialized && !_fetchingImage)
            Column(
              children: [
                Image.network(
                  coffeeImage.imageUrl,
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
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.favorite_border,
                        color: Colors.pink.shade200,
                        size: 35,
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
