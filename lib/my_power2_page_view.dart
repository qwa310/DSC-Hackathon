import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'document_view.dart';

class MyPower2PageView extends StatelessWidget {
  final num result;
  final String date;
  final List<DocumentSnapshot> documents;
  MyPower2PageView(this.date, this.documents, this.result);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("지난 달보다 이번 달에 " + date + "입니다.\nresult은 " + result.toString() +"이고 사용 시간 순"),
      ),
      body: Container (
        child: ListView(
            padding:EdgeInsets.only(top: 20.0),
            children: documents.map((eachDocument) => DocumentView(eachDocument)).toList(),
        ),
      ),
    );
  }
}

