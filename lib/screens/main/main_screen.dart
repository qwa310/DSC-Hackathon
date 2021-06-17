import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../../constants.dart';

class MainScreen extends StatelessWidget {
  final num result;
  final DocumentSnapshot documentData;
  MainScreen(this.documentData, this.result);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: _screenSize.width,
        height: _screenSize.height,
        decoration: kRegularDecoration,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('power_result',
                      arguments: DateFormat('yyyy-MM').format(DateTime.now()));
                },
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: _screenSize.height * 0.05,
                      ),
                      Text(
                        documentData.data()['name'] + ' Saver 님!',
                        textAlign: TextAlign.right,
                        style: kBigestTextStyle,
                      ),
                      SizedBox(
                        height: _screenSize.height * 0.005,
                      ),
                      Text(
                        '이번 달에',
                        textAlign: TextAlign.right,
                        style: kBigTextStyle,
                      ),
                      SizedBox(
                        height: _screenSize.height * 0.005,
                      ),
                      Text(
                        "${result.toInt().toString()} WH를",
                        textAlign: TextAlign.right,
                        style: kBigTextStyle,
                      ),
                      SizedBox(
                        height: _screenSize.height * 0.005,
                      ),
                      Text(
                        '사용했어요!',
                        textAlign: TextAlign.right,
                        style: kBigTextStyle,
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: ButtonTheme(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                            side: BorderSide(
                              color: Colors.black54,
                              width: 1.3,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              IconButton(
                                  icon: new Icon(
                                    Icons.calendar_today,
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/calendar',
                                        arguments: {
                                          'year': DateFormat('yyyy')
                                              .format(DateTime.now())
                                        });
                                  }),
                              FlatButton(
                                minWidth: _screenSize.width * 0.015,
                                height: _screenSize.height * 0.015,
                                color: Colors.transparent,
                                child: Text(
                                  '전력 소비량 측정하기',
                                  style: kSmallesTextStyle,
                                ),
                                padding: EdgeInsets.all(10.0),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/input');
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  width: _screenSize.width,
                  height: _screenSize.height * 0.35,
                  margin: EdgeInsets.fromLTRB(0, 30, 30, 0),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: Container(
                  width: _screenSize.width * 0.5,
                  height: _screenSize.height * 0.3,
                  decoration: kBoxDecoration,
                  margin: EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/chart', arguments: {
                        'year': DateFormat('yyyy').format(DateTime.now())
                      });
                    },
                    child: Stack(
                      children: <Widget>[
                        Image.asset(
                          'images/home.png',
                          width: _screenSize.width,
                          height: _screenSize.height,
                          fit: BoxFit.fill,
                        ),
                        Container(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            '한 눈에 보는 우리 동네 전력 소비량       ->',
                            style: kMidTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed('power_result',
                            arguments:
                                DateFormat('yyyy-MM').format(DateTime.now()));
                      },
                      child: Container(
                        width: _screenSize.width * 0.45,
                        height: _screenSize.height * 0.25,
                        decoration: kBoxDecoration,
                        padding: EdgeInsets.only(
                            top: _screenSize.height * 0.25 * 0.3),
                        margin: EdgeInsets.all(8.0),
                        child: Text(
                          '기기별\n사용량\n순위',
                          textAlign: TextAlign.center,
                          style: kRegularTextStyle,
                        ),
                      ),
                    ),
                  ),
                  Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/my_page');
                        },
                        child: Container(
                          width: _screenSize.width * 0.45,
                          height: _screenSize.height * 0.25,
                          decoration: kBoxDecoration,
                          padding: EdgeInsets.only(
                              top: _screenSize.height * 0.25 * 0.4),
                          margin: EdgeInsets.all(8.0),
                          child: Text(
                            'MY PAGE',
                            textAlign: TextAlign.center,
                            style: kRegularTextStyle,
                          ),
                        ),
                      )),
                ],
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
          ),
        ),
      ),
    );
  }
}
