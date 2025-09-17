enum AuthErrorCode {
  invalidCredential, // 잘못된 정보 입력
  userNotFound, // 이메일이 존재하지 않음
  wrongPassword, // 비밀번호가 틀림
  invalidEmail, // 이메일 형식이 잘못됨
  emailAlreadyInUse, // 이메일이 이미 사용 중임
  unknown, // 알 수 없는 오류
}

class AuthErrorException implements Exception {
  final AuthErrorCode code;
  final String message;

  AuthErrorException(this.code, this.message);

  factory AuthErrorException.fromCode(String code) {
    switch (code) {
      case 'invalid-credential':
        return AuthErrorException(
          AuthErrorCode.invalidCredential,
          '이메일 또는 비밀번호가 올바르지 않습니다.',
        );
      case 'user-not-found':
        return AuthErrorException(
          AuthErrorCode.userNotFound,
          '가입되지 않은 이메일입니다.',
        );
      case 'invalid-email':
        return AuthErrorException(
          AuthErrorCode.invalidEmail,
          '유효하지 않은 이메일 형식입니다.',
        );
      case 'email-already-in-use':
        return AuthErrorException(
          AuthErrorCode.emailAlreadyInUse,
          '이미 사용 중인 이메일입니다.',
        );
      default:
        return AuthErrorException(
          AuthErrorCode.unknown,
          '알 수 없는 오류가 발생했습니다. 잠시 후 다시 시도해주세요.',
        );
    }
  }

  @override
  String toString() => message;
}
