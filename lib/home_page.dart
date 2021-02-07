import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page_view.dart';
import 'package:intl/intl.dart';

class DateInfo {
  String currentDate, currentMonth, currentYear;

  DateInfo() {
    var now = DateTime.now();
    currentDate = DateFormat('dd').format(now);
    currentMonth = DateFormat('MM').format(now);
    currentYear = DateFormat('yyyy').format(now);
  }
}

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  num totalCurrent = 0;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  Stream<QuerySnapshot> currentStream;

  // [1-1] currentMonth 불러오기
  void initState() {
    super.initState();
    DateInfo dateInfo = new DateInfo();
    currentStream = firestore
        .collection('user')
        .doc(auth.currentUser.uid)
        .collection(dateInfo.currentYear + "-" + dateInfo.currentMonth)
        .snapshots();
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
          // [1-2] currentMonth의 total 계산하기
          snapshot.data.docs.forEach((element) {
            widget.totalCurrent += element['calculate'];
          });
          return initSecondState();
        },
      ),
    );
  }

  initSecondState() {
    // [2-1] view에 줄 사용자 한 명의 정보 받기
    Stream<DocumentSnapshot> currentStream = firestore
        .collection("user")
        .doc(auth.currentUser.uid)
        .snapshots();
    // [2-2] 현재 총 소비 전력 또는 전기세와 유저 정보 모두 view 에 보내기
    return StreamBuilder(
        stream: currentStream,
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          num result = widget.totalCurrent;
          return HomePageView(snapshot.data, result);
        },
    );
  }
}
