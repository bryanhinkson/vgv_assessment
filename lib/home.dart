import 'package:flutter/material.dart';
import 'package:vgv_assessment/models/coffee_image.dart';
import 'package:vgv_assessment/services/api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CoffeeImage coffeeImage;
  bool initialized = false;

  void _getNewImage() {
    setState(() {
      getCoffeeImage().then((ci) {
        coffeeImage = ci;
        initialized = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!initialized)
              GestureDetector(
                  onTap: _getNewImage,
                  child: const SizedContainer(text: 'Click to Get Started')),
            if (initialized)
              Column(
                children: [
                  Image.network(
                    coffeeImage.imageUrl,
                    height: 300,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) {
                        return child;
                      } else {
                        return const SizedContainer(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
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
          if (child != null) child!,
          if (text != null)
            Text(
              text!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
        ],
      ),
    );
  }
}
