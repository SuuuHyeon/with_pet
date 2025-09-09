import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: Color(0xFFFFF2ED),
  textTheme: TextTheme(
    titleLarge: TextStyle(color: Color(0xff28222B)),
    titleMedium: TextStyle(color: Color(0xff28222B).withValues(alpha: 0.8)),
    titleSmall: TextStyle(color: Color(0xff28222B).withValues(alpha: 0.6)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFF17D2A),
      // 버튼 배경색
      foregroundColor: Colors.white,
      // 버튼 글자색
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  ),

  // TextField, TextFormField 등 입력 필드의 기본 스타일 설정
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide.none,
    ),
    // border: OutlineInputBorder(
    //   borderRadius: BorderRadius.circular(12.0),
    //   borderSide: BorderSide(color: Color(0xFFFF0000), width: 2.0),
    // ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: Color(0xFFF27507), width: 2.0),
    ),
  ),
);

ThemeData darkMode = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: Color(0xff1C1B1F),
  textTheme: TextTheme(
    titleLarge: TextStyle(color: Color(0xff28222B)),
    titleMedium: TextStyle(color: Color(0xff28222B).withValues(alpha: 0.8)),
    titleSmall: TextStyle(color: Color(0xff28222B).withValues(alpha: 0.6)),
  ),
);
