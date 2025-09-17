import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:withpet/core/router/router.dart';
import 'package:withpet/core/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// 앱의 시작점입니다.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 1. kDebugMode를 사용하여 개발 모드일 때만 이 코드가 실행되도록 합니다.
  if (kDebugMode) {
    try {
      // 2. Firebase Auth에 미리 만들어둔 테스트 계정 정보
      const testEmail = 'tngutnqls6909@gmail.com4';
      const testPassword = 'suhyeon12!';

      // 3. 기존에 로그인된 계정이 있다면 로그아웃하여 깨끗한 상태를 보장합니다.
      await FirebaseAuth.instance.signOut();

      // 4. 테스트 계정으로 자동 로그인합니다.
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: testEmail,
        password: testPassword,
      );
      print('✅ Logged in with test account in debug mode.');
    } catch (e) {
      print('⚠️ Failed to auto-login with test account: $e');
      // 테스트 계정이 없거나 비밀번호가 틀리면 여기에 에러가 출력됩니다.
    }
  }
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
