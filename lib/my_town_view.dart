import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'my_page_view.dart';

class MyTownView extends StatelessWidget {
  final DocumentSnapshot documentData;
  MyTownView(this.documentData);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
            child: ListView(
              children: <Widget>[
                Container(
                  height: _screenSize.height * 0.15,
                  width: _screenSize.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF5FCCCB), Color(0xFFF3DD6E)],
                      begin: Alignment.topLeft, //컬러 시작점
                      end: Alignment.bottomRight, //컬러 끝나는점
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "우리동네, " + documentData.id,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: _screenSize.height * 0.9,
                  width: _screenSize.width,
                  decoration: BoxDecoration(
                    color: Color(0xFFFCFAF4),
                  ),
                  child: Column(
                    children: <Widget>[

                      SizedBox(
                        child: Container(
                          color: Colors.black,
                          height: _screenSize.height * 0.0005,
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            height: _screenSize.height * 0.1,
                            child: FlatButton(
                              minWidth: _screenSize.width,
                              child: Text(
                                '2020-01: ' + documentData['202001'] + '\n2020-02: ' + documentData['202002'],
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }

}
