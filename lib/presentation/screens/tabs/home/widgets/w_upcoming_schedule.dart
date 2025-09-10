import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:withpet/data/models/dto_schedule.dart';
import 'package:withpet/presentation/viewmodels/home_view_model.dart';

import '../../../../../core/theme/colors.dart';

// 다가오는 일정 카드 위젯
class UpcomingScheduleCard extends ConsumerWidget {
  final List<Schedule> schedules;

  const UpcomingScheduleCard({required this.schedules, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '잊지마세요! 🗓️',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children:
                  schedules
                      .map(
                        (schedule) => CheckboxListTile(
                          value: schedule.isCompleted,
                          onChanged: (value) {
                            // 일정 완료 상태 변경 로직 (예: ViewModel 호출)
                            ref
                                .read(homeViewModelProvider.notifier)
                                .toggleScheduleCompletion(schedule.id);
                          },
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            schedule.title,
                            style: TextStyle(
                              fontSize: 14,
                              // 완료 시 취소선 및 회색 처리
                              decoration:
                                  schedule.isCompleted
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                              color:
                                  schedule.isCompleted
                                      ? Colors.grey
                                      : Colors.black,
                            ),
                          ),
                          // 체크박스를 왼쪽에 배치
                          controlAffinity: ListTileControlAffinity.leading,
                          // 활성화 시 아이콘 색상
                          activeColor: AppColors.secondary,
                        ),
                      )
                      .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
