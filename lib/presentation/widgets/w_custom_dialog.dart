import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/colors.dart';

// 다이얼로그의 타입을 정의하는 enum
enum DialogType { success, error, confirm }

/// 앱 전체에서 사용할 커스텀 다이얼로그 위젯입니다.
class CustomDialog extends StatelessWidget {
  final DialogType dialogType;
  final String title;
  final String content;
  final VoidCallback onConfirm;

  const CustomDialog({
    super.key,
    required this.dialogType,
    required this.title,
    required this.content,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    // 타입에 따라 아이콘과 아이콘 배경색을 결정합니다.
    IconData icon;
    Color iconBgColor;
    switch (dialogType) {
      case DialogType.success:
        icon = Icons.check_circle;
        iconBgColor = Color(0xFF3FBF48);
        break;
      case DialogType.error:
        icon = Icons.error;
        iconBgColor = Colors.red;
        break;
      case DialogType.confirm:
        icon = Icons.help;
        iconBgColor = Colors.grey;
        break;
    }

    return Dialog(
      backgroundColor: AppColors.appBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // 콘텐츠 크기에 맞게 높이 조절
          children: [
            // 1. 상단 아이콘
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: iconBgColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconBgColor, size: 40),
            ),
            const SizedBox(height: 16),

            // 2. 제목
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // 3. 내용
            Text(
              content,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),

            // 4. 버튼
            Row(
              children: [
                // '확인(confirm)' 타입일 때만 '취소' 버튼을 보여줍니다.
                if (dialogType == DialogType.confirm) ...[
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => context.pop(),
                      child: const Text('취소'),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: ElevatedButton(
                    onPressed: onConfirm,
                    child: const Text('확인'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// 다이얼로그를 쉽게 띄울 수 있도록 도와주는 헬퍼 함수
Future<void> showCustomDialog(
    BuildContext context, {
      required DialogType type,
      required String title,
      required String content,
      required VoidCallback onConfirm,
    }) {
  return showDialog(
    context: context,
    // 다이얼로그 바깥을 탭해도 닫히지 않도록 설정
    barrierDismissible: false,
    builder: (BuildContext context) {
      return CustomDialog(
        dialogType: type,
        title: title,
        content: content,
        onConfirm: onConfirm,
      );
    },
  );
}
