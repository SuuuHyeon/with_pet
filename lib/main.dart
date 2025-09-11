import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:withpet/core/router/router.dart';
import 'package:withpet/core/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// 앱의 시작점입니다.
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: const WithPetApp()));
}

// 앱의 최상위 위젯으로, 전체적인 테마와 시작 화면을 설정합니다.
class WithPetApp extends StatelessWidget {
  const WithPetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      // home: const LoginScreen(),
      title: 'withPet',
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}
