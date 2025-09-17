import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:withpet/data/models/user_model.dart';
import 'package:withpet/data/repositories/error_exceptions/login_error_exception.dart';
import 'package:withpet/data/repositories/user_repository.dart';

// 인증 로직을 담고 있는 Repository 클래스
class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final UserRepository _userRepository;

  AuthRepository(this._firebaseAuth, this._userRepository);

  // 현재 로그인된 사용자 정보를 가져오는 getter
  User? get currentUser => _firebaseAuth.currentUser;

  // 인증 상태 변화를 실시간으로 감지하는 Stream
  Stream<User?> authStateChanges() {
    return _firebaseAuth.authStateChanges();
  }

  // 이메일/비밀번호로 회원가입
  Future<void> signUp({
    required String email,
    required String password,
    required String nickname,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential != null) {
        final newUser = UserModel(
          uid: userCredential.user!.uid,
          email: email,
          nickname: nickname,
          createdAt: Timestamp.now(),
          petUidList: [],
        );
        await _userRepository.saveUser(newUser);
      }
    } on FirebaseAuthException catch (e) {
      throw Exception('회원가입에 실패했습니다: ${e.message}');
    }
  }

  // 이메일/비밀번호로 로그인
  Future<void> logIn({required String email, required String password}) async {
    try {
      print('[auth_repository] 로그인, 이메일:$email');
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      // firebase 에러 코드를 던짐
      throw AuthErrorException.fromCode(e.code);
    }
  }

  // 로그아웃
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }
}

// ------------------- Riverpod Providers ------------------- //

// firebase 관련 provider
final firebaseAuthProvider = Provider<FirebaseAuth>(
  (ref) => FirebaseAuth.instance,
);
final firestoreProvider = Provider<FirebaseFirestore>(
  (ref) => FirebaseFirestore.instance,
);

// AuthRepository를 앱 전역에서 사용할 수 있도록 Provider를 생성합니다.
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final firebaseAuthProviderInstance = ref.watch(firebaseAuthProvider);
  final userRepositoryProviderInstance = ref.watch(userRepositoryProvider);
  return AuthRepository(
    firebaseAuthProviderInstance,
    userRepositoryProviderInstance,
  );
});

// 인증 상태 변화 Stream을 제공하는 Provider
// 이 Provider를 watch하면 로그인/로그아웃 상태가 바뀔 때마다 UI가 자동으로 업데이트됩니다.
final authStateChangesProvider = StreamProvider<User?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
});

// 유저프로필정보 가져옴
final userProfileProvider = FutureProvider<UserModel?>((ref) async {
  final user = ref.watch(authStateChangesProvider).asData?.value;
  if (user == null) {
    return null;
  }
  final userRepository = ref.watch(userRepositoryProvider);
  final userInfo = await userRepository.getUserInfo(user.uid);
  print('userInfo: ${userInfo?.toJson()}');
  return userInfo;
});
