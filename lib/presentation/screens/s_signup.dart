import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:withpet/core/theme/colors.dart';

// 회원가입 페이지 UI를 구성하는 StatefulWidget입니다.
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // 텍스트 필드 제어를 위한 컨트롤러
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nicknameController = TextEditingController();

  @override
  void dispose() {
    // 위젯이 화면에서 사라질 때 컨트롤러를 정리하여 메모리 누수를 방지합니다.
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. AppBar 추가: 현재 페이지의 제목을 표시하고 자동으로 뒤로가기 버튼을 생성합니다.
      appBar: AppBar(
        title: const Text('회원가입'),
        // 배경색을 투명하게 하여 body와 자연스럽게 연결합니다.
        backgroundColor: Colors.transparent,
        // AppBar 아래의 그림자를 제거합니다.
        elevation: 0,
      ),
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 2. 환영 메시지
                    const Text(
                      '위드펫에 오신 것을 환영해요!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '사용하실 정보를 입력해주세요.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 48),

                    // 3. 이메일 입력 필드
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        hintText: '이메일 주소',
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),

                    // 4. 닉네임 입력 필드
                    TextFormField(
                      controller: _nicknameController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person_outline),
                        hintText: '닉네임',
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 5. 비밀번호 입력 필드
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline),
                        hintText: '비밀번호',
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 6. 비밀번호 확인 입력 필드
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock_person_outlined),
                        hintText: '비밀번호 확인',
                      ),
                    ),
                    const SizedBox(height: 32),

                    // 7. 회원가입 버튼
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Firebase 회원가입 연동
                        final email = _emailController.text;
                        final nickname = _nicknameController.text;
                        final password = _passwordController.text;
                        print(
                          'Email: $email, Nickname: $nickname, Password: $password',
                        );
                      },
                      child: const Text('가입하기'),
                    ),
                    const SizedBox(height: 24),

                    // 8. 로그인 페이지로 돌아가는 링크
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          '이미 계정이 있으신가요?',
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            // 로그인 페이지로 이동
                            // push 대신 go를 사용하여 이전 기록을 없애고 이동합니다.
                            context.go('/login');
                          },
                          child: Text(
                            '로그인',
                            style: TextStyle(
                              color: AppColors.primary,
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
