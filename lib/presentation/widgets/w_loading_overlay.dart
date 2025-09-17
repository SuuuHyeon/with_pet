import 'package:flutter/material.dart';

import '../../core/theme/colors.dart';

/// 비동기 처리 중일 때 화면 전체를 덮는 로딩 오버레이를 표시하는 위젯입니다.
///
/// [isLoading] 플래그를 통해 로딩 화면의 표시 여부를 제어하고,
/// [child] 위젯 위에 반투명한 오버레이와 로딩 인디케이터를 겹쳐서 보여줍니다.
class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1. 맨 아래층에 실제 화면 UI를 배치합니다.
        child,

        // 2. isLoading이 true일 때만 맨 위층에 로딩 오버레이를 표시합니다.
        if (isLoading)
          // AbsorbPointer를 사용하여 로딩 중 하위 위젯의 터치를 막습니다.
          AbsorbPointer(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withValues(alpha: 0.5),
              child: const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            ),
          ),
      ],
    );
  }
}
