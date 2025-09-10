import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:withpet/core/theme/colors.dart';
import 'package:withpet/presentation/screens/tabs/posting/tab_posting.dart';
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
      const PostingTab(), // 커뮤니티 탭
      const MyPageTab(), // 마이페이지 탭
    ];

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      // IndexedStack을 사용하여 탭 전환 시 각 화면의 상태를 유지합니다.
      body: IndexedStack(index: selectedIndex, children: screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          // 위쪽에만 1px 두께의 얇은 회색 선을 추가합니다.
          border: Border(
            top: BorderSide(color: Colors.grey.shade300, width: 1.0),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: AppColors.appBackground,
          // elevation: 0을 추가하여 BottomNavigationBar 자체의 그림자를 제거해야
          // 우리가 추가한 경계선이 더 깔끔하게 보입니다.
          elevation: 0,
          currentIndex: selectedIndex,
          onTap: (index) {
            ref.read(mainScreenBottomNavProvider.notifier).state = index;
          },
          selectedItemColor: AppColors.primary,
          selectedIconTheme: const IconThemeData(size: 23),
          selectedLabelStyle: const TextStyle(fontSize: 13),
          unselectedItemColor: Colors.grey,
          unselectedIconTheme: const IconThemeData(size: 20),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline),
              activeIcon: Icon(Icons.chat_bubble),
              label: '포스팅',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: '마이페이지',
            ),
          ],
        ),
      ),
    );
  }
}
