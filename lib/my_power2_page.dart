import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'my_power2_page_view.dart';

class DateInfo {
  String currentDate, currentMonth, currentYear;
  String lastMonthOfDay, lastMonth, lastYear;
  DateInfo (String s) {
    // 현재 클릭된 달이 현재라면 day를 알 필요가 있고
    var now = DateTime.now();
    if (s == DateFormat('yyyy-MM').format(now)) {
      currentDate = DateFormat('dd').format(now);
      currentMonth = DateFormat('MM').format(now);
      currentYear = DateFormat('yyyy').format(now);
    } else { // 현재 클릭된 달이 과거라면 간단하지
      currentDate = '0'; // 쓰지 않아서 그냥
      currentMonth = s.split("-")[1];
      currentYear = s.split("-")[0];
    }
    if (currentMonth == '01') {
      lastMonth = '12';
      lastYear = (int.parse(currentYear)-1).toString();
      lastMonthOfDay = '31';
    } else {
      lastMonth = (int.parse(currentMonth)-1).toString();
      if (lastMonth.length == 1) lastMonth = "0" + lastMonth;
      lastYear = currentYear;
      if (lastMonth.length == 1) lastYear = "0" + lastYear;
      lastMonthOfDay = DateFormat('dd').format(new DateTime(int.parse(currentYear), int.parse(currentMonth), 0));
    }
    print(lastMonth + "의 총 일 수는 ?" + lastMonthOfDay);
  }
}

// ignore: must_be_immutable
class MyPower2Page extends StatefulWidget {
  final String date;
  num totalLast = 0;
  num totalCurrent = 0;
  MyPower2Page (this.date);


  @override
  _MyPower2PageState createState() => _MyPower2PageState();
}

class _MyPower2PageState extends State<MyPower2Page> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  Stream<QuerySnapshot> currentStream;

  void initState() { // [1] lastMonth 불러오기
    super.initState();
    DateInfo dateInfo = new DateInfo(widget.date);
    print("호출된 기준의 전 달=================: " + dateInfo.lastYear + "-" + dateInfo.lastMonth);
    currentStream =
        firestore.collection('user').doc(auth.currentUser.uid).collection(dateInfo.lastYear + "-" + dateInfo.lastMonth).snapshots();
  }

  initCurrent() { // [3] currentMonth order에 맞게 불러와 view에 넘겨주기
    print("호출된 기준의 전 달=================: " + widget.date);
    Stream<QuerySnapshot> document =
    firestore.collection('user').doc(auth.currentUser.uid).collection(widget.date)
        .orderBy('UsageTime', descending: true).snapshots();

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
        if (DateFormat('yyyyMM').format(DateTime.now()) == dateInfo.currentYear + dateInfo.currentMonth) { // 현재 달 호출
          var result = widget.totalCurrent - (widget.totalLast * num.parse(dateInfo.currentDate) / num.parse(dateInfo.lastMonthOfDay));
          return MyPower2PageView(widget.date, snapshot.data.docs, result);
        } else { // 지난 달 호출
          var result = widget.totalCurrent - widget.totalLast;
          return MyPower2PageView(widget.date, snapshot.data.docs, result);
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
