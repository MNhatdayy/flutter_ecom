import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

import '../../screens/explore/explore_screen.dart';
import '../../screens/favorite/favorite_screen.dart';
import '../../screens/message/message_screen.dart';
import '../../screens/profile/profile_screen.dart';
import '../../screens/store/store_screen.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentIndex = 0;

  final List<Widget> _screens = [
    ExploreScreen(),
    FavoriteScreen(),
    MessageScreen(),
    StoreScreen(),
    ProfileScreen(),
  ];

  void _onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white, // Màu nền trắng chung
        ),
        child: SnakeNavigationBar.color(
          behaviour: SnakeBarBehaviour.floating,
          snakeShape: SnakeShape.circle,
          padding: const EdgeInsets.symmetric(vertical: 5),
          unselectedLabelStyle: const TextStyle(fontSize: 11, color: Colors.black54),
          selectedLabelStyle: const TextStyle(fontSize: 11, color: Colors.black),
          snakeViewColor: Colors.white, // Màu nền cho biểu tượng được chọn
          unselectedItemColor: Colors.black54, // Màu biểu tượng không được chọn
          selectedItemColor: Colors.black, // Màu biểu tượng khi được chọn
          showUnselectedLabels: true,
          backgroundColor: Colors.white, // Nền thanh điều hướng là màu trắng
          currentIndex: currentIndex,
          onTap: _onTap,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }
}