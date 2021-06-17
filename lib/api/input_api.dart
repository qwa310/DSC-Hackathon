import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import '../screens/input/input_screen.dart';

class InputApi extends StatefulWidget {
  @override
  _InputApiState createState() => _InputApiState();
}

class _InputApiState extends State<InputApi> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  Stream<QuerySnapshot> currentStream;

  void initState() {
    super.initState();
    currentStream = firestore
        .collection("user")
        .doc(auth.currentUser.uid)
        .collection(DateFormat('yyyy-MM').format(DateTime.now()))
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
          return InputScreen(snapshot.data.docs);
        },
      ),
    );
  }
}
