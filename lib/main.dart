import 'package:flutter/material.dart';
import 'login_page.dart';
import 'power_calculator.dart';
import 'my_page.dart';
import 'input_page.dart';

void main() => runApp(MainPage());

class MainPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Main Page',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => InputPage(),
        '/second': (context) => PowerCalculator(),
        '/third': (context) => MyPage(),
        '/last': (context) => LoginPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}



