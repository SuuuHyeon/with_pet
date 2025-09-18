import 'package:flutter/material.dart';
import 'package:withpet/core/theme/colors.dart';

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: AppColors.appBackground,
  textTheme: TextTheme(
    titleLarge: TextStyle(color: Color(0xff28222B)),
    titleMedium: TextStyle(color: Color(0xff28222B).withValues(alpha: 0.8)),
    titleSmall: TextStyle(color: Color(0xff28222B).withValues(alpha: 0.6)),
  ),

  /// ElevatedButton 스타일
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFF17D2A),
      // 버튼 배경색
      foregroundColor: Colors.white,
      // 버튼 글자색
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  ),

  /// TextField, TextFormField 등 입력 필드의 기본 스타일 설정
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide.none,
    ),
    // border: OutlineInputBorder(
    //   borderRadius: BorderRadius.circular(12.0),
    //   borderSide: BorderSide(color: Color(0xFFFF0000), width: 2.0),
    // ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: Color(0xFFF27507), width: 2.0),
    ),
    floatingLabelStyle: const TextStyle(color: AppColors.primary),
  ),

  /// ToggleButtons 스타일 (개선안)
  toggleButtonsTheme: ToggleButtonsThemeData(
    // 1. 선택된 버튼의 배경색
    fillColor: AppColors.primary,
    // 2. 선택된 버튼의 텍스트/아이콘 색상
    selectedColor: Colors.white,
    // 3. 선택되지 않은 버튼의 텍스트/아이콘 색상
    color: AppColors.primary,
    // 4. 선택되지 않은 버튼의 테두리 색상
    borderColor: AppColors.primary.withOpacity(0.5),
    // 5. 선택된 버튼의 테두리 색상
    selectedBorderColor: AppColors.primary,
    // 6. 전체적인 둥글기
    borderRadius: BorderRadius.circular(25.0), // 좀 더 부드러운 느낌
    // 7. 텍스트 스타일 (두께 추가)
    textStyle: const TextStyle(fontWeight: FontWeight.w600),
    // 8. 고정된 크기 대신 내부 여백을 사용하여 유연한 크기를 갖도록 함
    constraints: const BoxConstraints(minHeight: 40.0),
  ),

  datePickerTheme: DatePickerThemeData(
    headerBackgroundColor: AppColors.primary,
    headerForegroundColor: Colors.white,
    dayForegroundColor: WidgetStateProperty.all(Colors.black),
    dayBackgroundColor: WidgetStateProperty.all(Colors.white),
    dayOverlayColor: WidgetStateProperty.all(AppColors.primary.withOpacity(0.1)),
    todayForegroundColor: WidgetStateProperty.all(AppColors.primary),
    todayBackgroundColor: WidgetStateProperty.all(AppColors.primary.withOpacity(0.1)),
    backgroundColor: Colors.white,
  ),

  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.white; // 선택된 상태의 thumb 색상
      }
      return Colors.grey; // 선택되지 않은 상태의 thumb 색상
    }),
    trackColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(MaterialState.selected)) {
        return AppColors.primary.withValues(alpha: 0.5); // 선택된 상태의 track 색상
      }
      return Colors.grey.withValues(alpha: 0.5); // 선택되지 않은 상태의 track 색상
    }),
    trackOutlineColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.transparent;
      }
      return Colors.transparent;
    }),
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: AppColors.primary,
    unselectedItemColor: Colors.grey,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
  ),
);

ThemeData darkMode = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: Color(0xff1C1B1F),
  textTheme: TextTheme(
    titleLarge: TextStyle(color: Color(0xff28222B)),
    titleMedium: TextStyle(color: Color(0xff28222B).withValues(alpha: 0.8)),
    titleSmall: TextStyle(color: Color(0xff28222B).withValues(alpha: 0.6)),
  ),
);
