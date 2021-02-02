import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:power_rangers/my_page.dart';
import 'result_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User {
  String email;
  String password;
  String name;
  String region;
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
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  @override
  void dispose() {
    //화면 종료 시 컨트롤러 종료
    _emailController.dispose();
    _pwController.dispose();
    _nameController.dispose();
    _regionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = User();
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign Up'),
        ),
        body: Center(
            child: Container(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'email',
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
                            height: 10,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'password',
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
                            height: 10,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'password 확인',
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
                            height: 10,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'name',
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
                            height: 10,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'region',
                            ),
                            keyboardType: TextInputType.text,
                            controller: _regionController,
                            validator: (value) {
                              if (value.trim().isEmpty) {
                                return '다시 입력해 주세요';
                              } else {
                                user.region = value;
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
                                  if (_formKey.currentState.validate()) {
                                    _createUser(user);
                                  }
                                  Navigator.pushNamed(context, '/login');
                                },
                              ))
                        ]
                    )
                )
            )
        )
    );
  }

  void popupMsg(String msg){
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

  void  _createUser(User user) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password)
          .then((cred) =>
      {
        firestore
            .collection('user')
            .doc(cred.user.uid)
            .set({
          'uid': cred.user.uid,
          'name': user.name,
          'email': user.email,
          'region': user.region
        })
      }
      );
      await FirebaseAuth.instance.signInAnonymously();
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
    }
  }
}
