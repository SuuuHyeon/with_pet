import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/colors.dart';
import '../../../../data/repositories/auth_repository.dart';

class MyPageTab extends ConsumerWidget {
  const MyPageTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 2. userProfileProvider를 'watch'하여 현재 사용자 프로필의 상태를 가져옵니다.
    //    이제 userProfileState는 로딩, 에러, 데이터 중 하나의 상태를 가집니다.
    final userProfileState = ref.watch(userProfileProvider);

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(
        title: const Text('마이페이지'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      // 3. .when()을 사용하여 각 상태에 맞는 UI를 명확하게 그려줍니다.
      body: userProfileState.when(
        // '로딩 중' 상태일 때 보여줄 위젯
        loading: () => const Center(child: CircularProgressIndicator()),
        // '에러' 상태일 때 보여줄 위젯
        error: (err, stack) => Center(child: Text('사용자 정보를 불러올 수 없습니다.')),
        // '데이터 있음' 상태일 때 보여줄 위젯
        data: (userModel) {
          // 4. userModel이 null이면 로그아웃 상태, 아니면 로그인 상태입니다.
          if (userModel == null) {
            return const Center(
              child: Text('로그인이 필요합니다.'), // TODO: 로그인 버튼으로 교체 가능
            );
          }

          // 5. 성공적으로 UserModel을 가져왔으면, 그 데이터를 사용하여 UI를 그립니다.
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Column(
              children: [
                // 사용자 프로필 카드
                _buildUserProfileCard(
                  context,
                  name: userModel.nickname, // 👈 실제 사용자 닉네임 사용
                  email: userModel.email, // 👈 실제 사용자 이메일 사용
                ),
                const SizedBox(height: 24.0),

                // ... (로그아웃, 회원탈퇴 등 메뉴 섹션)
              ],
            ),
          );
        },
      ),
    );
  }

  // 사용자 프로필 카드 위젯 (기존 코드와 동일)
  Widget _buildUserProfileCard(
    BuildContext context, {
    required String name,
    required String email,
  }) {
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
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
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
}
