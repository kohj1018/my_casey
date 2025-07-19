import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// --- 색상 팔레트 ---
class AppColors {
  // 기본 색상
  static const Color primary = Color(0xFF0A2463); // 짙은 네이비
  static const Color secondary = Color(0xFF1E56A0); // 중간 톤 블루
  static const Color accent = Color(0xFFD63447); // 포인트 레드 (기존 red 와 유사)
  static const Color background = Color(0xFFF5F5F5); // 밝은 회색 배경
  static const Color surface = Color(0xFFFFFFFF); // 카드 등 표면 색상 (흰색)

  // 텍스트 색상
  static const Color textPrimary = Color(0xFF333333); // 기본 텍스트
  static const Color textSecondary = Color(0xFF666666); // 보조 텍스트 (더 연함)

  // 상태별 색상
  static const Color success = Color(0xFF28a745);
  static const Color error = Color(0xFFdc3545);
  static const Color info = Color(0xFF17a2b8); // 다음 버스 등 정보성
  static const Color disabled = Color(0xFFBDBDBD); // 지난 버스 등 비활성 정보
}

// --- 텍스트 스타일 ---
class AppTextStyles {
  static final TextStyle headline1 = GoogleFonts.lato(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static final TextStyle headline2 = GoogleFonts.lato(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static final TextStyle bodyText1 = GoogleFonts.lato(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  static final TextStyle bodyText2 = GoogleFonts.lato(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  static final TextStyle caption = GoogleFonts.lato(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );
}

// --- 앱 테마 ---
ThemeData getAppTheme() {
  return ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    cardColor: AppColors.surface,
    hintColor: AppColors.accent,

    textTheme: TextTheme(
      displayLarge: AppTextStyles.headline1,
      displayMedium: AppTextStyles.headline2,
      bodyLarge: AppTextStyles.bodyText1,
      bodyMedium: AppTextStyles.bodyText2,
      bodySmall: AppTextStyles.caption,
    ),

    cardTheme: CardThemeData(
      elevation: 4.0,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),

    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surface,
      background: AppColors.background,
      error: AppColors.error,
    ).copyWith(background: AppColors.background),
  );
} 