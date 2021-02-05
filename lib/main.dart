import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'join_page.dart';
import 'my_page.dart';
import 'input_page.dart';
import 'welcome_page.dart';
import 'calendar_page.dart';
import 'crud_page.dart';
import 'home_page.dart';
import 'chart_page.dart';
import 'navi_page.dart';
import 'my_power_page.dart';
import 'my_power2_page.dart';
import 'my_town.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MainPage());
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Main Page',
      debugShowCheckedModeBanner: false,
      initialRoute: '/welcome',
      routes: {
        '/welcome': (context) => Welcome(), //completed
        '/login': (context) => LoginPage(), //completed
        //completed
        '/my_page': (context) => MyPage(), //completed
        '/input': (context) => InputPage(),
        '/join': (context) => JoinPage(),
        '/calendar': (context) => CalendarPage(),
        '/crud': (context) => CrudPage(),
        '/home': (context) => HomePage(),
        '/navi': (context) => NaviPage(),
        '/func_my_power': (context) => MyPowerPage("2021-02"),
        '/func_order_by_devices': (context) => MyPower2Page("2021-02"),
        '/my_town': (context) => MyTown(),
        // '/my_town': (context) => ChartPage(200),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}



