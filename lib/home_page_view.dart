import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePageView extends StatelessWidget {
  final DocumentSnapshot documentData;
  HomePageView(this.documentData);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: _screenSize.width,
        height: _screenSize.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE7F3EB),
              Color(0xFFF8F5E1)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/func_my_power'); //리스트뷰로 이동
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
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: _screenSize.height * 0.01,
                      ),
                      Text('지난 달보다 이번 달에',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                        ),
                      ),
                      SizedBox(
                        height: _screenSize.height * 0.01,
                      ),
                      Text(
                        '휴대폰을 10시간',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                        ),
                      ),
                      SizedBox(
                        height: _screenSize.height * 0.01,
                      ),
                      Text('더 사용했어요',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0,10,0,0),
                        alignment: Alignment.centerRight,
                        child : ButtonTheme(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                            side: BorderSide(
                              color: Colors.black54,
                              width: 1.3,
                            ),
                          ),
                          child: FlatButton(
                            minWidth: _screenSize.width * 0.015,
                            height: _screenSize.height * 0.015,
                            color: Colors.transparent,
                            child: Text('전력 소비량 측정하기',
                              style : TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                            padding: EdgeInsets.all(6.0),
                            onPressed: () {
                              // Navigator.pushNamed(context, '/crud'); // 기존에 민서님이 작업하시던 루트
                              Navigator.pushNamed(context, '/input'); // create 여기 페이지가 일찍 될 것 같진 않은데,
                              // 기능 확인해보시라고 인풋페이지 일단 둡니다! 여기서 값 써보세요
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  width: _screenSize.width,
                  height:  _screenSize.height * 0.35,
                  margin: EdgeInsets.fromLTRB(0, 30, 30, 0),
                ),
              ),
              Container(
                width: _screenSize.width * 0.6,
                height:  _screenSize.height * 0.3,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(2.0, 4.0),
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                margin: EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/my_town');
                  },
                  child: Stack(
                    children: <Widget>[
                      Image.asset('images/home.png',
                        width: _screenSize.width,
                        height: _screenSize.height,
                        fit: BoxFit.fill,
                      ),
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          '한 눈에 보는 우리 동네 전력 소비량 ->',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          '한 눈에 보는 우리 동네 전력 소비량 ->',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/func_order_by_devices');
                    },
                    child: Container(
                      width: _screenSize.width * 0.45,
                      height:  _screenSize.height * 0.25,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(2.0, 4.0),
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(60.0),
                      margin: EdgeInsets.all(10.0),
                      child: Text(
                        '기기별 사용량 순위',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/my_page');
                    },
                    child: Container(
                      width: _screenSize.width * 0.45,
                      height:  _screenSize.height * 0.25,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(2.0, 4.0),
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.fromLTRB(62, 66, 60, 60),
                      margin: EdgeInsets.all(10.0),
                      child: Text(
                        'MY PAGE',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 27,
                        ),
                      ),
                    ),
                  ),
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