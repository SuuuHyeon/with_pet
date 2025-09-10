import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/colors.dart';

class MyPageTab extends ConsumerWidget {
  const MyPageTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(
        title: const Text('마이페이지'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            // 1. 사용자 프로필 요약 카드
            _buildUserProfileCard(
              context,
              name: '수현님', // TODO: 실제 사용자 데이터로 교체
              email: 'tngutnqls6909@gmail.com', // TODO: 실제 사용자 데이터로 교체
            ),
            const SizedBox(height: 24.0),

            // 2. 메뉴 섹션
            _buildMenuSection(
              context,
              title: '반려동물',
              children: [
                _MenuTile(
                  icon: Icons.pets_outlined,
                  title: '내 반려동물 관리',
                  onTap: () {
                    // TODO: 반려동물 관리 페이지로 이동
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            _buildMenuSection(
              context,
              title: '계정 관리',
              children: [
                _MenuTile(
                  icon: Icons.logout,
                  title: '로그아웃',
                  onTap: () {
                    _showConfirmationDialog(
                      context,
                      title: '로그아웃',
                      content: '정말 로그아웃 하시겠어요?',
                      onConfirm: () {
                        // TODO: 로그아웃 로직 구현
                        Navigator.of(context).pop(); // 다이얼로그 닫기
                      },
                    );
                  },
                ),
                _MenuTile(
                  icon: Icons.person_remove_outlined,
                  title: '회원탈퇴',
                  textColor: Colors.red,
                  onTap: () {
                    _showConfirmationDialog(
                      context,
                      title: '회원탈퇴',
                      content: '모든 정보가 삭제되며 복구할 수 없습니다.\n정말 탈퇴하시겠어요?',
                      onConfirm: () {
                        // TODO: 회원탈퇴 로직 구현
                        Navigator.of(context).pop(); // 다이얼로그 닫기
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 사용자 프로필 카드 위젯
  Widget _buildUserProfileCard(BuildContext context,
      {required String name, required String email}) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.primary,
            child: Icon(Icons.person, color: Colors.white, size: 30),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                email,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 메뉴 섹션 컨테이너 위젯
  Widget _buildMenuSection(BuildContext context,
      {required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: Text(
            title,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700]),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  // 확인 다이얼로그를 보여주는 함수
  void _showConfirmationDialog(
      BuildContext context, {
        required String title,
        required String content,
        required VoidCallback onConfirm,
      }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: const Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              onPressed: onConfirm,
              child: Text('확인', style: TextStyle(color: title == '회원탈퇴' ? Colors.red : AppColors.primary)),
            ),
          ],
        );
      },
    );
  }
}

// 재사용 가능한 메뉴 타일 위젯
class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? textColor;

  const _MenuTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: textColor ?? AppColors.primary),
      title: Text(title, style: TextStyle(color: textColor)),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }
}
