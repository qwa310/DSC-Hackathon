import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../constants.dart';

class CalendarScreen extends StatefulWidget {
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context).settings.arguments;
    final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          width: _screenSize.width,
          height: _screenSize.height,
          decoration: kRegularDecoration,
          padding: const EdgeInsets.all(30.0),
          child: new Swiper(
              control: SwiperControl(
                color: Colors.black38,
              ),
              itemCount: 200,
              scale: 0.6,
              viewportFraction: 0.9,
              itemBuilder: (BuildContext context, int index) {
                return new Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      height: _screenSize.height * 0.2,
                      child: Text(
                        nextYear(args['year'], index),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    monthBtn(
                        left: 1,
                        middle: 2,
                        right: 3,
                        year: nextYear(args['year'], index)),
                    monthBtn(
                        left: 4,
                        middle: 5,
                        right: 6,
                        year: nextYear(args['year'], index)),
                    monthBtn(
                        left: 7,
                        middle: 8,
                        right: 9,
                        year: nextYear(args['year'], index)),
                    monthBtn(
                        left: 10,
                        middle: 11,
                        right: 12,
                        year: nextYear(args['year'], index)),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                );
              })),
    );
  }

  String nextYear(String year, int index) {
    int nextYear = int.parse(year) + index;
    return nextYear.toString();
  }

  Widget monthBtn({int left, int middle, int right, String year}) {
    return Row(
      children: <Widget>[
        makeBtn(left, width: 60, height: 60, year: year),
        makeBtn(middle, width: 60, height: 60, year: year),
        makeBtn(right, width: 60, height: 60, year: year),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    );
  }

  Widget makeBtn(int title, {double width, double height, String year}) {
    return Container(
      width: width,
      height: height,
      child: FlatButton(
        onPressed: () {
          var arg = '';
          if (title.bitLength < 10) {
            arg = year + '-0' + title.toString();
          } else {
            arg = year + '-' + title.toString();
          }
          print("!!!!!!!!!!!!!!!calendar!!!!!!!!!!!!!!!!!!!");
          print(arg);
          print("!!!!!!!!!!!!!!!calendar!!!!!!!!!!!!!!!!!!!");
          Navigator.of(context).pushNamed('power2_result', arguments: arg);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        child: Center(
          child: Text(
            title.toString(),
            style: TextStyle(
              fontSize: 23.0,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
