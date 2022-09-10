import 'package:flutter/material.dart';
import 'favorites.dart';
import 'home.dart';

void main() {
  runApp(const VeryGoodCoffeeApp());
}

class VeryGoodCoffeeApp extends StatefulWidget {
  const VeryGoodCoffeeApp({Key? key}) : super(key: key);
  @override
  State<VeryGoodCoffeeApp> createState() => _VeryGoodCoffeeAppState();
}

class _VeryGoodCoffeeAppState extends State<VeryGoodCoffeeApp> {
  int _selectedTabIndex = 0;
  List<Widget> pages = [const HomePage(), const FavoritesPage()];
  late Widget _widgetToShow;

  @override
  void initState() {
    _widgetToShow = pages[0];
    super.initState();
  }

  void _changeTab(int index) {
    setState(() {
      _selectedTabIndex = index;
      _widgetToShow = pages[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Very Good Coffee App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Very Good Coffee App'),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
              ),
              label: 'Favorites',
            ),
          ],
          currentIndex: _selectedTabIndex,
          onTap: _changeTab,
        ),
        body: _widgetToShow,
      ),
    );
  }
}
