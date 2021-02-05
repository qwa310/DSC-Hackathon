import 'dart:core';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DocumentView extends StatelessWidget {
  final DocumentSnapshot documentData;
  int count = 0;
  DocumentView(this.documentData);
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      width: _screenSize.width,
      height: _screenSize.height * 0.04,
      margin: EdgeInsets.fromLTRB(30, 20, 0, 0),
      child: Center(
        child: ListTile(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(documentData["device"],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 30),
                Text(documentData["UsageTime"].toString() + '시간',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),),
                SizedBox(width: 30),
                Text(documentData["calculate"].toString() + "(Kw)",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}