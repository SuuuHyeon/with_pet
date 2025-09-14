import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:withpet/data/models/user_model.dart';
import 'package:withpet/data/repositories/auth_repository.dart';

class UserRepository {
  final FirebaseFirestore _firestore;

  UserRepository(this._firestore);

  // firestore에 유저정보 저장
  Future<void> saveUser(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.uid).set(user.toJson());
    } catch (e) {
      print('유저 정보 firestore 저장 실패: ${e.toString()}');
    }
  }

  Future<UserModel?> getUserInfo(String uid) async {
    try {
      final user = await _firestore.collection('users').doc(uid).get();
      if(user.exists && user.data() != null) {
        return UserModel.fromJson(user.data()!);
      }
      return null;
    } catch(e) {
      print('[auth_repository] 유저정보 찾기 실패: $e');
    }
    return null;
  }
}

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final firestoreProviderInstance = ref.watch(firestoreProvider);
  return UserRepository(firestoreProviderInstance);
});
