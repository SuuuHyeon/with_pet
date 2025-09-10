import 'package:flutter/material.dart';
import 'package:withpet/core/constants/app_sizes.dart';

import '../../../../core/theme/colors.dart';

// 반려동물 프로필 카드 위젯
class PetProfileCard extends StatelessWidget {
  final String imageUrl, name;
  final int age, daysTogether;

  const PetProfileCard({
    required this.imageUrl,
    required this.name,
    required this.age,
    required this.daysTogether,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        16.0,
        context.statusBarHeight + 16.0,
        16.0,
        24.0,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary.withOpacity(0.8), AppColors.primary],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(32.0),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // 1. 상단 프로필 정보
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.5),
                    width: 2,
                  ),
                ),
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(imageUrl),
                  backgroundColor: Colors.grey[200],
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      '$age살',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      '함께한 지 $daysTogether일째',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24.0),
          // 2. 핵심 건강 정보 요약 컨테이너
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 16.0,
            ),
            decoration: BoxDecoration(
              color: Color(0xFFFFBB99),
              // color: Color(0xFFFFBB99),
              borderRadius: BorderRadius.circular(16.0),
              // AppSizes.largeCornerRadius
              // border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: _InfoTile(
                    icon: Icons.monitor_weight_outlined,
                    label: '몸무게',
                    value: '8.5kg',
                  ),
                ),
                SizedBox(
                  height: 60, // 구분선의 높이 지정
                  child: VerticalDivider(
                    color: Colors.white,
                    width: 1,
                    thickness: 1,
                  ),
                ),
                Expanded(
                  child: _InfoTile(
                    icon: Icons.rice_bowl_outlined,
                    label: '사료',
                    value: '하루 200g',
                  ),
                ),
                SizedBox(
                  height: 60, // 구분선의 높이 지정
                  child: VerticalDivider(
                    color: Colors.white,
                    width: 1,
                    thickness: 1,
                  ),
                ),
                Expanded(
                  child: _InfoTile(
                    icon: Icons.pets_outlined,
                    label: '오늘 산책',
                    value: '45분 / 60분',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 정보 타일 위젯
class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(height: 4.0), // AppSizes.gapV4
        Text(
          label,
          style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 12),
        ),
        const SizedBox(height: 4.0), // AppSizes.gapV4
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
