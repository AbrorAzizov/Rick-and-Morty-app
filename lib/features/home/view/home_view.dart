
import 'package:flutter/material.dart';

import '../../favorite/view/favourite_tab.dart';
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
    FavoritesTab(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        currentIndex: _currentIndex,
        backgroundColor:Colors.teal,
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Main",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Budgets",
          ),


        ],
      ),
    );
  }
}
