import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/pet_model.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/pet_repository.dart';

/// 반려동물 등록 화면의 상태와 비즈니스 로직을 관리하는 ViewModel입니다.
class PetRegistrationViewModel extends AutoDisposeAsyncNotifier<void> {
  late final PetRepository _petRepository;
  late final String _userUid;

  /// ViewModel이 처음 생성될 때 호출되어 필요한 의존성을 초기화합니다.
  @override
  FutureOr<void> build() {
    // 다른 Provider들로부터 PetRepository와 현재 사용자의 uid를 가져옵니다.
    _petRepository = ref.watch(petRepositoryProvider);
    _userUid = ref.watch(userProfileProvider).value!.uid;
  }


  /// 펫 등록 메서드
  Future<void> addPet({required Pet petData, required XFile imageFile}) async {
    // 1. 상태를 '로딩 중'으로 변경하여 UI에 로딩 오버레이를 표시하도록 합니다.
    state = const AsyncValue.loading();

    // 2. UI에서 받은 Pet 객체에 현재 사용자의 uid를 채워줍니다.
    final completePetData = Pet(
      ownerUid: _userUid,
      name: petData.name,
      breed: petData.breed,
      // Repository에서 생성하므로 비워둠
      imageUrl: '',
      birthDate: petData.birthDate,
      gender: petData.gender,
      isNeutered: petData.isNeutered,
      adoptedDate: petData.adoptedDate,
      notes: petData.notes,
    );

    // 3. AsyncValue.guard를 사용하여 Repository의 addPet 메소드를 안전하게 호출합니다.
    //    성공하면 state는 AsyncData가 되고, 실패하면 AsyncError가 됩니다.
    state = await AsyncValue.guard(
      () => _petRepository.addPet(completePetData, imageFile),
    );
  }

  /// 이미지 선택 메서드
  Future<XFile?> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    return pickedFile;
  }


}

/// 펫 등록 뷰모델 프로바이더
/// .autoDispose를 사용하여, 반려동물 등록 화면이 사라지면
/// 이 ViewModel의 상태도 함께 메모리에서 제거됩니다.
final petRegistrationViewModelProvider =
    AsyncNotifierProvider.autoDispose<PetRegistrationViewModel, void>(
      () => PetRegistrationViewModel(),
    );
