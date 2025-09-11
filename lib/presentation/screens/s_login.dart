import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:withpet/core/theme/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            // hasScrollBody: false는 이 위젯의 자식이 스크롤의 주 내용이 아님을 의미합니다.
            // 이 설정을 통해 공간이 충분할 때 자식(Center)을 중앙에 배치할 수 있습니다.
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 앱 로고
                    Image.asset('assets/logo/app_logo.png', height: 250),

                    // 이메일 입력 필드
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        hintText: '이메일 주소',
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),

                    // 비밀번호 입력 필드
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline),
                        hintText: '비밀번호',
                      ),
                    ),
                    const SizedBox(height: 32),

                    // 로그인 버튼
                    ElevatedButton(
                      onPressed: () {
                        final email = _emailController.text;
                        final password = _passwordController.text;
                        print('Email: $email, Password: $password');
                        /// TODO: 로그인 기능 구현 및 go로 변환
                        context.push('/home');
                      },
                      child: const Text('로그인'),
                    ),
                    const SizedBox(height: 24),

                    // 5. 회원가입 페이지로 이동하는 링크
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          '아직 회원이 아니신가요?',
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            /// 회원가입 페이지 이동
                            context.push('/signup');
                          },
                          child: const Text(
                            '회원가입',
                            style: TextStyle(color: AppColors.primary),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
