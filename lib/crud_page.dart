import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class UserElectronics {
  String uid;
  String device;
  String time;
}

class CrudPage extends StatefulWidget {
  @override
  _CrudPageState createState() => new _CrudPageState();
}

class _CrudPageState extends State<CrudPage> {
  int _count = 1;
  String title = '+ 추가 기입';

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    List<Widget> _contatos = new List.generate(_count, (int i) => new FormLists());
    return new Scaffold(
        body: new LayoutBuilder(builder: (context, constraint) {
          return new Container(
            width: _screenSize.width,
            height: _screenSize.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFE7F3EB),
                  Color(0xFFF8F5E1)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Center(
                  child: Text(
                    '${_getCurrentMonth()}월 전력 소비량 측정',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  heightFactor: _screenSize.height * 0.004,
                ),
                new Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  height: _screenSize.height * 0.7,
                  width: _screenSize.width * 0.85,
                  child: new ListView(
                    children: _contatos,
                    scrollDirection: Axis.vertical,
                  ),
                ),
                new SizedBox(
                  height: _screenSize.height * 0.005,
                ),
                new FlatButton(
                  onPressed: _addForm,
                  child: new Text(title,
                    style: new TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                    ),
                  ),
                ),
              ],
            ),
          );
        }));
  }

  int _getCurrentMonth(){
    var now = DateTime.now();
    return now.month;
  }

  void _addForm() {
    setState(() {
      if(_count < 10) {
        _count = _count + 1;
        title = '+ 추가 기입';
      }
      if(_count == 10){
        title = ' ';
      }
    });
  }
}

class FormLists extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new SelectItems();
}

class SelectItems extends State<FormLists> {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final userElectronics = UserElectronics();

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return new Container(
      height: _screenSize.height*0.06,
      child: new Row(
        children: <Widget>[
          SizedBox(
            width: _screenSize.width*0.12,
          ),
          new DropdownButton(
            value: deviceSelect,
            items: _devicesItems,
            hint: Text('전자 기기 명',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 17,
              ),
            ),
            onChanged: changedDeviceItem,
            underline: Container(
              color: Colors.transparent,
              width: _screenSize.width,
              height: _screenSize.height,
              alignment: Alignment.center,
            ),
            dropdownColor: Colors.white.withOpacity(0.9),
          ),
          SizedBox(
            width: _screenSize.width*0.12,
          ),
          new DropdownButton(
            value: timeSelect,
            items: _timesItems,
            hint: Text('하루 사용 시간',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 17,
              ),
            ),
            onChanged: changedTimeItem,
            underline: Container(
              color: Colors.transparent,
              alignment: Alignment.center,
            ),
            dropdownColor: Colors.white.withOpacity(0.9),
          ),
        ],
      ),
    );
  }

  List _devices = [
    "TV", "노트북", "모니터", "컴퓨터", "스마트폰", "냉장고", "식기세척기", "에어컨", "청소기",
    "건조기", "세탁기", "밥솥", "토스터", "에어프라이어", "오븐", "전등", "공유기",
  ];

  List _times = ["0.5", "1", "1.5", "2", "2.5", "3", "3.5", "4", "4.5", "5", "5.5", "6", "6.5", "7", "7.5", "8", "8.5", "9", "9.5", "10",
    "10.5", "11", "11.5", "12", "12.5", "13", "13.5", "14", "14.5", "15", "15.5", "16", "16.5", "17", "17.5", "18", "18.5", "19", "19.5",
    "20", "20.5", "21", "21.5", "22", "22.5", "23", "23.5", "24",];

  List<DropdownMenuItem<String>> _devicesItems;
  List<DropdownMenuItem<String>> _timesItems;
  String deviceSelect, timeSelect;

  @override
  void initState() {
    _devicesItems = getDeviceItems();
    _timesItems = getTimeItems();
    deviceSelect = null;
    timeSelect = null;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDeviceItems() {
    List<DropdownMenuItem<String>> deviceList = new List();
    for (String userDevice in _devices) {
      deviceList.add(new DropdownMenuItem(
        value: userDevice,
        child: new Text(
          userDevice,
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
        ),
      ),
      );
    }
    return deviceList;
  }

  List<DropdownMenuItem<String>> getTimeItems() {
    List<DropdownMenuItem<String>> timeList = new List();
    for (String userTime in _times) {
      timeList.add(new DropdownMenuItem(
          value: userTime,
          child: new Text(
            userTime,
            style: TextStyle(
              color: Colors.black,
              fontSize: 17,
            ),
          )
      ));
    }
    return timeList;
  }

  void changedDeviceItem(String selectedDevice) {
    setState(() {
      deviceSelect = selectedDevice;
      userElectronics.device = deviceSelect;
      _addElectronics(userElectronics);
    });
  }
  void changedTimeItem(String selectedTime) {
    setState(() {
      timeSelect = selectedTime;
      userElectronics.time = timeSelect;
      _addElectronics(userElectronics);
    });
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
      'createdDate': date  //month로 변경해야 함.
    });
  }
}
