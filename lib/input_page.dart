import 'package:flutter/material.dart';

class InputPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('가전기기 정보 입력'),
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Center(
              child: RaisedButton(
                child: Text('Next'),
                onPressed: () {
                  Navigator.pushNamed(context, '/second');
                },
              ))),
    );
  }
}
