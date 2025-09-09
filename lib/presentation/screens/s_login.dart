import 'package:flutter/material.dart';

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
    // Scaffold의 body에 CustomScrollView를 사용하여 더 유연한 스크롤을 구현합니다.
    return Scaffold(
      // backgroundColor는 Theme에서 관리하는 것이 더 좋습니다.
      // 여기서는 예시를 위해 남겨둡니다.
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        // slivers는 CustomScrollView의 자식들을 담는 리스트입니다.
        slivers: [
          // SliverFillRemaining은 화면의 남은 공간을 채우는 특별한 Sliver입니다.
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
                    // 1. 앱 로고 표시
                    Image.asset(
                      'assets/app/app_logo.png',
                      height: 250,
                    ),

                    // 2. 이메일 입력 필드
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        hintText: '이메일 주소',
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),

                    // 3. 비밀번호 입력 필드
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline),
                        hintText: '비밀번호',
                      ),
                    ),
                    const SizedBox(height: 32),

                    // 4. 로그인 버튼
                    ElevatedButton(
                      onPressed: () {
                        final email = _emailController.text;
                        final password = _passwordController.text;
                        print('Email: $email, Password: $password');
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
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            '회원가입',
                            style: TextStyle(
                              color: Color(0xFFF27507),
                            ),
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
