import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../constants.dart';

class InputScreen extends StatefulWidget {
  final List<DocumentSnapshot> documentData;

  InputScreen(this.documentData);

  @override
  _InputScreenState createState() => new _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    List<Widget> _contatos = widget.documentData
        .map((eachDocument) => FormLists(
            eachDocument['device'], eachDocument['UsageTime'].toString()))
        .toList();
    if (_contatos.length < 10) {
      for (int i = _contatos.length; i < 10; i++) {
        _contatos.add(FormLists('전자 기기', '시간'));
      }
    }

    return new WillPopScope(
        // 뒤로가기 버튼 눌렀을 때
        onWillPop: () {
          // 쌓인 위젯을 삭제하고 홈으로 이동(데이터새로불러와야해서)
          Navigator.pushNamedAndRemoveUntil(
              context, '/main', (route) => false); // + 애니메이션이 뒤로가는 거면 좋을 듯
          return;
        },
        child: new Scaffold(
            resizeToAvoidBottomInset: false,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.black,
                onPressed: () {
                  // 홈으로 이동(데이터 새로 불러와야 해서) + 애니메이션이 뒤로가는 거면 좋을 듯
                  Navigator.pushReplacementNamed(context, '/main');
                },
              ),
            ),
            body: SingleChildScrollView(
                child: new LayoutBuilder(builder: (context, constraint) {
              return new Container(
                width: _screenSize.width,
                height: _screenSize.height,
                decoration: kRegularDecoration,
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Center(
                      child: Text(
                        '${_getCurrentMonth()}월 전력 소비량 측정',
                        style: kRegularTextStyle,
                      ),
                      heightFactor: _screenSize.height * 0.007,
                    ),
                    new Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(2.0, 4.0),
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                      height: _screenSize.height * 0.65,
                      width: _screenSize.width * 0.86,
                      child: new ListView(
                        padding: EdgeInsets.fromLTRB(10, 30, 0, 0),
                        children: _contatos,
                        scrollDirection: Axis.vertical,
                      ),
                    ),
                  ],
                ),
              );
            }))));
  }

  int _getCurrentMonth() {
    var now = DateTime.now();
    return now.month;
  }
}

class FormLists extends StatefulWidget {
  final String device, usageTime;

  const FormLists(this.device, this.usageTime);

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
            width: _screenSize.width * 0.05,
          ),
          new DropdownButton(
            value: deviceSelect,
            items: _devicesItems,
            hint: Text(
              widget.device,
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
            width: _screenSize.width * 0.05,
          ),
          SizedBox(
            width: _screenSize.width * 0.15,
            height: _screenSize.width * 0.08,
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
              ],
              decoration: InputDecoration(hintText: widget.usageTime),
              onChanged: changedTimeItem,
            ),
          ),
          SizedBox(
            width: _screenSize.width * 0.06,
          ),
          IconButton(
            icon: const Icon(Icons.save_sharp),
            color: Colors.black,
            onPressed: () {
              savePower(deviceSelect, timeSelect);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_forever),
            color: Colors.black,
            onPressed: () {
              deletePower(widget.device);
            },
          )
        ],
      ),
    );
  }

  List _devices = devices;

  List<DropdownMenuItem<String>> _devicesItems;
  String deviceSelect, timeSelect;

  @override
  void initState() {
    _devicesItems = getDeviceItems();
    // _timesItems = getTimeItems();
    deviceSelect = null;
    timeSelect = null;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDeviceItems() {
    List<DropdownMenuItem<String>> deviceList = new List();
    for (String userDevice in _devices) {
      deviceList.add(
        new DropdownMenuItem(
          value: userDevice,
          child: new Text(
            userDevice,
            style: kSmallTextStyle,
          ),
        ),
      );
    }
    return deviceList;
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

  String _getCurrentDate() {
    return DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  String _getCurrentYearAndMonth() {
    return DateFormat('yyyy-MM').format(DateTime.now());
  }

  void savePower(String device, String time) {
    if (device != null && time != null) {
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
        }).then((value) {
          Navigator.pushReplacementNamed(context, '/input');
        });
      });
    }
  }

  void deletePower(String device) {
    firestore
        .collection('user')
        .doc(auth.currentUser.uid)
        .collection(_getCurrentYearAndMonth())
        .doc(device)
        .delete()
        .then((value) {
      Navigator.pushReplacementNamed(context, '/input');
    });
  }
}
