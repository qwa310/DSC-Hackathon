import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Page"),
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Center(
              child: RaisedButton(
                child: Text('Next'),
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
              ))),
    );
  }
}