import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget { //월간 전기 사용량 계산하는 class
  final int W; //소비전력(W)
  final double h; //하루이용시간(h)
  final int date = 30;
  double _cal;
  var _result;
  ResultPage(this.W, this.h);

  @override
  Widget build(BuildContext context){
    _cal = ((W * h * date) / 1000); //월간 전기 사용량 계산법: 소비전력(W) × 하루이용시간(h) × 30일
    _result = double.parse(_cal.toStringAsFixed(1));
    return Scaffold(
      appBar: AppBar(
        title: Text('전기 소비량 및 전기세 계산 결과'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              getResult(),
              style: TextStyle(fontSize: 40),
            ),
            Text(
              getState(),
              style: TextStyle(fontSize: 40),
            ),
            RaisedButton(
              child: Text('Next'),
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }

  String getResult(){
    return '월간 전기 사용량 : ${_result}Kw';
  }

  String getState(){
    if(_cal >= 25){
      return 'Over Used';
    }else if (_cal > 18.5){
      return 'Normal';
    }else {
      return 'Under Used';
    }
  }

}