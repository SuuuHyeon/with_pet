
// 홈 화면의 상태를 나타내는 클래스
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:withpet/data/models/dto_schedule.dart';

import '../../data/models/pet_model.dart';

class HomeState {
  final Pet pet;
  // TODO: 나중에 실제 일정 모델로 교체
  final List<Schedule> schedules;

  HomeState({required this.pet, required this.schedules});
}

// 홈 화면의 상태를 관리하는 Notifier
class HomeViewModel extends StateNotifier<AsyncValue<HomeState>> {
  HomeViewModel() : super(const AsyncValue.loading()) {
    // _fetchHomeData();
  }


  // // 홈 화면에 필요한 데이터를 가져오는 메서드
  // Future<void> _fetchHomeData() async {
  //   try {
  //     // 실제 앱에서는 여기서 Firebase 등에서 데이터를 불러옵니다.
  //     // 지금은 더미 데이터로 대체합니다.
  //     await Future.delayed(const Duration(seconds: 1)); // 가상 로딩
  //
  //     final dummyPet = Pet(
  //       name: '초코',
  //       imageUrl: 'https://mblogthumb-phinf.pstatic.net/MjAyMjAyMDdfMjEy/MDAxNjQ0MTk0Mzk2MzY3.WAeeVCu2V3vqEz_98aWMOjK2RUKI_yHYbuZxrokf-0Ug.sV3LNWlROCJTkeS14PMu2UBl5zTkwK70aKX8B1w2oKQg.JPEG.41minit/1643900851960.jpg?type=w800',
  //       birthDate: DateTime(2022, 5, 10),
  //       adoptedDate: DateTime(2022, 8, 1),
  //     );
  //
  //     // 더미 데이터를 Schedule 모델을 사용하도록 변경
  //     final dummySchedules = [
  //       Schedule(id: '1', title: '9월 15일: 심장사상충 약 먹는 날'),
  //       Schedule(id: '2', title: '9월 22일: 전체 미용 예약', isCompleted: true),
  //       Schedule(id: '3', title: '10월 5일: 정기 검진일'),
  //     ];
  //
  //     // 👈 추가: 초기 정렬 로직
  //     dummySchedules.sort((a, b) => a.isCompleted ? 1 : -1);
  //
  //     state = AsyncValue.data(HomeState(pet: dummyPet, schedules: dummySchedules));
  //   } catch (e, stack) {
  //     state = AsyncValue.error(e, stack);
  //   }
  // }

  // 👈 추가: 스케줄 완료 상태를 토글하는 메서드
  void toggleScheduleCompletion(String scheduleId) {
    // 현재 상태가 데이터일 때만 로직 실행
    state.whenData((currentState) {
      // 상태 업데이트
      final updatedSchedules = currentState.schedules.map((s) {
        if (s.id == scheduleId) {
          s.isCompleted = !s.isCompleted;
        }
        return s;
      }).toList();

      // 정렬: 미완료 항목이 위로, 완료 항목이 아래로
      updatedSchedules.sort((a, b) => a.isCompleted ? 1 : -1);

      // 새로운 상태로 UI 업데이트
      state = AsyncValue.data(
        HomeState(pet: currentState.pet, schedules: updatedSchedules),
      );
    });
  }
}

// ViewModel을 앱 전역에서 사용할 수 있도록 Provider를 생성합니다.
final homeViewModelProvider = StateNotifierProvider<HomeViewModel, AsyncValue<HomeState>>(
      (ref) => HomeViewModel(),
);
