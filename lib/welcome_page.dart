import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  Welcome({
    Key key,
  }) : super(key: key);

  get decoration => null;
  @override
  Widget build(BuildContext context) {
    _waitTwoSeconds().then((value) {
      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.pushReplacementNamed(context, '/home');
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
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF5FCCCB),
                  Color(0xFFF3DD6E)
                ],
                begin: Alignment.topLeft, //컬러 시작점
                end: Alignment.bottomRight, //컬러 끝나는점
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x4d000000),
                  offset: Offset(0, 3),
                  blurRadius: 6,
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              width: 172,
              height: 172,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage('images/logo.png'),
                    fit: BoxFit.fill,
                  )
              ),
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
