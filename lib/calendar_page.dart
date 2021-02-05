import 'package:flutter/material.dart';
import 'package:power_rangers/my_power_page.dart';

class CalendarPage extends StatefulWidget {

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>{
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    Map args = ModalRoute.of(context).settings.arguments;
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
        padding: const EdgeInsets.all(30.0),
        child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                height: _screenSize.height * 0.2,
                child: Text(args['year'],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              monthBtn(left: 1, middle: 2, right: 3, year: args['year']),
              monthBtn(left: 4, middle: 5, right: 6, year: args['year']),
              monthBtn(left: 7, middle: 8, right: 9, year: args['year']),
              monthBtn(left: 10, middle: 11, right: 12, year: args['year']),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
      ),
    );
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
          onPressed: (){
            print(title.toString());
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  var arg = '';
                  print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                  if (title.bitLength < 10) {
                    arg = year + '-0' + title.toString();
                  } else {
                    arg = year + '-' + title.toString();
                  }
                  print(arg);
                  print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                  return MyPowerPage(arg);
                }
              ),
            );  //소비량 화면으로 전환
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100)
          ),
          child: Center(
            child: Text(
              title.toString(),
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
              ),
            ),
          ),
        ),
    );
  }
}
