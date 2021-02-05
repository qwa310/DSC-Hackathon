import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'my_power_page_view.dart';

class DateInfo {
  String currentDate, currentMonth, currentYear;
  String lastMonthOfDay, lastMonth, lastYear;

  DateInfo(String s) {
    // 현재 클릭된 달이 현재라면 day를 알 필요가 있고
    var now = DateTime.now();
    if (s == DateFormat('yyyy-MM').format(now)) {
      currentDate = DateFormat('dd').format(now);
      currentMonth = DateFormat('MM').format(now);
      currentYear = DateFormat('yyyy').format(now);
    } else {
      // 현재 클릭된 달이 과거라면 간단하지
      currentDate = '0'; // 쓰지 않아서 그냥
      currentMonth = s.split("-")[1];
      currentYear = s.split("-")[0];
    }
    if (currentMonth == '01') {
      lastMonth = '12';
      lastYear = (int.parse(currentYear) - 1).toString();
      lastMonthOfDay = '31';
    } else {
      lastMonth = (int.parse(currentMonth) - 1).toString();
      if (lastMonth.length == 1) lastMonth = "0" + lastMonth;
      lastYear = currentYear;
      if (lastMonth.length == 1) lastYear = "0" + lastYear;
      lastMonthOfDay = DateFormat('dd').format(
          new DateTime(int.parse(currentYear), int.parse(currentMonth), 0));
    }
  }
}

// ignore: must_be_immutable
class MyPowerPage extends StatefulWidget {
  final String date;

  MyPowerPage(this.date);

  num totalLast = 0;
  num totalCurrent = 0;

  @override
  _MyPowerPageState createState() => _MyPowerPageState();
}

class _MyPowerPageState extends State<MyPowerPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  Stream<QuerySnapshot> currentStream;

  // [1] lastMonth 불러오기
  void initState() {
    super.initState();
    DateInfo dateInfo = new DateInfo(widget.date);
    currentStream = firestore
        .collection('user')
        .doc(auth.currentUser.uid)
        .collection(dateInfo.lastYear + "-" + dateInfo.lastMonth)
        .snapshots();
  }

  // [3] currentMonth, calculate order에 맞게 불러와 view에 넘겨주기
  initCurrent() {
    Stream<QuerySnapshot> document = firestore
        .collection('user')
        .doc(auth.currentUser.uid)
        .collection(widget.date)
        .orderBy('calculate', descending: true)
        .snapshots();

    return StreamBuilder(
      stream: document,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        // [2] lastMonth의 total 계산하기
        snapshot.data.docs.forEach((element) {
          widget.totalCurrent += element['calculate'];
        });
        DateInfo dateInfo = new DateInfo(widget.date);
        if (DateFormat('yyyyMM').format(DateTime.now()) ==
            dateInfo.currentYear + dateInfo.currentMonth) {
          // 현재를 호출한 경우 -> 계산방식: 현재 사용량 - 전달동안사용량 * (현재 일 수/전 달의 일 수)
          var result = widget.totalCurrent -
              (widget.totalLast *
                  num.parse(dateInfo.currentDate) /
                  num.parse(dateInfo.lastMonthOfDay));
          return MyPowerPageView(widget.date, snapshot.data.docs, result);
        } else {
          // 과거의 달을 호출한 경우 -> 계산방식: 과거의 달 사용량 - 과거의 달의 직 전달 사용량
          var result = widget.totalCurrent - widget.totalLast;
          return MyPowerPageView(widget.date, snapshot.data.docs, result);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: currentStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          print(snapshot);
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          // [2] lastMonth의 total 계산하기
          snapshot.data.docs.forEach((element) {
            widget.totalLast += element['calculate'];
          });
          return initCurrent();
        },
      ),
    );
  }
}
