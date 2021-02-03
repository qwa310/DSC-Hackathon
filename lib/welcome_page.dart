import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  Welcome({
    Key key,
  }) : super(key: key);

  get decoration => null;
  @override
  Widget build(BuildContext context) {
    _moveNextPage().then((value) => Navigator.pushNamed(context, '/login'));

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(-1.0, -1.0),
                end: Alignment(1.0, 1.0),
                colors: [const Color(0xff5fcccb), const Color(0xfff3dd6e)],
                stops: [0.0, 1.0],
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

  Future<String> _moveNextPage() {
    return new Future<String>.delayed(Duration(seconds: 2));
  }
}
