import 'package:flutter/material.dart';
import 'package:withpet/core/constants/app_sizes.dart';
import 'package:withpet/core/theme/colors.dart';

class CustomBottomButton extends StatelessWidget {
  final String text; // 버튼에 표시될 텍스트
  final VoidCallback onPressed; // 버튼을 눌렀을 때 실행될 함수
  final Color? buttonColor; // 버튼 배경색 (선택 사항)
  final double buttonHeight; // 버튼 높이 (선택 사항)
  final bool isDisabled; // 버튼 비활성화 여부 (선택 사항)

  const CustomBottomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.buttonColor,
    this.buttonHeight = 60.0,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final onPressedAction = isDisabled ? null : onPressed;
    final bottomPadding =
        context.platform == TargetPlatform.android ? 16.0 : 0.0;

    return Container(
      padding: EdgeInsets.fromLTRB(
        16,
        16,
        16,
        context.bottomBarHeight + bottomPadding, // 안드로이드 기기에만 bottompadding값 추가
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          disabledBackgroundColor: Colors.grey[300],
          disabledForegroundColor: Colors.grey[600],
        ),
        onPressed: onPressedAction,
        child: Text(text),
      ),
    );
  }
}
