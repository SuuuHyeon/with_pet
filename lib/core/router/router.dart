import 'package:go_router/go_router.dart';
import 'package:withpet/presentation/screens/s_login.dart';
import 'package:withpet/presentation/screens/s_main.dart';
import 'package:withpet/presentation/screens/s_signup.dart';


final GoRouter router = GoRouter(
  initialLocation: '/login',
  routes: <RouteBase>[
    GoRoute(
      path: '/login', // URL 경로
      name: 'login',   // 라우트 이름 (나중에 코드로 호출할 때 사용)
      builder: (context, state) {
        // 이 경로에 해당하는 화면 위젯 반환
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: '/signup',
      name: 'signup',
      builder: (context, state) {
        return const SignUpScreen();
      },
    ),
    GoRoute(
      path: '/main',
      name: 'main',
      builder: (context, state) {
        return const MainScreen();
      },
    ),
  ],
);