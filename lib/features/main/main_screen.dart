import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/features/bookmark/bookmark_screen.dart';
import 'package:news_app/features/home/home_screen.dart';
import 'package:news_app/features/profile/profile_screen.dart';
import 'package:news_app/features/search/search_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    BookmarkScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },

        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/home.svg',
              height: 24,
              width: 24,
              colorFilter: ColorFilter.mode(
                _selectedIndex == 0 ? LightColor.primary : Color(0xFF363636),
                BlendMode.srcIn,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/search.svg',
              height: 24,
              width: 24,
              colorFilter: ColorFilter.mode(
                _selectedIndex == 1 ? LightColor.primary : Color(0xFF363636),
                BlendMode.srcIn,
              ),
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/bookmark.svg',
              height: 24,
              width: 24,
              colorFilter: ColorFilter.mode(
                _selectedIndex == 2 ? LightColor.primary : Color(0xFF363636),
                BlendMode.srcIn,
              ),
            ),
            label: 'Bookmark',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/profile.svg',
              height: 24,
              width: 24,
              colorFilter: ColorFilter.mode(
                _selectedIndex == 3 ? LightColor.primary : Color(0xFF363636),
                BlendMode.srcIn,
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
      body: IndexedStack(index: _selectedIndex, children: _screens),
    );
  }
}
