import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'join_page.dart';
import 'my_page.dart';
import 'welcome_page.dart';
import 'calendar_page.dart';
import 'crud_page.dart';
import 'home_page.dart';
import 'chart_page.dart';
import 'my_power_page.dart';
import 'my_power2_page.dart';
import 'my_town.dart';
import 'graph.dart';

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
        '/my_page': (context) => MyPage(), //completed
        '/join': (context) => JoinPage(),
        '/calendar': (context) => CalendarPage(),
        '/crud': (context) => CrudPage(),
        '/home': (context) => HomePage(),
        '/my_town': (context) => MyTown(),
        '/chart':(context) => ChartPage(),
      },
      onGenerateRoute: (RouteSettings settings) {
        var routes = <String, WidgetBuilder>{
          'my_power': (context) => MyPowerPage(settings.arguments),
          'my_power2': (context) => MyPower2Page(settings.arguments),
        };
        WidgetBuilder builder = routes[settings.name];
        return MaterialPageRoute(builder: (ctx) => builder(ctx));
      },
      theme: ThemeData(
        fontFamily: 'NanumSquare',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
