import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:threads_ihun_app/views/home/home_view.dart';
import 'package:threads_ihun_app/views/notification/notification_view.dart';
import 'package:threads_ihun_app/views/post/post_view.dart';
import 'package:threads_ihun_app/views/profile/profile_view.dart';
import 'package:threads_ihun_app/views/search/search_view.dart';

class MainMenuView extends StatefulWidget {
  const MainMenuView({super.key});

  @override
  State<MainMenuView> createState() => _MainMenuViewState();
}

class _MainMenuViewState extends State<MainMenuView> {
  static const List<Widget> listViews = <Widget>[
    HomeView(),
    SearchView(),
    PostView(),
    NotificationView(),
    ProfileView()
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: listViews.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          iconSize: 25.h,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(CupertinoIcons.house),
              activeIcon: Icon(CupertinoIcons.house_fill),
            ),
            BottomNavigationBarItem(
              label: 'Search',
              icon: Icon(CupertinoIcons.search),
            ),
            BottomNavigationBarItem(
              label: 'Post',
              icon: Icon(Icons.add),
            ),
            BottomNavigationBarItem(
              label: 'Notification',
              icon: Icon(CupertinoIcons.bell),
              activeIcon: Icon(CupertinoIcons.bell_fill),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(CupertinoIcons.person),
              activeIcon: Icon(CupertinoIcons.person_fill),
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (index) {
            _onItemTapped(index);
          },
        ));
  }
}
