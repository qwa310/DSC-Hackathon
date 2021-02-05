import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'my_power2_page_view.dart';

// ignore: must_be_immutable
class MyPower2Page extends StatefulWidget {
  final String date;
  num total = 0;
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
    currentStream =
        firestore.collection('user').doc(auth.currentUser.uid).collection(widget.date).snapshots();
  }

  initCurrent() { // currentMonth order에 맞게 불러와 view에 넘겨주기
    Stream<QuerySnapshot> document =
    firestore.collection('user').doc(auth.currentUser.uid).collection(widget.date)
        .orderBy('UsageTime', descending: true).snapshots();

    return StreamBuilder(
      stream: document,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        } return MyPower2PageView(widget.date, snapshot.data.docs, widget.total);
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
            widget.total += element['calculate'];
          });
          return initCurrent();
        },
      ),
    );
  }
}
