import 'package:flutter/material.dart';

const firstmainColor = Color(0xFFE7F3EB);
const secondmainColor = Color(0xFFF8F5E1);
const regularColor = Colors.transparent;

const kSmallesTextStyle = TextStyle(
  fontSize: 12,
  color: Colors.black54,
);

const kSmallTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

const kMidTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

const kRegularTextStyle = TextStyle(
  fontSize: 23,
  fontWeight: FontWeight.bold,
);

const kBigTextStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
);

const kBigestTextStyle = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.bold,
);

BoxDecoration kDropDownDecoration = BoxDecoration(
  border: Border.all(color: Colors.white),
  borderRadius: BorderRadius.circular(50),
);

BoxDecoration kBoxDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(25),
  boxShadow: [
    BoxShadow(
      color: Colors.grey,
      offset: Offset(2.0, 4.0),
      blurRadius: 5.0,
    ),
  ],
);

OutlineInputBorder kFocusDecoration = OutlineInputBorder(
  borderRadius: BorderRadius.circular(50),
  borderSide: BorderSide(
    color: Colors.white,
    width: 2.0,
  ),
);

OutlineInputBorder kEnableDecoration = OutlineInputBorder(
  borderRadius: BorderRadius.circular(50),
  borderSide: BorderSide(
    color: Colors.white,
  ),
);

const kReverseDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: [firstmainColor, secondmainColor],
    begin: Alignment.topLeft, //컬러 시작점
    end: Alignment.bottomRight, //컬러 끝나는점
  ),
);

const kWelcomeDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: [firstmainColor, secondmainColor],
    begin: Alignment.topLeft, //컬러 시작점
    end: Alignment.bottomRight, //컬러 끝나는점
  ),
  boxShadow: [
    BoxShadow(
      color: const Color(0x4d000000),
      offset: Offset(0, 3),
      blurRadius: 6,
    ),
  ],
);

const kMainDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: [Color(0xFF5FCCCB), Color(0xFFF3DD6E)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
);

const kRegularDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: [firstmainColor, secondmainColor],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
);

List devices = [
  "냉장고",
  "김치냉장고",
  "일반세탁기",
  "드럼세탁기",
  "정수기",
  "전기밥솥",
  "청소기",
  "선풍기",
  "공기청정기",
  "형광등",
  "보일러",
  "충전기",
  "에어컨",
  "온풍기",
  "TV",
  "전기온풍기",
  "전기스토브",
  "제습기",
  "전기레인지",
  "셋톱박스",
  "LED램프",
  "의류건조기",
  "컴퓨터",
  "모니터",
  "프린터",
  "전자레인지",
  "도어폰",
  "비데",
  "공유기"
];

List locations = [
  "서울특별시",
  "부산광역시",
  "인천광역시",
  "울산광역시",
  "대전광역시",
  "대구광역시",
  "광주광역시",
  "세종특별자치시",
  "제주특별자치도",
  "강원도",
  "경기도",
  "경상남도",
  "경상북도",
  "전라남도",
  "전라북도",
  "충청남도",
  "충청북도",
];

List contractions = [
  "저압 요금",
  "고압 요금",
];
