import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbols.dart';
import '../../constants.dart';
import '../../functions/tweet_functions.dart';
import '../side_bar.dart';
import 'notification_bar.dart';
import 'all_notifications_list.dart';
import 'mentions_list.dart';

///the whole page that holds the notification bar the notification's list and the mentions list
class NotificationsPage extends StatelessWidget {
  ///setting up default credentails for each user: page should have available the user credentials

  String name = "";
  String userName = "";
  String userImage = '';
  bool isAdmin = false;
  String email = '';
  String token;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  ///constructor to set the user credentials
  NotificationsPage(
      {required this.name,
      required this.userName,
      required this.userImage,
      required this.isAdmin,
      required this.email,
      required this.token});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: SideBar(
          name: name,
          username: userName,
          userImage: userImage,
          isAdmin: isAdmin,
          email: email,
          token: token,
        ),
        key: _scaffoldKey,
        body: NotificationListener<ScrollNotification>(
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                NotificationBar(
                  _scaffoldKey,
                  name: name,
                  userName: userName,
                  userImage: userImage,
                  isAdmin: isAdmin,
                  email: email,
                  token: token,
                ), //the bar that gives us either the all notifications page or the mentions page
              ];
            },
            body: TabBarView(
              children: <Widget>[
                AllNotificationsList(
                  name: name,
                  userName: userName,
                  userImage: userImage,
                  isAdmin: isAdmin,
                  email: email,
                  token: token,
                ), //getting and displaying the list of all notifications
                MentionsList(
                  name: name,
                  userName: userName,
                  userImage: userImage,
                  isAdmin: isAdmin,
                  email: email,
                  token: token,
                ), //getting and displaying the list of all mentions
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          // button should open the what's happening page
          onPressed: () => startAddTweet(context, token),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
