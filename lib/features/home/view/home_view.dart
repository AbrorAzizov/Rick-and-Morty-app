
import 'package:flutter/material.dart';


import '../../chosen/view/favourite_tab.dart';
import 'home_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final _pages = [
    const HomeTab(),
    const FavoritesTab(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        currentIndex: _currentIndex,


        backgroundColor: isDark ? Colors.orangeAccent : Colors.deepOrangeAccent,
        selectedItemColor: isDark ? Colors.white70 : Colors.orangeAccent,
        unselectedItemColor: isDark ? Colors.white : Colors.white70,

        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _currentIndex = index),

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_purple500_rounded),
            label: "Favorite",
          ),
        ],
      ),
    );
  }
}