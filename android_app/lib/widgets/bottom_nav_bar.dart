import 'package:flutter/material.dart';
import 'Notifications/notifications_page.dart';
import './Log In/login.dart';
import 'Sign Up/sign_up.dart';
import 'Tweets/tweet.dart';
import './timeline.dart';
import 'Log In/forgot_password.dart';
import 'Messages/inbox.dart';
import './user_profile/profile.dart';
import 'Explore/explore_page.dart';

import '../functions/http_functions.dart';
import '../constants.dart';

class MyNavigationBar extends StatefulWidget {
  MyNavigationBar();

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int _selectedIndex = 0;
  String _appBarText = 'Timeline';

  void _goToUserProfile(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return Profile();
      }),
    );
  }

  final List<Widget> _widgetOptions = <Widget>[
    Timeline(),
    ExplorePage(),
    const NotificationsPage(),
    Inbox(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              //first page is the time line
              icon: Icon(
                Icons.home_outlined,
                color: Colors.black,
              ),
              label: 'timeline',
              activeIcon: Icon(
                Icons.home,
                color: Colors.black,
              ),
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              //second page is the epxlore

              icon: Icon(
                Icons.search_rounded,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.search_rounded,
                color: Colors.black,
              ),
              label: 'explore',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              //thris page is notifications
              icon: Icon(
                Icons.notifications_outlined,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.notifications,
                color: Colors.black,
              ),
              label: 'notifications',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              //last page is messages
              icon: Icon(
                Icons.email_outlined,
                color: Colors.black,
              ),
              label: 'messages',
              activeIcon: Icon(
                Icons.email,
                color: Colors.black,
              ),
              backgroundColor: Colors.white,
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          iconSize: 25,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: _onItemTapped,
          elevation: 5),
    );
  }
}
