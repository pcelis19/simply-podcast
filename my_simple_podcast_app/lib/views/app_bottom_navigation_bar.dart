import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/views/bottom_navigation_bar_dependencies/models/tab_meta_data.dart';

class AppBottomNavigationBar extends StatefulWidget {
  AppBottomNavigationBar({Key key}) : super(key: key);
  final TabMetaData _tabMetaData = TabMetaData();
  @override
  _AppBottomNavigationBarState createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  int _selectedIndex = 0;
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    TabMetaData _tabMetaData = widget._tabMetaData;
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          children: _tabMetaData.screens,
          onPageChanged: onTabTapped,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _onItemTapped,
        items: _tabMetaData.icons,
      ),
    );
  }

  void onTabTapped(int selectedIndex) {
    setState(() {
      _selectedIndex = selectedIndex;
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }
}