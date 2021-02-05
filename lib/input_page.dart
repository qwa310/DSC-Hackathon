import 'package:flutter/material.dart';
import 'result_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class UserElectronics {
  String uid;
  String device;
  String time;
  String w;
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final _formKey = GlobalKey<FormState>();
  // final _dController = TextEditingController();
  // final _hController = TextEditingController();
  // final _wController = TextEditingController();
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  @override
  void dispose(){
    //화면 종료 시 컨트롤러 종료
    // _dController.dispose();
    // _hController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userElectronics = UserElectronics();
    userElectronics.uid = auth.currentUser.uid;
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
                  // controller: _dController,
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
                  inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                  ],
                  // controller: _hController,
                  validator: (value){
                    if(value.trim().isEmpty){
                      return '하루 이용 시간을 입력해주세요';
                    } else {
                      userElectronics.time = value;
                    } return null;
                  },
                ),

                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '시간 당 와트(W)를 일단 입력해주세요(임시페이지)',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  // controller: _WController,
                  validator: (value){
                    if(value.trim().isEmpty){
                      return '';
                    } else {
                      userElectronics.w = value;
                    }
                    return null;
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
                          Navigator.pushNamed(context, '/func_my_power');
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) =>
                          //         ResultPage(
                          //           // error 발생. 무슨 용도인지 몰라서 막아두었습니다.
                          //           // int.parse(_wController.text.trim()),
                          //           // double.parse(_hController.text.trim()),
                          //           300, 2
                          //         ),
                          //   ),
                          // );
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

  String _getCurrentMonth(){
    var now = DateTime.now();
    var format = 'yyyy-MM';
    return DateFormat(format).format(now);
  }

  String _getCurrentDate(){
    var now = DateTime.now();
    var format = 'yyyy-MM-dd';
    return DateFormat(format).format(now);
  }

  void _addElectronics (UserElectronics userElectronics) async {
    String date = _getCurrentDate();
    String month = _getCurrentMonth();
    if (userElectronics.w != '0') {
      firestore
          .collection('user')
          .doc(userElectronics.uid)
          .collection(month)
          .doc(userElectronics.device)
          .set({
            'device': userElectronics.device,
            'UsageTime': double.parse(userElectronics.time),
            'createdDate': date,
            'modifiedDate': date,
            'user_h_W': userElectronics.w,
            'calculate': double.parse(userElectronics.time) * double.parse(userElectronics.w)
          });
    } else {
      // firestore
      //     .collection('user')
      //     .doc(userElectronics.uid)
      //     .collection(userElectronics.device)
      //     .doc(date)
      //     .set({
      //   'device': userElectronics.device,
      //   'UsageTime': userElectronics.time,
      //   'createdDate': date,
      //   'modifiedDate': date,
      //   'user_h_w': 0,
      //   'calculate': userElectronics.time
      // });

      firestore
          .collection('electronics')
          .where("device", isEqualTo: userElectronics.device)
          .get()
          .then((QuerySnapshot ds) {
            var defaultValue = ds.docs[0]['h_W'];
            print("=================================");
            print("데이터가 있음");
            print(defaultValue);
            print("=================================");
            firestore
                .collection('user')
                .doc(userElectronics.uid)
                .collection(month)
                .doc(userElectronics.device)
                .set({
              'device': userElectronics.device,
              'UsageTime': double.parse(userElectronics.time),
              'createdDate': date,
              'modifiedDate': date,
              'user_h_W': defaultValue,
              'calculate': double.parse(userElectronics.time) * defaultValue
            });
      });

    }
  }
}
