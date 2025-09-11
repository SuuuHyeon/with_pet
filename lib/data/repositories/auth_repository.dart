import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

// 인증 로직을 담고 있는 Repository 클래스
class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  AuthRepository(this._firebaseAuth);

  // 현재 로그인된 사용자 정보를 가져오는 getter
  User? get currentUser => _firebaseAuth.currentUser;

  // 인증 상태 변화를 실시간으로 감지하는 Stream
  Stream<User?> authStateChanges() {
    return _firebaseAuth.authStateChanges();
  }

  // 이메일/비밀번호로 회원가입
  Future<void> signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      // TODO: 에러 처리 로직 (예: SnackBar 표시)
      throw Exception('회원가입에 실패했습니다: ${e.message}');
    }
  }

  // 이메일/비밀번호로 로그인
  Future<void> logIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      // TODO: 에러 처리 로직
      throw Exception('로그인에 실패했습니다: ${e.message}');
    }
  }

  // 로그아웃
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }
}

// ------------------- Riverpod Providers ------------------- //

// AuthRepository를 앱 전역에서 사용할 수 있도록 Provider를 생성합니다.
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(FirebaseAuth.instance);
});

// 인증 상태 변화 Stream을 제공하는 Provider
// 이 Provider를 watch하면 로그인/로그아웃 상태가 바뀔 때마다 UI가 자동으로 업데이트됩니다.
final authStateChangesProvider = StreamProvider<User?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
});
