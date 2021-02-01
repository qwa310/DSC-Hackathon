import 'package:flutter/material.dart';
import 'login_page.dart';
import 'my_page.dart';
import 'input_page.dart';
import 'chart_page.dart';

void main() => runApp(MainPage());

class MainPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Main Page',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/my_page': (context) => MyPage(),
        '/input': (context) => InputPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}



