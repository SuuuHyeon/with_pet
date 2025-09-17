import 'package:flutter/material.dart';
import 'package:withpet/core/constants/app_sizes.dart';

import '../../../../core/theme/colors.dart';

/// 화면 상단의 반려동물 대표 정보를 보여주는 헤더 위젯입니다.
class PetProfileCard extends StatelessWidget {
  final String imageUrl, name, breed;
  final int age, daysTogether;

  const PetProfileCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.breed,
    required this.age,
    required this.daysTogether,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        24.0,
        context.statusBarHeight + 16.0,
        24.0,
        32.0,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary.withOpacity(0.8), AppColors.primary],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(40.0),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
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
                      color: Colors.white),
                ),
                const SizedBox(height: 4.0),
                Text(
                  '$breed / $age살',
                  style: const TextStyle(fontSize: 15, color: Colors.white70),
                ),
                const SizedBox(height: 4.0),
                Text(
                  '함께한 지 $daysTogether일째',
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 반려동물의 핵심 건강 정보를 요약해서 보여주는 카드 위젯입니다.
class HealthSummary extends StatelessWidget {
  const HealthSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _InfoTile(
              icon: Icons.monitor_weight_outlined,
              label: '몸무게',
              value: '8.5kg',
            ),
            _InfoTile(
              icon: Icons.rice_bowl_outlined,
              label: '사료',
              value: '하루 200g',
            ),
            _InfoTile(
              icon: Icons.pets_outlined,
              label: '오늘 산책',
              value: '45분',
            ),
          ],
        ),
      ),
    );
  }
}

// 정보 타일 위젯 (밝은 배경용으로 수정)
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
        Icon(icon, color: AppColors.primary, size: 28),
        const SizedBox(height: 8.0),
        Text(
          label,
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),
        const SizedBox(height: 4.0),
        Text(
          value,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
