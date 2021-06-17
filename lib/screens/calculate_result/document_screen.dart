import 'dart:core';
import 'package:flutter/material.dart';
import '../../constants.dart';

// ignore: must_be_immutable
class DocumentScreen extends StatelessWidget {
  final String device, usageTime, calculate;
  int count = 0;

  DocumentScreen(this.device, this.usageTime, this.calculate);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      width: _screenSize.width,
      height: _screenSize.height * 0.04,
      margin: EdgeInsets.fromLTRB(0, 11, 0, 0),
      child: Center(
        child: ListTile(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: _screenSize.width * 0.25,
                child: Text(
                  device,
                  textAlign: TextAlign.center,
                  style: kSmallTextStyle,
                ),
              ),
              Container(
                width: _screenSize.width * 0.14,
                child: Text(
                  usageTime,
                  textAlign: TextAlign.center,
                  style: kSmallTextStyle,
                ),
              ),
              Container(
                width: _screenSize.width * 0.36,
                child: Text(
                  calculate,
                  textAlign: TextAlign.center,
                  style: kSmallTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
