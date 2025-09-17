import 'package:cloud_firestore/cloud_firestore.dart';

// 반려동물의 성별을 나타내는 enum
enum PetGender { male, female }

/// Firestore에 저장될 반려동물의 정보 클래스
class Pet {
  final String? id;          // Firestore 문서 ID
  final String ownerUid;    // 소유자 User ID
  final String name;        // 반려동물 이름
  final String breed;       // 품종
  final String imageUrl;    // 프로필 사진 URL
  final DateTime birthDate; // 생년월일
  final PetGender gender;   // 성별
  final bool isNeutered;    // 중성화 여부
  final DateTime? adoptedDate; // 입양일 (선택)
  final String? notes;      // 특이사항 (선택)

  Pet({
    this.id,
    required this.ownerUid,
    required this.name,
    required this.breed,
    required this.imageUrl,
    required this.birthDate,
    required this.gender,
    required this.isNeutered,
    this.adoptedDate,
    this.notes,
  });

  /// Pet 객체를 Firestore에 저장하기 위한 Map으로 변환합니다.
  Map<String, dynamic> toJson() {
    return {
      'ownerUid': ownerUid,
      'name': name,
      'breed': breed,
      'imageUrl': imageUrl,
      'birthDate': Timestamp.fromDate(birthDate),
      'gender': gender.name,
      'isNeutered': isNeutered,
      'adoptedDate': adoptedDate != null ? Timestamp.fromDate(adoptedDate!) : null,
      'notes': notes,
    };
  }

  /// Firestore 문서로부터 Pet 객체를 생성합니다.
  factory Pet.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Pet(
      id: doc.id,
      ownerUid: data['ownerUid'],
      name: data['name'],
      breed: data['breed'],
      imageUrl: data['imageUrl'],
      birthDate: (data['birthDate'] as Timestamp).toDate(),
      gender: PetGender.values.firstWhere((e) => e.name == data['gender']),
      isNeutered: data['isNeutered'],
      adoptedDate: data['adoptedDate'] != null
          ? (data['adoptedDate'] as Timestamp).toDate()
          : null,
      notes: data['notes'],
    );
  }
}

