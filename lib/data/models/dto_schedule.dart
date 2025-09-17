// lib/data/models/schedule_model.dart

class Schedule {
  final String id;
  final String title;
  bool isCompleted; // 상태 변경이 가능해야 하므로 final이 아님

  Schedule({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });
}