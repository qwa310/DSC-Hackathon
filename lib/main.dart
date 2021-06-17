import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'api/power_calculated_result_api.dart';
import 'api/power_calculated_second_result_api.dart';
import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/welcome',
      routes: kRoutes,
      onGenerateRoute: (RouteSettings settings) {
        var routes = <String, WidgetBuilder>{
          'power_result': (context) =>
              PowerCalculatedResultApi(settings.arguments),
          'power2_result': (context) =>
              PowerCalculatedSecondResultApi(settings.arguments),
        };
        WidgetBuilder builder = routes[settings.name];
        return MaterialPageRoute(builder: (ctx) => builder(ctx));
      }, // 이 부분은 언젠가 제가 꼭 고쳐서 pr 보내겠습니다!
      theme: ThemeData(
        fontFamily: 'NanumSquare',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
