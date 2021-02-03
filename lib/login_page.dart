import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Form(
            key: _formKey,
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
                padding: const EdgeInsets.all(20.0),
                child: Container(
                    child: ListView(
                        children: <Widget>[
                          SizedBox(
                            height: _screenSize.height * 0.06,
                          ),
                          Image.asset(
                            'images/login.png',
                            width: _screenSize.width * 0.9,
                            height: _screenSize.height * 0.2,
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
                            validator: (input){
                              if(input.isEmpty){
                                return '다시 입력해주세요.';
                              }
                              return null;
                            },
                            onSaved: (input) => user.email = input,
                          ),
                          SizedBox(
                            height: 20,
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
                            validator: (input){
                              if(input.length < 6){
                                return '비밀번호는 최소 6자리 이상이어야 합니다.';
                              }
                              return null;
                            },
                            onSaved: (input) => user.password = input,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0,30,0,0),
                            alignment: Alignment.center,
                            child : ButtonTheme(
                              minWidth: _screenSize.width * 0.9,
                              height: _screenSize.height * 0.05,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                              child: RaisedButton(
                                color: Colors.white,
                                child: Text(
                                  '로그인',
                                  style: TextStyle(
                                    color: Color(0xFF5FCCCB),
                                    fontSize: 20,
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    _login(user);
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: FlatButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/join');
                              },
                              child: Text(
                                '회원가입',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
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

  Future<void> _login(User user) async {
    final formState1 = _formKey.currentState;

    if(formState1.validate()) {
      formState1.save();
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: user.email, password: user.password);
      Navigator.pushNamed(context, '/my_page');
      await FirebaseAuth.instance.signInAnonymously();
    } catch (e) {
      if (e.code == 'user-not-found') {
        popupMsg('이메일 혹은 비밀번호를 잘못 입력하였습니다.');
        print('==========================================');
        print('No user found for that email.');
        print('==========================================');
      } else if (e.code == 'wrong-password') {
        popupMsg('잘못된 비밀번호입니다.');
        print('==========================================');
        print('Wrong password provided for that user.');
        print('==========================================');
      }
    }
  }
}
