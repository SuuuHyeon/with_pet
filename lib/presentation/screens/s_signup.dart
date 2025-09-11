import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:withpet/core/theme/colors.dart';
import 'package:withpet/presentation/viewmodels/auth_view_model.dart';
import 'package:withpet/presentation/viewmodels/home_view_model.dart';
import 'package:withpet/presentation/widgets/w_custom_dialog.dart';

// 회원가입 페이지 UI를 구성하는 StatefulWidget입니다.
class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
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
    ref.listen(authViewModelProvider, (previous, next) {
      if (previous is AsyncLoading && next.hasError) {
        showCustomDialog(
          context,
          type: DialogType.error,
          title: '회원가입 실패',
          content: '회원가입에 실패하였습니다. 다시 시도해주세요!',
          onConfirm: () => context.pop(),
        );
      }
      if (previous is AsyncLoading && !next.hasError) {
        showCustomDialog(
          context,
          type: DialogType.success,
          title: '회원가입 완료',
          content: '위드펫에 오신 것을 환영합니다!',
          onConfirm: () {
            context.pop(); // 다이얼로그 닫기
            context.go('/login'); // 로그인 페이지로 이동
          },
        );
      }
    });

    final authState = ref.watch(authViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // 맨 아래층: 기존 UI
          CustomScrollView(
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
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email_outlined),
                            hintText: '이메일 주소',
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _nicknameController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person_outline),
                            hintText: '닉네임',
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.lock_outline),
                            hintText: '비밀번호',
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.lock_person_outlined),
                            hintText: '비밀번호 확인',
                          ),
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed:
                              authState.isLoading
                                  ? null
                                  : () {
                                    ref
                                        .read(authViewModelProvider.notifier)
                                        .signUp(
                                          email: _emailController.text.trim(),
                                          password:
                                              _passwordController.text.trim(),
                                        );
                                  },
                          child: const Text('가입하기'),
                        ),
                        const SizedBox(height: 24),
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
                                context.go('/login');
                              },
                              child: Text(
                                '로그인',
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
          if (authState.isLoading)
            Container(
              color: Colors.black.withValues(alpha: 0.5),
              child: const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            ),
        ],
      ),
    );
  }
}
