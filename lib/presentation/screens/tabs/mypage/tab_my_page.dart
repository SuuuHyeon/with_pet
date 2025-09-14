import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/colors.dart';
import '../../../../data/repositories/auth_repository.dart';
import '../../../widgets/w_custom_dialog.dart';

class MyPageTab extends ConsumerWidget {
  const MyPageTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfileState = ref.watch(userProfileProvider);

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(
        title: const Text('마이페이지'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: userProfileState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('사용자 정보를 불러올 수 없습니다.')),
        data: (userModel) {
          if (userModel == null) {
            return const Center(
              child: Text('로그인이 필요합니다.'),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              children: [
                // 1. 사용자 프로필 카드
                _UserProfileCard(
                  name: userModel.nickname,
                  email: userModel.email,
                  onEdit: () {
                    // TODO: 프로필 수정 페이지로 이동
                  },
                ),
                const SizedBox(height: 24.0),

                // 2. 메뉴 섹션들
                _MenuSection(
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
                _MenuSection(
                  title: '앱 지원',
                  children: [
                    _MenuTile(
                      icon: Icons.feedback_outlined,
                      title: '피드백 보내기',
                      onTap: () {
                        // TODO: 피드백 기능 구현 (예: 이메일 앱 열기)
                      },
                    ),
                    _MenuTile(
                      icon: Icons.info_outline,
                      title: '앱 정보',
                      onTap: () {
                        // TODO: 앱 정보 다이얼로그 표시
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                _MenuSection(
                  title: '계정',
                  children: [
                    _MenuTile(
                      icon: Icons.logout,
                      title: '로그아웃',
                      onTap: () => _showLogoutDialog(context, ref),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showCustomDialog(
      context,
      type: DialogType.confirm,
      title: '로그아웃',
      content: '정말 로그아웃 하시겠어요?',
      onConfirm: () {
        context.pop(); // 다이얼로그 닫기
        // ref.read(authViewModelProvider.notifier).logOut();
      },
    );
  }
}

// 사용자 프로필 카드 위젯
class _UserProfileCard extends StatelessWidget {
  final String name;
  final String email;
  final VoidCallback onEdit;

  const _UserProfileCard(
      {required this.name, required this.email, required this.onEdit});

  @override
  Widget build(BuildContext context) {
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
          Expanded(
            child: Column(
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
          ),
          IconButton(
            icon: Icon(Icons.edit_outlined, color: Colors.grey[400]),
            onPressed: onEdit,
          ),
        ],
      ),
    );
  }
}

// 메뉴 섹션 컨테이너 위젯
class _MenuSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _MenuSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
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
          // 메뉴 타일 사이에 구분선을 추가합니다.
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => children[index],
            separatorBuilder: (context, index) =>
                Divider(height: 1, indent: 56, color: Colors.grey[200]),
            itemCount: children.length,
          ),
        ),
      ],
    );
  }
}

// 재사용 가능한 메뉴 타일 위젯
class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _MenuTile(
      {required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }
}
