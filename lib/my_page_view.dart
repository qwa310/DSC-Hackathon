import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyPageView extends StatelessWidget {
  final DocumentSnapshot documentData;
  MyPageView(this.documentData);

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
                      'My Page',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
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
                            width: _screenSize.height * 0.23,
                            height: _screenSize.height * 0.23,
                            child: Image.asset(
                              'images/people.png',
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: Text(
                                  '계정 정보',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: _screenSize.height * 0.015,
                              ),
                              Center(
                                child: Text(
                                  documentData.data()['name'] + ' Saver 님',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
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
                                  fontSize: 20,
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
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
                              color: Colors.black,
                              height: _screenSize.height * 0.0005,
                            ),
                          ),
                          Container(
                            child: FlatButton(
                              minWidth: _screenSize.width,
                              height: _screenSize.height * 0.1,
                              onPressed: () {
                                infoDialog('제작자 정보', 'Team. PowerRangers', context);
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
