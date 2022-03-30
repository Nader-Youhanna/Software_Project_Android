import 'package:android_app/widgets/Messages/empty_inbox_body.dart';
import 'package:flutter/material.dart';

class Inbox extends StatefulWidget {
  @override
  State<Inbox> createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  var _inboxIsEmpty = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2.0,
        leading: IconButton(
            icon: const Icon(Icons
                .person_rounded), //should be changed to google profile icon
            color: Colors.black,
            onPressed: () => {}), //button should open to side bar,
        actions: [
          Container(
            width: 260,
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(7.0),
                hintStyle: const TextStyle(
                  fontSize: 14.5,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                hintText: 'Search Direct Messages',
              ),
            ),
          ),

          IconButton(
              icon: const Icon(Icons.settings_outlined),
              color: Colors.black,
              onPressed: () => {}), //button shoud direct to setings
        ],
      ),
      body: _inboxIsEmpty ? EmptyInboxBody() : EmptyInboxBody(),
      //bottomNavigationBar: BottomBar(),
      floatingActionButton: FloatingActionButton(
        // button should open the what's happening page
        onPressed: () => {},
        child: const Icon(
          Icons.mail,
          size: 30,
        ),
      ),
    );
  }
}