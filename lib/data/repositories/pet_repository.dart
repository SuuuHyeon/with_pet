import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:withpet/data/models/pet_model.dart';
import 'package:withpet/data/repositories/auth_repository.dart';

class PetRepository {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _firebaseStorage;

  PetRepository(this._firestore, this._firebaseStorage);

  /// 펫 정보 조회
  Future<List<Pet>> getUserPets(String userUid) async {
    final pets =
        await _firestore
            .collection('pets')
            .where('ownerUid', isEqualTo: userUid)
            .get();
    return pets.docs.map((doc) => Pet.fromFirestore(doc)).toList();
  }

  Future<void> addPet(Pet pet, XFile file) async {
    try {
      final petImageUrl = await _uploadPetImage(pet.ownerUid, file);

      await _firestore.runTransaction((transaction) async {
        final petDocRef = _firestore.collection('pets').doc();

        // pet 모델 생성
        final petData =
            Pet(
              ownerUid: pet.ownerUid,
              name: pet.name,
              breed: pet.breed,
              imageUrl: petImageUrl,
              birthDate: pet.birthDate,
              gender: pet.gender,
              isNeutered: pet.isNeutered,
              notes: pet.notes,
            ).toJson();

        transaction.set(petDocRef, petData);

        final userDocRef = _firestore.collection('users').doc(pet.ownerUid);

        transaction.update(userDocRef, {
          'petUidList': FieldValue.arrayUnion([petDocRef.id]),
        });
      });
    } catch (e) {
      print('Failed to add pet: $e');
      throw Exception('반려동물 등록에 실패했습니다.');
    }
  }

  /// 펫 이미지 업로드
  Future<String> _uploadPetImage(String userUid, XFile file) async {
    try {
      final ref = _firebaseStorage
          .ref('pet_images')
          .child(userUid)
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
      final upload = await ref.putFile(File(file.path));
      print('image URL: ${upload.ref.getDownloadURL()}');
      return upload.ref.getDownloadURL();
    } catch (e) {
      print('펫 이미지 저장 실패: $e');
      throw Exception('이미지 업로드에 실패하였습니다.');
    }
  }
}

/// firebase storage 프로바이더
final firebaseStorageProvider = Provider<FirebaseStorage>(
  (ref) => FirebaseStorage.instance,
);

/// pet repository 프로바이더
final petRepositoryProvider = Provider<PetRepository>(
  (ref) => PetRepository(
    ref.watch(firestoreProvider),
    ref.watch(firebaseStorageProvider),
  ),
);

/// 펫리스트제공 프로바이더
final petListProvider = FutureProvider.autoDispose<List<Pet>>((ref) {
  final userProfile = ref.watch(userProfileProvider).value;
  if (userProfile == null) {
    return [];
  }
  final petRepository = ref.watch(petRepositoryProvider);
  return petRepository.getUserPets(userProfile.uid);
});
