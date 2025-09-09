import 'package:flutter/material.dart';
import 'package:withpet/core/theme/app_theme.dart';
import 'presentation/screens/s_login.dart';

// 앱의 시작점입니다.
void main() {
  runApp(const WithPetApp());
}

// 앱의 최상위 위젯으로, 전체적인 테마와 시작 화면을 설정합니다.
class WithPetApp extends StatelessWidget {
  const WithPetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 디버그 배너를 숨깁니다.
      debugShowCheckedModeBanner: false,
      title: 'withPet',
      home: const LoginScreen(),
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}

