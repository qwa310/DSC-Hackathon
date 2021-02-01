import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChartPage extends StatelessWidget {
  final double result; //소비 전력량
  double avg = 200.4; //지역별 평균 소비 전력량 -> 서버(db)를 통해서 가져올 것
  ChartPage(this.result);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Graph'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomPaint(
              size: Size(300, 300),
              painter: PieChart(percentage : result, average: avg), //percentage
            ),
            Container(
              child : RaisedButton(
                child: Text('제출'),
                onPressed: () {
                  Navigator.pushNamed(context, '/my_page');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PieChart extends CustomPainter {
  final double percentage;
  final double average;
  final double textScaleFactor;

  PieChart({@required this.percentage, this.average, this.textScaleFactor = 1.0});

  @override
  void paint(Canvas canvas, Size size){
    Paint paint = Paint()
        ..color = Colors.indigo
        ..strokeWidth = 12.0
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

    double radius = min(size.width / 2 - paint.strokeWidth /2, size.height / 2 - paint.strokeWidth / 2);

    Offset center = Offset(size.width / 2, size.height / 2);

    //원 그래프 그리는 함수
    canvas.drawCircle(center, radius, paint);

    double arcAngle = 2 * pi * (percentage / average);
    paint..color = Colors.deepOrangeAccent;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), - pi / 2,
        arcAngle, false, paint);
    textSet(canvas, size, '$percentage / $average');
  }

  void textSet(Canvas canvas, Size size, String text) {
    double fontSize = getFontSize(size, text);

    TextSpan sp = TextSpan(
      text: text,
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.black
      ),
    );

    TextPainter tp = TextPainter(text: sp, textDirection: TextDirection.ltr);

    tp.layout();

    double dx = size.width / 2 - tp.width / 2;
    double dy = size.height / 2 - tp.height / 2;

    Offset offset = Offset(dx, dy);
    tp.paint(canvas, offset);
  }

  double getFontSize(Size size, String text) {
    return size.width / text.length * textScaleFactor;
  }

  @override
  bool shouldRepaint(PieChart old){
    return old.percentage != percentage;
  }
}