class Pet {
  final String name;
  final String imageUrl;
  final DateTime birthDate;
  final DateTime adoptedDate;

  Pet({
    required this.name,
    required this.imageUrl,
    required this.birthDate,
    required this.adoptedDate,
  });

  // 만나이 계산
  int get age {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  // 함께한 날짜 계산
  int get daysTogether {
    return DateTime.now().difference(adoptedDate).inDays;
  }
}
