import 'package:flutter/material.dart';
import 'login_page.dart';
import 'result_page.dart';
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
      initialRoute: '/input',
      routes: {
        '/input': (context) => InputPage(),
        //'/result': (context) => ResultPage(),
        '/mypage': (context) => MyPage(),
        '/login': (context) => LoginPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}



