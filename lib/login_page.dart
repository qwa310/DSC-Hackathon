import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:power_rangers/my_page.dart';
import 'result_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User {
  String email;
  String password;
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _pwController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  void dispose() {
    //화면 종료 시 컨트롤러 종료
    _emailController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = User();
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
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
                              } return null;
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
                              } return null;
                            },
                          ),
                          Container(
                              margin: const EdgeInsets.all(10.0),
                              alignment: Alignment.centerRight,
                              child: RaisedButton(
                                child: Text('로그인'),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    _login(user);
                                  }
                                },
                              )),
                          Container(
                              margin: const EdgeInsets.all(10.0),
                              alignment: Alignment.centerRight,
                              child: RaisedButton(
                                child: Text('회원가입'),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/join');
                                }
                          ))
                        ]
                    )
                )
            )
        )
    );
  }

  void _login(User user) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: user.email, password: user.password);
      Navigator.pushNamed(context, '/my_page');
      await FirebaseAuth.instance.signInAnonymously();
    } catch (e) {
      if (e.code == 'user-not-found') {
        print('==========================================');
        print('No user found for that email.');
        print('==========================================');
      } else if (e.code == 'wrong-password') {
        print('==========================================');
        print('Wrong password provided for that user.');
        print('==========================================');
      }
    }
  }
}
