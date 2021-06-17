import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

class ChartScreen extends StatefulWidget {
  ChartScreen({Key key}) : super(key: key);

  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    Map args = ModalRoute.of(context).settings.arguments;
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
        decoration: kReverseDecoration,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: _screenSize.height * 0.15),
              alignment: Alignment.center,
              child: Text(
                args['year'] + "년 우리 동네 전력 소비량",
                style: kRegularTextStyle,
              ),
            ),
            chartDisplay(context),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text('지난해 2월 우리 동네보다\n' + '+3.4(Kw) 사용했어요!',
                  textAlign: TextAlign.center, style: kRegularTextStyle),
            ),
          ],
        ),
      ),
    );
  }

  Widget chartDisplay(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Center(
      child: Container(
        color: Colors.transparent,
        height: _screenSize.height * 0.5,
        child: BezierChart(
          onValueSelected: (value) => print('val = $value'),
          bezierChartScale: BezierChartScale.CUSTOM,
          xAxisCustomValues: const [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
          series: const [
            BezierLine(
              lineColor: Color(0xFFE7D53A),
              lineStrokeWidth: 2,
              label: "소비자 전력 소비량 평균",
              data: [
                DataPoint<double>(value: 238, xAxis: 1),
                DataPoint<double>(value: 242, xAxis: 2),
                DataPoint<double>(value: 228, xAxis: 3),
                DataPoint<double>(value: 232, xAxis: 4),
                DataPoint<double>(value: 215, xAxis: 5),
                DataPoint<double>(value: 217, xAxis: 6),
                DataPoint<double>(value: 220, xAxis: 7),
                DataPoint<double>(value: 268, xAxis: 8),
                DataPoint<double>(value: 313, xAxis: 9),
                DataPoint<double>(value: 215, xAxis: 10),
                DataPoint<double>(value: 222, xAxis: 11),
              ],
            ),
            BezierLine(
              lineColor: Color(0xFFB8C95C),
              lineStrokeWidth: 2,
              label: "지역별 전력 소비량 평균",
              data: [
                DataPoint<double>(value: 246, xAxis: 1),
                DataPoint<double>(value: 245, xAxis: 2),
                DataPoint<double>(value: 230, xAxis: 3),
                DataPoint<double>(value: 232, xAxis: 4),
                DataPoint<double>(value: 218, xAxis: 5),
                DataPoint<double>(value: 225, xAxis: 6),
                DataPoint<double>(value: 233, xAxis: 7),
                DataPoint<double>(value: 280, xAxis: 8),
                DataPoint<double>(value: 292, xAxis: 9),
                DataPoint<double>(value: 217, xAxis: 10),
                DataPoint<double>(value: 221, xAxis: 11),
              ],
            ),
          ],
          config: BezierChartConfig(
            xLinesColor: Colors.black,
            showVerticalIndicator: true,
            verticalIndicatorFixedPosition: false,
            verticalIndicatorColor: Colors.black26,
            verticalIndicatorStrokeWidth: 2.0,
            bubbleIndicatorColor: Colors.black,
            bubbleIndicatorTitleStyle:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
