import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyPageScreen extends StatelessWidget {
  final DocumentSnapshot documentData;
  MyPageScreen(this.documentData);

  void infoDialog(String str1, String str2, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(
          str1,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          str2,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text(
              '닫기',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 19,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFFCFAF4),
          ),
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
                    'My PAGE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: _screenSize.height * 0.20,
                          height: _screenSize.height * 0.20,
                          child: Image.asset(
                            'images/people.png',
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text(
                                '계정 정보',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: _screenSize.height * 0.015,
                            ),
                            Container(
                              child: Text(
                                documentData.data()['name'] + ' Saver 님',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: _screenSize.height * 0.002,
                            ),
                            Text(
                              documentData.data()['email'],
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              height: _screenSize.height * 0.002,
                            ),
                            Text(
                              documentData.data()['region'],
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      child: Container(
                        color: Color(0xFFADADAD),
                        height: _screenSize.height * 0.001,
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          height: _screenSize.height * 0.1,
                          child: FlatButton(
                            minWidth: _screenSize.width,
                            onPressed: () {
                              infoDialog('버전 정보', 'Ver 1.1', context);
                            },
                            child: Text(
                              '버전 정보',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          child: Container(
                            color: Color(0xFFADADAD),
                            height: _screenSize.height * 0.001,
                          ),
                        ),
                        Container(
                          child: FlatButton(
                            minWidth: _screenSize.width,
                            height: _screenSize.height * 0.1,
                            onPressed: () {
                              infoDialog(
                                  '제작자 정보',
                                  '\n⚡Team. PowerRangers⚡\n(DSC HACKATHON)\n\nplan by 이여름\ndesign by 김민서\nFE by 박정민\nBE by 박주은',
                                  context);
                            },
                            child: Text(
                              '제작자 정보', //온클릭
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
          ),
        ),
      ),
    );
  }
}
