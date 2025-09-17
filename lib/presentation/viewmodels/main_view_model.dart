import 'package:flutter_riverpod/flutter_riverpod.dart';

/// BottomNavigationBar의 현재 선택된 탭 인덱스를 관리하는 Provider
final mainScreenBottomNavProvider = StateProvider<int>((ref) {
  // 앱 시작 시 보여줄 기본 탭 인덱스 (0 = 정보 공유 탭)
  return 0;
});
