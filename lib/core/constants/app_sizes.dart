import 'package:flutter/material.dart';


// 화면 크기 및 여백 관련 extension
extension ContextExtension on BuildContext {

  double get deviceWidth => MediaQuery.of(this).size.width;
  double get deviceHeight => MediaQuery.of(this).size.height;

  double get statusBarHeight => MediaQuery.of(this).padding.top;
  double get bottomBarHeight => MediaQuery.of(this).padding.bottom;

  double width(double width) => deviceWidth * width;
  double height(double height) => deviceHeight * height;

  TargetPlatform get platform => Theme.of(this).platform;
}