import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class CrudPageView extends StatefulWidget {
  final DocumentSnapshot documentData;
  CrudPageView(this.documentData);

  @override
  _CrudPageViewState createState() => new _CrudPageViewState();
}

class _CrudPageViewState extends State<CrudPageView> {
  int _count = 1;
  String title = '+ 추가 기입';

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    List<Widget> _contatos = new List.generate(_count, (int i) => new FormLists());
    return new Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
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
                  heightFactor: _screenSize.height * 0.007,
                ),
                new Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  height: _screenSize.height * 0.65,
                  width: _screenSize.width * 0.86,
                  child: new ListView(
                    padding: EdgeInsets.fromLTRB(10,30,0,0),
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

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return new Container(
      child: new Row(
        children: <Widget>[
          SizedBox(
            width: _screenSize.width*0.05,
          ),
          new DropdownButton(
            value: deviceSelect,
            items: _devicesItems,
            hint: Text('전자기기 명',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 17,
              ),
            ),
            onChanged: changedDeviceItem,
            underline: Container(
              color: Colors.transparent,
            ),
            dropdownColor: Colors.white.withOpacity(0.9),
          ),
          SizedBox(
            width: _screenSize.width*0.05,
          ),
          new DropdownButton(
            value: timeSelect,
            items: _timesItems,
            hint: Text('사용시간',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 17,
              ),
            ),
            onChanged: changedTimeItem,
            underline: Container(
              color: Colors.transparent,
            ),
            dropdownColor: Colors.white.withOpacity(0.9),
          ),
          SizedBox(
            width: _screenSize.width*0.02,
          ),
          IconButton(
            icon: const Icon(Icons.save_sharp),
            color: Colors.black,
            onPressed: () {
              saveMsg("저장되었습니다.");
              savePower(deviceSelect, timeSelect);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_forever),
            color: Colors.black,
            onPressed: () {
              deleteMsg();
            },
          )
        ],
      ),
    );
  }

  void saveMsg(String msg){
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

  void deleteMsg(){
    showDialog(context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
            content: SingleChildScrollView(
              child: Text("삭제 하시겠습니까?"),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('예'),
                onPressed: (){
                  deletePower(deviceSelect);
                  Navigator.of(context).pop();
                  saveMsg("삭제되었습니다.");
                },
              ),
              FlatButton(
                child: Text('아니오'),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
            ]
        );},
    );
  }

  List _devices = [
    "냉장고", "김치냉장고", "일반세탁기", "드럼세탁기", "정수기", "전기밥솥",
    "청소기", "선풍기", "공기청정기", "형광등", "보일러", "충전기",
    "에어컨", "온풍기", "TV", "전기온풍기", "전기스토브", "제습기", "전기레인지",
    "셋톱박스", "LED램프", "의류건조기", "컴퓨터", "모니터", "프린터", "전자레인지",
    "도어폰", "비데", "공유기"
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
    });
  }
  void changedTimeItem(String selectedTime) {
    setState(() {
      timeSelect = selectedTime;
    });
  }


  String _getCurrentDate(){
    return DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  String _getCurrentYearAndMonth() {
    return DateFormat('yyyy-MM').format(DateTime.now());
  }

  void savePower(String device, String time) {
    String date = _getCurrentDate();
    firestore
        .collection('electronics')
        .where("device", isEqualTo: device)
        .get()
        .then((QuerySnapshot ds) {
      var defaultValue = ds.docs[0]['Wh'];
      firestore
          .collection('user')
          .doc(auth.currentUser.uid)
          .collection(_getCurrentYearAndMonth())
          .doc(device)
          .set({
        'device': device,
        'UsageTime': double.parse(time),
        'createdDate': date,
        'modifiedDate': date,
        'Wh': defaultValue,
        'calculate': double.parse(time) * double.parse(defaultValue)
      });
    });
  }

  void deletePower(String device) {
    firestore.collection('user')
        .doc(auth.currentUser.uid)
        .collection(_getCurrentYearAndMonth())
        .doc(device)
        .delete();
  }
}