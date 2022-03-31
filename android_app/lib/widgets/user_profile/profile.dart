import 'package:flutter/material.dart';
import 'package:android_app/widgets/Tweets/tweet.dart';
import 'package:android_app/widgets/timeline.dart';

class Choice {
  const Choice(
      {required this.title, required this.icon, this.isEnable = false});
  final bool isEnable;
  final IconData icon;
  final String title;
}

const List<Choice> choices = <Choice>[
  Choice(title: 'Share', icon: Icons.directions_car, isEnable: true),
  Choice(title: 'Block', icon: Icons.directions_bike),
  Choice(title: 'Mute', icon: Icons.directions_bike),
  Choice(title: 'Report', icon: Icons.directions_bike),
];

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  @override
  Widget build(BuildContext context) {
    //String dropdownValue = 'One';
    var _tabs = ["Tweets", "Tweets & replies", "Media", "Likes"];
    var _followersCount;
    var _followingCount;

    bool _myProfile = true;
    bool _alreadyFollowed = true;

    List<Tweet> tweets = [
      Tweet(
        'This is the first tweet with one image',
        [
          'assets/images/test_image.png',
        ],
        3,
        5,
      ),
      Tweet(
        'This is the second tweet with two images',
        [
          'assets/images/test_image.png',
          'assets/images/test_image.png',
        ],
        33,
        700,
      ),
      Tweet(
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
          [
            'assets/images/test_image.png',
            'assets/images/test_image.png',
            'assets/images/test_image.png',
          ],
          1000,
          99000),
      Tweet(
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
          [
            'assets/images/test_image.png',
            'assets/images/test_image.png',
            'assets/images/test_image.png',
            'assets/images/test_image.png',
          ],
          1000,
          99000),
      Tweet(
        'This tweet has no images',
        [],
        0,
        0,
      ),
    ];
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(
              leading: BackButton(
                color: Colors.white,
                onPressed: () {
                  _goBack(context);
                },
              ), //IconButton
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  tooltip: 'search Icon',
                  onPressed: () {},
                ),
                PopupMenuButton(
                  itemBuilder: (BuildContext context) {
                    return choices.map((Choice choice) {
                      return PopupMenuItem<Choice>(
                        value: choice,
                        child: Text(choice.title),
                      );
                    }).toList();
                  },
                ),
                // DropdownButton<String>(
                //   // style: Color(Colors.white),
                //   icon: Icon(Icons.menu_sharp),
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       dropdownValue = newValue!;
                //     });
                //   },
                //   items: <String>['block', 'mute', 'report']
                //       .map<DropdownMenuItem<String>>((String value) {
                //     return DropdownMenuItem<String>(
                //       value: value,
                //       child: Text(value),
                //     );
                //   }).toList(),
                // )
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image.network(
                      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
                      fit: BoxFit.cover,
                    ),
                    const DecoratedBox(
                        decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.0, 0.5),
                        end: Alignment.center,
                        colors: <Color>[
                          Color(0x60000000),
                          Color(0x00000000),
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            ),
          ),
          body: DefaultTabController(
            length: _tabs.length,
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: SliverAppBar(
                      //title: const Text('Books'),
                      pinned: true,
                      floating: false,
                      expandedHeight: 220.0,
                      stretch: true,
                      onStretchTrigger: () {
                        return Future<void>.value();
                      },
                      forceElevated: innerBoxIsScrolled,
                      bottom: TabBar(
                        tabs: _tabs
                            .map((String name) => Tab(text: name))
                            .toList(),
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.pin,
                        background: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  padding: EdgeInsets.only(left: 15, right: 32),
                                  child: new CircleAvatar(
                                    backgroundImage: new AssetImage(
                                        'assets/images/user_icon.png'),
                                    radius: 35,
                                    backgroundColor: Colors.grey,
                                  ),
                                ),

                                Container(
                                  margin: EdgeInsets.only(top: 0),
                                  padding:
                                      EdgeInsets.only(left: 154, right: 20),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: StadiumBorder(),
                                      shadowColor: Colors.black,
                                      side: BorderSide(
                                          width: 1,
                                          color:
                                              Color.fromARGB(255, 68, 68, 68)),
                                      minimumSize: Size(100, 30),
                                    ),
                                    child: Text(
                                      _myProfile
                                          ? 'Edit Profile'
                                          : (_alreadyFollowed
                                              ? 'unFollow'
                                              : 'Follow'),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: () {
                                      if (_myProfile) {
                                      } else if (_alreadyFollowed) {
                                      } else {}
                                    },
                                  ),
                                )
                                // else if (_myProfile == true)
                                //   (Container(
                                //     margin: EdgeInsets.only(top: 0),
                                //     padding:
                                //         EdgeInsets.only(left: 155, right: 20),
                                //     child: ElevatedButton(
                                //       style: ElevatedButton.styleFrom(
                                //         shape: StadiumBorder(),
                                //         shadowColor: Colors.black,
                                //         side: BorderSide(
                                //             width: 1,
                                //             color: Color.fromARGB(
                                //                 255, 68, 68, 68)),
                                //         minimumSize: Size(100, 30),
                                //       ),
                                //       child: Text(
                                //         'Edit profile',
                                //         style: TextStyle(
                                //           fontSize: 14,
                                //           color: Colors.white,
                                //         ),
                                //       ),
                                //       onPressed: () {},
                                //     ),
                                //   ))
                              ],
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 0),
                                padding: EdgeInsets.only(left: 15, right: 32),
                                child: Text(
                                  "username",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'PlayfairDisplay',
                                      fontStyle: FontStyle.italic,
                                      fontSize: 17.0),
                                )),
                            Container(
                                margin: EdgeInsets.only(top: 10.0),
                                padding: EdgeInsets.only(left: 15, right: 32),
                                child: Text(
                                  "Bio",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15.0),
                                )),
                            Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 0.0, bottom: 10),
                                  padding: EdgeInsets.only(left: 10, right: 5),
                                  child: TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        '${_followersCount} followers',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 185, 182, 182),
                                          fontSize: 12.0,
                                        ),
                                      )),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 0.0, bottom: 10),
                                  padding: EdgeInsets.only(left: 10, right: 32),
                                  child: TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        '${_followingCount} following',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 185, 182, 182),
                                          fontSize: 12.0,
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: TabBarView(children: [
                Timeline(tweets),
                Timeline(tweets),
                Timeline(tweets),
                Timeline(tweets),
              ]
                  //_tabs.map((String name) {
                  //   return SafeArea(
                  //     top: false,
                  //     bottom: false,
                  //     child: Builder(
                  //       builder: (BuildContext context) {
                  //         return CustomScrollView(
                  //           key: PageStorageKey<String>(name),
                  //           slivers: <Widget>[
                  //             SliverOverlapInjector(
                  //               handle: NestedScrollView
                  //                   .sliverOverlapAbsorberHandleFor(context),
                  //             ),
                  //             SliverPadding(
                  //               padding: const EdgeInsets.all(8.0),
                  //               sliver: SliverFixedExtentList(
                  //                 itemExtent: 48.0,
                  //                 delegate: SliverChildBuilderDelegate(
                  //                   (BuildContext context, int index) {
                  //                     return Text('Text');
                  //                   },
                  //                   childCount: 30,
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         );
                  //       },
                  //     ),
                  //   );
                  // }).toList(),
                  ),
            ),
          ),
        ));
  }
}
