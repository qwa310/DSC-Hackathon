import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';

class ChartPage extends StatefulWidget {
  ChartPage({Key key}) : super(key: key);

  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF5FCCCB),
              Color(0xFFF3DD6E)
            ],
            begin: Alignment.topLeft, //컬러 시작점
            end: Alignment.bottomRight, //컬러 끝나는점
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: _screenSize.height * 0.2,
              alignment: Alignment.center,
              child: Text(
                "n월 우리 동네 전력 소비량",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ChartDisplay(context),
            Container(
              height: _screenSize.height * 0.3,
              margin: EdgeInsets.all(30),
              child: Text('지난해 n월 우리 동네보다\n' + 'n(Kw) 사용했어요!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ChartDisplay(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Center(
      child: Container(
        color: Colors.transparent,
        height: _screenSize.height * 0.4,
        child: BezierChart(
          onValueSelected: (value) => print('val = $value'),
          bezierChartScale: BezierChartScale.CUSTOM,
          xAxisCustomValues: const [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
          series: const [
            BezierLine(
              lineColor: Colors.deepPurpleAccent,
              lineStrokeWidth: 2,
              label: "소비자 전력 소비량 평균",
              data: [
                DataPoint<double>(value: 120, xAxis: 1),
                DataPoint<double>(value: 110, xAxis: 2),
                DataPoint<double>(value: 75, xAxis: 3),
                DataPoint<double>(value: 70, xAxis: 4),
                DataPoint<double>(value: 70, xAxis: 5),
                DataPoint<double>(value: 85, xAxis: 6),
                DataPoint<double>(value: 100, xAxis: 7),
                DataPoint<double>(value: 125, xAxis: 8),
                DataPoint<double>(value: 140, xAxis: 9),
                DataPoint<double>(value: 80, xAxis: 10),
                DataPoint<double>(value: 95, xAxis: 11),
                DataPoint<double>(value: 100, xAxis: 12),
              ],
            ),
            BezierLine(
              lineColor: Colors.orange,
              lineStrokeWidth: 2,
              label: "지역별 전력 소비량 평균",
              data: [
                DataPoint<double>(value: 140, xAxis: 1),
                DataPoint<double>(value: 120, xAxis: 2),
                DataPoint<double>(value: 70, xAxis: 3),
                DataPoint<double>(value: 80, xAxis: 4),
                DataPoint<double>(value: 75, xAxis: 5),
                DataPoint<double>(value: 80, xAxis: 6),
                DataPoint<double>(value: 90, xAxis: 7),
                DataPoint<double>(value: 130, xAxis: 8),
                DataPoint<double>(value: 150, xAxis: 9),
                DataPoint<double>(value: 70, xAxis: 10),
                DataPoint<double>(value: 90, xAxis: 11),
                DataPoint<double>(value: 105, xAxis: 12),
              ],
            ),
          ],
          config: BezierChartConfig(
            showVerticalIndicator: true,
            verticalIndicatorFixedPosition: false,
            verticalIndicatorColor: Colors.black26,
            verticalIndicatorStrokeWidth: 2.0,
            bubbleIndicatorColor: Colors.black,
            bubbleIndicatorTitleStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold
            ),
            bubbleIndicatorValueStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            backgroundColor: Colors.transparent,
            displayLinesXAxis: true,
            contentWidth: _screenSize.width * 0.9,
            updatePositionOnTap: true,
          ),
        ),
      ),
    );
  }
}