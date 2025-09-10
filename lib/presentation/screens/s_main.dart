import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:withpet/core/theme/colors.dart';
import 'package:withpet/presentation/screens/tabs/tab_community.dart';
import 'package:withpet/presentation/screens/tabs/tab_my_page.dart';
import 'package:withpet/presentation/viewmodels/main_view_model.dart';

// Riverpod을 사용하기 위해 StatelessWidget 대신 ConsumerWidget을 상속받습니다.
class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // mainScreenBottomNavProvider를 watch하여 현재 선택된 탭의 인덱스를 가져옵니다.
    final selectedIndex = ref.watch(mainScreenBottomNavProvider);

    // 각 탭에 해당하는 화면 위젯 리스트
    final List<Widget> screens = [
      const CommunityTab(), // 커뮤니티 탭
      const MyPageTab(), // 마이페이지 탭
    ];

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      // IndexedStack을 사용하여 탭 전환 시 각 화면의 상태를 유지합니다.
      body: IndexedStack(index: selectedIndex, children: screens),
      bottomNavigationBar: BottomNavigationBar(
        // 현재 선택된 탭 인덱스
        currentIndex: selectedIndex,
        // 탭을 눌렀을 때 Provider의 상태를 변경하여 화면을 전환합니다.
        onTap: (index) {
          ref.read(mainScreenBottomNavProvider.notifier).state = index;
          print('Selected tab index: $index');
        },
        // 활성화된 탭의 색상
        selectedItemColor: Theme.of(context).colorScheme.primary,
        // 비활성화된 탭의 색상
        unselectedItemColor: Colors.grey,
        // 탭 아이템들
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            activeIcon: Icon(Icons.chat_bubble),
            label: '커뮤니티',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: '마이페이지',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.person_outline),
          //   activeIcon: Icon(Icons.person),
          //   label: '내 정보',
          // ),
        ],
      ),
    );
  }
}
