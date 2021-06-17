import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/mypage/my_page_screen.dart';

class MyPageApi extends StatefulWidget {
  @override
  _MyPageApiState createState() => _MyPageApiState();
}

class _MyPageApiState extends State<MyPageApi> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  Stream<DocumentSnapshot> currentStream;

  void initState() {
    super.initState();
    currentStream =
        firestore.collection("user").doc(auth.currentUser.uid).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: currentStream,
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          return MyPageScreen(snapshot.data);
        },
      ),
    );
  }
}
