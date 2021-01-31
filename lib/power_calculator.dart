import 'package:flutter/material.dart';

class PowerCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('전기 소비량 및 전기세 계산'),
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Center(
              child: RaisedButton(
                child: Text('Next'),
                onPressed: () {
                  Navigator.pushNamed(context, '/third');
                },
              ))),
    );
  }
}
