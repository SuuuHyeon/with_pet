import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:withpet/core/theme/colors.dart';
import 'package:withpet/presentation/viewmodels/login_view_model.dart';
import 'package:withpet/presentation/viewmodels/signup_view_model.dart';
import 'package:withpet/presentation/widgets/w_custom_dialog.dart';
import 'package:withpet/presentation/widgets/w_loading_overlay.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
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
    ref.listen<AsyncValue<void>>(loginViewModelProvider, (previous, next) {
      if (previous is AsyncLoading) {
        if (next.hasError) {
          showCustomDialog(
            context,
            type: DialogType.error,
            title: '로그인 실패',
            content: next.error.toString(),
            onConfirm: () => context.pop(),
          );
        } else {
          context.go('/home');
        }
      }
    });

    final authState = ref.watch(loginViewModelProvider);

    return LoadingOverlay(
      isLoading: authState.isLoading,
      child: Scaffold(
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
                      Image.asset('assets/logo/app_logo.png', height: 250),
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
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline),
                          hintText: '비밀번호',
                        ),
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () {
                          print('로그인 버튼 클릭됨');
                          ref
                              .read(loginViewModelProvider.notifier)
                              .logIn(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              );
                        },
                        child: const Text('로그인'),
                      ),
                      const SizedBox(height: 24),
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
      ),
    );
  }
}
