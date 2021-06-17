import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'document_screen.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../constants.dart';

class PowerCalculatedResultScreen extends StatelessWidget {
  final num result;
  final String date;
  final List<DocumentSnapshot> documents;

  PowerCalculatedResultScreen(this.date, this.documents, this.result);

  @override
  Widget build(BuildContext context) {
    List<Widget> _contatos = new List<Widget>();
    _contatos.add(DocumentScreen('전자기기', '시간', '전력 소비량 순'));
    _contatos += documents
        .map((eachDocument) => DocumentScreen(
            eachDocument['device'],
            eachDocument['UsageTime'].toString(),
            eachDocument["calculate"].toInt().toString() + 'WH'))
        .toList();

    final _screenSize = MediaQuery.of(context).size;
    return new Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: new LayoutBuilder(
        builder: (context, constraint) {
          return new Container(
            width: double.infinity,
            height: double.infinity,
            decoration: kRegularDecoration,
            child: new Swiper(
                // controller: new SwiperController(),
                // control: SwiperControl(
                //   color: Colors.black,
                // ),
                itemCount: 200,
                scale: 0.6,
                viewportFraction: 0.9,
                itemBuilder: (BuildContext context, int index) {
                  return new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Center(
                        child: Text(
                          '지난 달보다 ${_getMonth(index, date)}월에\n⚡ ${(0 <= result) ? '+' + result.toInt().toString() : result.toInt().toString()}WH ⚡\n사용했어요!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        heightFactor: _screenSize.height * 0.003,
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
                          padding: EdgeInsets.all(6),
                          scrollDirection: Axis.vertical,
                          children: _contatos,
                        ),
                      ),
                    ],
                  );
                }),
          );
        },
      ),
    );
  }

  int _getMonth(int index, String date) {
    if (index == 0) {
      int month = int.parse(date.split("-")[1]);
      if (month == 12) {}
      return month;
    } else if (index > 0) {
      int month = int.parse(date.split("-")[1]) + index;
      return month;
    } else {
      if (index == 0) {
        int month = int.parse(date.split("-")[1]) - index;
        return month;
      }
    }
  }
}
