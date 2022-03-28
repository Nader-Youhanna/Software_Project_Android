import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const SizedBox(),
        ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Image.asset(
            'assets/images/logo_icon.png',
            width: 120,
            height: 50,
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(
          height: 90,
        ),
        const SizedBox(
          width: 290,
          child: Text(
            'See what\'s happening in the world right now.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'RalewayMedium',
              fontSize: 26,
              fontWeight: FontWeight.bold,
              //color: Colors.purple,
            ),
          ),
        ),
        SizedBox(
          height: 35,
          width: 265,
          child: ElevatedButton(
            child: const Text(
              'Create Account',
            ),
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
            ),
          ),
        ),
        const SizedBox(
          height: 170,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                    text: 'Have an account already?',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Log in',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}