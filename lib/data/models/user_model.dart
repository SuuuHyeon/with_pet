import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String nickname;
  final Timestamp createdAt;
  final List<String>? petUidList;

  UserModel({
    required this.uid,
    required this.email,
    required this.nickname,
    required this.createdAt,
    required this.petUidList,
  });

  // firestore에 저장할 때 사용할 toJson 메서드 생성
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'nickname': nickname,
      'createdAt': createdAt,
      'petUid': petUidList,
    };
  }

  // firestore에서 읽어올 때 변환하는 fromJson factory 생성자
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      email: json['email'],
      nickname: json['nickname'],
      createdAt: json['createdAt'],
      petUidList: List<String>.from(json['petUidList'] ?? []),
    );
  }
}
