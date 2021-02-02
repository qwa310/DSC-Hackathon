import 'package:flutter/material.dart';
import 'result_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class UserElectronics {
  String uid;
  String device;
  String time;
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final _formKey = GlobalKey<FormState>();
  final _dController = TextEditingController();
  final _hController = TextEditingController();
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  @override
  void dispose(){
    //화면 종료 시 컨트롤러 종료
    _dController.dispose();
    _hController.dispose();
    super.dispose();
  }

  void _isUserExist(UserElectronics userElectronics) {
    auth.authStateChanges()
        .listen((User currentUser) {
      if (currentUser == null) {
        Navigator.pushNamed(context, '/login');
      } else {
        userElectronics.uid = currentUser.uid;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userElectronics = UserElectronics();
    _isUserExist(userElectronics);
    return Scaffold(
      appBar: AppBar(
        title: Text('${_getCurrentMonth()}월 전력 소비량 측정'),
      ),
      body: Center(
        child:Container(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '전자 제품 종류',
                  ),
                  keyboardType: TextInputType.text,
                  controller: _dController,
                  validator: (value) {
                    if (true) {
                      userElectronics.device = value;
                    } return null;
                  },
                ),

                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '하루 이용 시간(h)',
                  ),
                  keyboardType: TextInputType.number,
                  controller: _hController,
                  validator: (value){
                    if(value.trim().isEmpty){
                      return '하루 이용 시간을 입력해주세요';
                    } else {
                      userElectronics.time = value;
                    } return null;
                  },
                ),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  alignment: Alignment.centerRight,
                    child: RaisedButton(
                      child: Text('제출'),
                      onPressed: () {
                        if(_formKey.currentState.validate()) {
                          //form 값 검증 시 처리
                          _addElectronics(userElectronics);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ResultPage(
                                    // error 발생. 무슨 용도인지 몰라서 막아두었습니다.
                                    // int.parse(_wController.text.trim()),
                                    // double.parse(_hController.text.trim()),
                                    300, 2
                                  ),
                            ),
                          );
                        }
                      },
                    ))
              ]
            )
          )
        )
      )
    );
  }

  int _getCurrentMonth(){
    var now = DateTime.now();
    return now.month;
  }

  String _getCurrentDate(){
    var now = DateTime.now();
    var format = 'yyyy-MM-dd';
    return DateFormat(format).format(now);
  }

  void _addElectronics(UserElectronics userElectronics) {
    String date = _getCurrentDate();
    firestore
        .collection('user')
        .doc(userElectronics.uid)
        .collection(userElectronics.device)
        .doc(date)
        .set({
      'UsageTime': userElectronics.time,
      'createdDate': date
    });
  }
}
