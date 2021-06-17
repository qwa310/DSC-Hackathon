import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({
    Key key,
  }) : super(key: key);

  get decoration => null;
  @override
  Widget build(BuildContext context) {
    _waitTwoSeconds().then((value) {
      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.pushReplacementNamed(context, '/main');
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: kWelcomeDecoration,
          ),
          Center(
            child: Container(
              width: 172,
              height: 172,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: const AssetImage('images/logo.png'),
                fit: BoxFit.fill,
              )),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> _waitTwoSeconds() {
    return new Future<String>.delayed(Duration(seconds: 4));
  }
}
