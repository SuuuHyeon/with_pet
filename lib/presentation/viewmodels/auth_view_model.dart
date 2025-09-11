import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:withpet/data/repositories/auth_repository.dart';

class AuthViewModel extends AsyncNotifier {
  late final AuthRepository _authRepository;

  @override
  FutureOr build() {
    _authRepository = ref.read(authRepositoryProvider);
  }

  /// 회원가입
  Future<void> signUp({required String email, required String password}) async {
    // 로딩 시작
    print('회원가입 로딩 시작');
    state = const AsyncValue.loading(); // AsyncLoading()과 같은 듯
    state = await AsyncValue.guard(
      () => _authRepository.signUp(email: email, password: password),
    );
  }

  /// 로그인
  Future<void> logIn({required String email, required String password}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => _authRepository.logIn(email: email, password: password),
    );
  }

  Future<void> logOut({required int userId}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _authRepository.logOut());
  }
}

final authViewModelProvider = AsyncNotifierProvider<AuthViewModel, void>(
  () => AuthViewModel(),
);
