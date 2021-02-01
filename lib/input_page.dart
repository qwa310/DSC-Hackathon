import 'package:flutter/material.dart';
import 'result_page.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final _formKey = GlobalKey<FormState>();
  final _wController = TextEditingController();
  final _hController = TextEditingController();

  @override
  void dispose(){
    //화면 종료 시 컨트롤러 종료
    _wController.dispose();
    _hController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('가전기기 정보 입력'),
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
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '소비 전력(W)',
                  ),
                  keyboardType: TextInputType.number,
                  controller: _wController,
                  validator: (value){
                    if(value.trim().isEmpty){
                      return '전자 제품 종류를 입력해주세요';
                    }
                    return null;
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ResultPage(
                                    int.parse(_wController.text.trim()),
                                    double.parse(_hController.text.trim()),
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
}
