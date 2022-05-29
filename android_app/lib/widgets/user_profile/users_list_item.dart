import 'package:android_app/widgets/user_profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:android_app/widgets/user_profile/users_list_item.dart';
//import './tweetsOnly.dart';
import 'package:android_app/widgets/user_profile/Follow_button.dart';

///class that creates single item that appears in users (followers and following accounts) lists
class User_Item extends StatelessWidget {
  String username = "username";
  String handle = "@username";

  bool FollowsBack = true;
  bool _alreadyfollowed = true;
  String bio =
      "this is their bio text containig their description being demonstrated";
  late String token;
  CircleAvatar userImage = CircleAvatar(
    backgroundImage: AssetImage('assets/images/user_icon.png'),
    radius: 25.0,
  );
  User_Item(this.username, this.handle, this.FollowsBack, this._alreadyfollowed,
      this.bio, this.token);

  ///constructor to map a Json file into an object of the class with appropriate fields for a UserItem
  User_Item.jsonUserItem(Map<String, dynamic> JsonUserItem, String getToken) {
    username = JsonUserItem['name'] as String;
    handle = JsonUserItem['username'] as String;
    FollowsBack = JsonUserItem['followsMe'] as bool;
    _alreadyfollowed = JsonUserItem['followsHim'] as bool;
    bio = JsonUserItem['bio'] as String;
    if (JsonUserItem['image'] != null) {
      userImage = CircleAvatar(
        backgroundImage: NetworkImage(JsonUserItem['image'] as String),
        radius: 25.0,
      );
    }
    token = getToken;
  }

  ///constructor to map a Json file into an object of the class with appropriate fields for a UserItem for the who to follow page
  User_Item.jsonWhoToFollow(
      Map<String, dynamic> JsonUserItem, String getToken) {
    username = JsonUserItem['name'] as String;
    handle = JsonUserItem['username'] as String;
    _alreadyfollowed = false;
    bio = " ";
    if (JsonUserItem['image'] != null) {
      userImage = CircleAvatar(
        backgroundImage: NetworkImage(JsonUserItem['image'] as String),
        radius: 25.0,
      );
    }
    token = getToken;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Profile(handle, false, token)));
        },
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: userImage,
                title: Text(
                  username,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                subtitle: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: "${handle} ",
                        style: TextStyle(color: Colors.black),
                      ),
                      FollowsBack
                          ? TextSpan(
                              text: "follows you",
                              style: TextStyle(
                                  backgroundColor:
                                      Color.fromARGB(194, 166, 192, 206),
                                  fontSize: 12,
                                  color: Color.fromARGB(255, 61, 61, 61)),
                            )
                          : TextSpan(),
                    ],
                  ),
                ),
                trailing: Follow_button(_alreadyfollowed, username, token),
              ),
              Padding(
                padding: EdgeInsets.only(left: 0),
                child: Text(
                  bio,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
