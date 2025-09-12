import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/auth_repository.dart';

// 로그인 화면의 상태만 책임지는 ViewModel
class LoginViewModel extends AsyncNotifier<void> {
  late final AuthRepository _authRepository;

  @override
  FutureOr<void> build() {
    _authRepository = ref.read(authRepositoryProvider);
  }

  Future<void> logIn({required String email, required String password}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => _authRepository.logIn(email: email, password: password),
    );
  }
}

// 로그인 ViewModel을 제공하는 Provider
final loginViewModelProvider = AsyncNotifierProvider<LoginViewModel, void>(
  () => LoginViewModel(),
);
