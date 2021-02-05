import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'my_town_view.dart';

class MyTown extends StatefulWidget {
  @override
  _MyTownState createState() => _MyTownState();
}

class _MyTownState extends State<MyTown> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  Stream<DocumentSnapshot> currentStream;

  void initState() {
    super.initState();
    currentStream =
        firestore.collection('user').doc(auth.currentUser.uid).snapshots();
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
          return initMyTown(snapshot);
        },
      ),
    );
  }

  initMyTown(AsyncSnapshot<DocumentSnapshot> snapshot) {
    Stream<DocumentSnapshot> document =
    firestore.collection("power_region")
      .doc(snapshot.data['region']).snapshots();
    return StreamBuilder(
      stream: document,
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        return MyTownView(snapshot.data);
      },
    );
  }
}