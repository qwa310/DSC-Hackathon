import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:power_rangers/calendar_page.dart';

class NaviPageView extends StatelessWidget {
  final DocumentSnapshot documentData;

  NaviPageView(this.documentData);

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
                  'Home',
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
                  Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              documentData.data()['name'] + ' Saver 님!',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.right,
                            ),
                            SizedBox(
                              height: _screenSize.height * 0.002,
                            ),
                            Text(
                              '지난 달보다 이번 달에\n' + documentData.data()['email'] +'\n사용했어요.',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
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
                            Navigator.pushNamed(context, '/crud');
                          },
                          child: Text(
                            '추가 기입',
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
                        height: _screenSize.height * 0.1,
                        child: FlatButton(
                          minWidth: _screenSize.width,
                          onPressed: () {
                            Navigator.pushNamed(context, '/func_my_power');
                          },
                          child: Text(
                            '전력 소비량 통계 서비스',
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
                            Navigator.pushNamed(context, '/func_my_town');
                          },
                          child: Text(
                            '한 눈에 보는 우리 동네 전력 소비량', //온클릭
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
                            Navigator.pushNamed(
                                context, '/func_order_by_devices');
                          },
                          child: Text(
                            '기기별 사용량 순위', //온클릭
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
                            Navigator.pushNamed(context, '/my_page');
                          },
                          child: Text(
                            '마이 페이지', //온클릭
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
                            Navigator.pushNamed(context, '/calendar',
                                arguments: {'year': '2021'});
                          },
                          child: Text(
                            '캘린더', //온클릭
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
        )),
      ),
    );
  }
}
