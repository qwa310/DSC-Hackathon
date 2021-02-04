import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class User {
  String email;
  String password;
  String name;
}

class JoinPage extends StatefulWidget {
  @override
  _JoinPageState createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _pwController = TextEditingController();
  final _nameController = TextEditingController();
  final _regionController = TextEditingController();
  final _contractController = TextEditingController();
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  String regionSelect, contractSelect;
  List _locations = [
    "서울특별시", "부산광역시", "인천광역시", "울산광역시", "대전광역시", "대구광역시", "광주광역시", "세종특별자치시",
    "제주특별자치도", "강원도", "경기도", "경상남도", "경상북도", "전라남도", "전라북도", "충청남도", "충청북도",
  ];
  List _contractions = [
    "저압 요금","고압 요금",
  ];

  @override
  void dispose() {
    //화면 종료 시 컨트롤러 종료
    _emailController.dispose();
    _pwController.dispose();
    _nameController.dispose();
    _regionController.dispose();
    _contractController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = User();
    final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Center(
            child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF5FCCCB),
                      Color(0xFFF3DD6E)
                    ],
                    begin: Alignment.topLeft, //컬러 시작점
                    end: Alignment.bottomRight, //컬러 끝나는점
                  ),
                ),
                padding: const EdgeInsets.all(15.0),
                child: Form(
                    key: _formKey,
                    child: ListView(
                        children: <Widget>[
                          SizedBox(
                            height: _screenSize.height * 0.07,
                          ),
                          Center(
                            child: Text(
                              '회원가입',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: _screenSize.height * 0.07,
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            autofocus: true,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              hintText: '이메일 입력',
                              hintStyle: TextStyle(color:Colors.white),
                            ),
                            keyboardType: TextInputType.text,
                            controller: _emailController,
                            validator: (value) {
                              if (value.trim().isEmpty) {
                                return '다시 입력해 주세요';
                              } else {
                                user.email = value;
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: _screenSize.height * 0.01,
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            autofocus: true,
                            obscureText: true,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              hintText: '비밀번호 입력',
                              hintStyle: TextStyle(color:Colors.white),
                            ),
                            keyboardType: TextInputType.text,
                            controller: _pwController,
                            validator: (value) {
                              if (value.trim().isEmpty) {
                                return '다시 입력해 주세요';
                              } else {
                                user.password = value;
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                              height: _screenSize.height * 0.01
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            autofocus: true,
                            obscureText: true,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              hintText: '비밀번호 확인',
                              hintStyle: TextStyle(color:Colors.white),
                            ),
                            keyboardType: TextInputType.text,
                            // controller: _pwController,
                            validator: (value) {
                              if (value.trim().isEmpty) {
                                return '다시 입력해 주세요';
                              } else if (value.trim() != user.password) {
                                return '일치하지 않습니다';
                              }return null;
                            },
                          ),
                          SizedBox(
                              height: _screenSize.height * 0.01
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            autofocus: true,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              hintText: '이름 입력',
                              hintStyle: TextStyle(color:Colors.white),
                            ),
                            keyboardType: TextInputType.text,
                            controller: _nameController,
                            validator: (value) {
                              if (value.trim().isEmpty) {
                                return '다시 입력해 주세요';
                              } else {
                                user.name = value;
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                              height: _screenSize.height * 0.01
                          ),

                          Container(
                            padding: const EdgeInsets.fromLTRB(15,0,0,0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: DropdownButton(
                              underline: Container(color: Colors.transparent),
                              dropdownColor: Colors.transparent,
                              value: regionSelect,
                              isExpanded: true,
                              hint : Text('거주지 선택',
                                style: TextStyle(
                                  color: Colors.white,
                                ),),
                              onChanged: (newValue){
                                setState((){
                                  regionSelect = newValue;
                                  FocusScope.of(context).requestFocus(new FocusNode());
                                });
                              },
                              items: _locations.map((valueItem){
                                return DropdownMenuItem(
                                  value: valueItem,
                                  child: Center(
                                    child: Text(
                                      valueItem,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),

                          SizedBox(
                              height: _screenSize.height * 0.01
                          ),

                          Container(
                            padding: const EdgeInsets.fromLTRB(15,0,0,0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: DropdownButton(
                              underline: Container(color: Colors.transparent),
                              dropdownColor: Colors.transparent,
                              value: contractSelect,
                              isExpanded: true,
                              hint : Text('전기요금 계약방식 선택',
                                style: TextStyle(
                                  color: Colors.white,
                                ),),
                              onChanged: (newValue){
                                setState((){
                                  contractSelect = newValue;
                                  FocusScope.of(context).requestFocus(new FocusNode());
                                });
                              },
                              items: _contractions.map((valueItem){
                                return DropdownMenuItem(
                                  value: valueItem,
                                  child: Center(
                                    child: Text(
                                      valueItem,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),

                          Container(
                            margin: const EdgeInsets.fromLTRB(0,50,0,0),
                            alignment: Alignment.center,
                            child : ButtonTheme(
                              minWidth: _screenSize.width * 0.85,
                              height: _screenSize.height * 0.05,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                              child: RaisedButton(
                                color: Colors.white,
                                child: Text(
                                  '당신도 이제 saver!',
                                  style: TextStyle(
                                    color: Color(0xFF5FCCCB),
                                    fontSize: 25,
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    _createUser(user);
                                  }
                                },
                              ),
                            ),
                          ),
                        ]
                    )
                )
            )
        )
    );
  }

  void popupMsg(String msg) {
    showDialog(context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
            content: SingleChildScrollView(
              child: Text(msg),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('확인'),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
            ]
        );},
    );
  }


  Future<int> _createUser(User user) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password)
          .then((cred) {
            firestore
                .collection('user')
                .doc(cred.user.uid)
                .set({
              'uid': cred.user.uid,
              'name': user.name,
              'email': user.email,
              'region': regionSelect,
              'contract': contractSelect,
            }).then((value) => Navigator.pushNamed(context, '/my_page'));
          });
      await FirebaseAuth.instance.signInAnonymously();
      return 1;
    } catch (e) {
      if (e.code == 'email-already-in-use') {
        popupMsg('이미 가입된 이메일 입니다.');
        print('==========================================');
        print('The account already exists for that email.');
        print('==========================================');
      } else if (e.code == 'invalid-email') {
        popupMsg('유효하지 않은 이메일 입니다.');
        print('==========================================');
        print('The email address is badly formatted.');
        print('==========================================');
      } else if (e.code == 'weak-password') {
        popupMsg('비밀번호는 최소 6자리 이상입니다.');
        print('==========================================');
        print('The password provided is too weak.');
        print('==========================================');
      } else {
        print(e);
      }
      return 0;
    }
  }
}

class Question extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.yellow,
        border: Border.all(),
      ),
    );
  }
}
