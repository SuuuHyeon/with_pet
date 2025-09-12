import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/auth_repository.dart';

// 회원가입 화면의 상태만 책임지는 ViewModel
class SignUpViewModel extends AsyncNotifier<void> {
  late AuthRepository _authRepository = ref.read(authRepositoryProvider);

  @override
  FutureOr<void> build() {
    _authRepository = ref.read(authRepositoryProvider);
  }

  Future<void> signUp({required String email, required String password}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => _authRepository.signUp(email: email, password: password),
    );
  }
}

// 회원가입 ViewModel을 제공하는 Provider
final signupViewModelProvider = AsyncNotifierProvider<SignUpViewModel, void>(
  () => SignUpViewModel(),
);
