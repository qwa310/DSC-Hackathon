import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'screens.dart';
import 'screens/login/login_screen.dart';

Map<String, Widget Function(BuildContext)> kRoutes = {
  '/welcome': (context) => WelcomeScreen(), //completed
  '/login': (context) => LoginScreen(), //completed
  '/my_page': (context) => MyPageApi(), //completed
  '/join': (context) => JoinScreen(),
  '/calendar': (context) => CalendarScreen(),
  '/input': (context) => InputApi(),
  '/main': (context) => MainApi(),
  '/chart': (context) => ChartScreen(),
};
