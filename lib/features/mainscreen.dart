
import 'package:flutter/material.dart';
import 'Movies/movie_list.dart';
import 'book_list.dart';
import 'tv_list.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    MovieListScreen(),
    BookListScreen(),
    TVListScreen(),
    Center(child: Text('Profile')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],

      // App bar at the bottom
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.blueGrey[800],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_movies_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv_rounded),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
    );
  }
}
