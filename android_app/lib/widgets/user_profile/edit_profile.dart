import 'package:android_app/widgets/user_profile/Follow_button.dart';
import 'package:android_app/widgets/user_profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:android_app/widgets/Tweets/tweet.dart';
import 'package:android_app/widgets/timeline.dart';
import 'package:android_app/widgets/user_profile/Show_followers_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:share_plus/share_plus.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:android_app/constants.dart';
import 'package:android_app/functions/http_functions.dart';
import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'dart:io';

///class that creates the edit profile settings page (incomplete)
class Edit_Profile extends StatefulWidget {
  //const Edit_Profile({Key? key}) : super(key: key);
  String username;
  String token;
  Edit_Profile(this.username, this.token);
  @override
  State<Edit_Profile> createState() => _Edit_ProfileState();
}

class _Edit_ProfileState extends State<Edit_Profile> {
  void _goBack(BuildContext ctx) {
    Navigator.pop(ctx);
  }

  late var HeaderImage;
  CircleAvatar profileImage = CircleAvatar(
    backgroundImage: new AssetImage('assets/images/user_icon.png'),
    radius: 35,
    backgroundColor: Colors.grey,
  );
  late var name;
  late var _bio;
  late var country;
  late var city;
  late String website = "";
  late DateTime birthdate = DateTime(2000, 05, 15);
  TextEditingController countrypick = TextEditingController();
  TextEditingController statepick = TextEditingController();
  TextEditingController citypick = TextEditingController();
  late final Future? myFuture;

  ///function to initialise the date picker and set dateTime variable with user input
  Future PickDate(BuildContext context) async {
    final newdate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 05, 15),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (newdate == null) return;

    setState(() {
      birthdate = newdate;
    });
  }

  ///function to fetch user data from the server
  Future<void> getUserData() async {
    var data;
    print("getting user data edit profile");
    var url = Uri.parse("http://34.236.108.123:3000/settings/profile");
    try {
      var response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + widget.token
        },
      );
      print("${response.statusCode}");
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        print("${response.body}");
        if (data != null) {
          setState(() {
            if (data['image'] != null) {
              profileImage = CircleAvatar(
                backgroundImage: new NetworkImage(data['image']),
                radius: 35,
                backgroundColor: Colors.grey,
              );
            }
            HeaderImage = data['headerImage'];
            birthdate = DateTime.parse(data['birthdate'] as String);
            name = data['name'] as String;
            //profileImage = data['image'];
            city = data['city'] as String;
            country = data['country'] as String;
            _bio = data['bio'] as String;
            //website = data['website'] as String;
          });
        }
      } else {
        print('fetch error');
      }
    } on Exception catch (e) {
      print('error: $e');
    }
  }

  ///function to send a patch request with modified user data to the server
  Future<void> httprequestpatch() async {
    print('patcheditprofile');
    var url = Uri.parse('http://${MY_IP_ADDRESS}:3000/settings/profile');

    var response = await http.patch(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + widget.token,
      },
      body: json.encode(
        <String, String>{
          "name": "${name}",
          "bio": "${_bio}",
          "country": "${countrypick.text}",
          "city": "${citypick.text}",
          "website": "${website}",
          "birthdate": birthdate.toString(),
          "image": ""
        },
      ),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  @override
  void initState() {
    setState(() {
      myFuture = getUserData();
    });
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: myFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ));

            default:
              return MaterialApp(
                theme: ThemeData(
                  appBarTheme: AppBarTheme(
                    backgroundColor: Colors.white,
                    centerTitle: true,
                  ),
                ),
                home: Scaffold(
                  resizeToAvoidBottomInset: false,
                  appBar: AppBar(
                    title: Text(
                      'Edit profile',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: TextButton(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                        ),
                      ),
                      onPressed: () {
                        _goBack(context);
                      },
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          httprequestpatch();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profile(
                                      widget.username, false, widget.token)));
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      )
                    ],
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Stack(
                          clipBehavior: Clip.none,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 150,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1238.jpg"),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 30,
                              top: 115,
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                    padding: EdgeInsets.only(bottom: 20),
                                    alignment: Alignment.topLeft,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 45,
                                      child: profileImage,
                                    )),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 100,
                              padding:
                                  EdgeInsets.only(top: 20, left: 20, right: 10),
                              child: Text(
                                "Name",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            SizedBox(
                              width: 250,
                              child: Form(
                                  child: TextFormField(
                                decoration:
                                    InputDecoration(hintText: "Add your name"),
                                textAlignVertical: TextAlignVertical.bottom,
                                initialValue: "${name}",
                                autofocus: false,
                                keyboardType: TextInputType.text,
                                onChanged: (value) {
                                  setState(() {
                                    if (value != null) {
                                      name = value;
                                    }
                                  });
                                },
                              )),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 100,
                              padding:
                                  EdgeInsets.only(top: 20, left: 20, right: 10),
                              child: Text(
                                "Bio",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            SizedBox(
                              width: 250,
                              child: Form(
                                  child: TextFormField(
                                decoration: InputDecoration(
                                    hintText: "Add a bio to your profile"),
                                textAlignVertical: TextAlignVertical.bottom,
                                initialValue: "${_bio}",
                                autofocus: false,
                                keyboardType: TextInputType.text,
                                onChanged: (value) {
                                  setState(() {
                                    if (value != null) {
                                      _bio = value;
                                    }
                                  });
                                },
                              )),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 100,
                              padding:
                                  EdgeInsets.only(top: 20, left: 20, right: 10),
                              child: Text(
                                "Location",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            Container(
                                width: 200,
                                child: CountryStateCityPicker(
                                    country: countrypick,
                                    state: statepick,
                                    city: citypick,
                                    textFieldInputBorder:
                                        UnderlineInputBorder())
                                // CSCPicker(
                                //   flagState: CountryFlag.DISABLE,
                                //   layout: Layout.horizontal,
                                //   countrySearchPlaceholder: "Country",
                                //   showCities: true,
                                //   showStates: true,
                                //   defaultCountry: DefaultCountry.Egypt,
                                //   citySearchPlaceholder: "City",
                                //   countryDropdownLabel: "*Country",
                                //   cityDropdownLabel: "*City",
                                //   selectedItemStyle: TextStyle(
                                //     color: Colors.black,
                                //     fontSize: 14,
                                //   ),
                                //   dropdownDecoration: BoxDecoration(
                                //       borderRadius: BorderRadius.all(Radius.circular(10)),
                                //       color: Colors.white,
                                //       border: Border.all(
                                //           color: Colors.grey.shade300, width: 1)),
                                //   onCountryChanged: (value) {
                                //     setState(() {
                                //       country = value;
                                //     });
                                //   },
                                //   onCityChanged: (value) {
                                //     setState(() {
                                //       city = value.toString();
                                //     });
                                //   },
                                // ),
                                )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 100,
                              padding:
                                  EdgeInsets.only(top: 20, left: 20, right: 10),
                              child: Text(
                                "Website",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            SizedBox(
                              width: 250,
                              child: Form(
                                  child: TextFormField(
                                decoration: InputDecoration(
                                    hintText: "Add your website"),
                                textAlignVertical: TextAlignVertical.bottom,
                                initialValue: "${website}",
                                autofocus: false,
                                keyboardType: TextInputType.text,
                                onChanged: (value) {
                                  setState(() {
                                    if (value != null) {
                                      website = value;
                                    }
                                  });
                                },
                              )),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 100,
                              padding:
                                  EdgeInsets.only(top: 20, left: 20, right: 10),
                              child: Text(
                                "Birth date",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            GestureDetector(
                                onTap: () {
                                  PickDate(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.only(top: 20),
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    '${birthdate.month}/${birthdate.day}/${birthdate.year}',
                                    style: TextStyle(
                                      fontFamily: 'RalewayMedium',
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
          }
        });
  }
}
