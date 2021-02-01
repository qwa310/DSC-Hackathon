import 'package:flutter/material.dart';
import 'package:power_rangers/my_page.dart';
import 'result_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _pwController = TextEditingController();

  @override
  void dispose(){
    //화면 종료 시 컨트롤러 종료
    _emailController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign Up'),
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
                              hintText: 'id',
                            ),
                            keyboardType: TextInputType.text,
                            controller: _emailController,
                            validator: (value){
                              if(value.trim().isEmpty){
                                return '다시 입력해 주세요';
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
                              hintText: 'pw',
                            ),
                            keyboardType: TextInputType.text,
                            controller: _pwController,
                            validator: (value){
                              if(value.trim().isEmpty){
                                return '다시 입력해 주세요';
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
                                    Navigator.pushNamed(context, '/my_page');
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
}
