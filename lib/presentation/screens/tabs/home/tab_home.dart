import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:withpet/presentation/screens/tabs/home/w_pet_profile.dart';
import 'package:withpet/presentation/screens/tabs/home/widgets/w_upcoming_schedule.dart';

import '../../../../core/theme/colors.dart';
import '../../../viewmodels/home_view_model.dart';

class HomeTab extends ConsumerWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeStateAsync = ref.watch(homeViewModelProvider);

    return Scaffold(
      body: homeStateAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('데이터를 불러올 수 없습니다: $err')),
        data: (homeState) {
          final pet = homeState.pet;
          return SingleChildScrollView(
            // padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. 반려동물 프로필 카드
                PetProfileCard(
                  imageUrl: pet.imageUrl,
                  name: pet.name,
                  age: pet.age,
                  daysTogether: pet.daysTogether, breed: '',
                ),
                const SizedBox(height: 24),
                HealthSummary(),
                // 2. 다가오는 일정
                UpcomingScheduleCard(schedules: homeState.schedules),
              ],
            ),
          );
        },
      ),
    );
  }
}



