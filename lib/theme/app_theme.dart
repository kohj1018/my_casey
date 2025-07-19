import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// --- 새로운 컬러 팔레트 ---
class AppColors {
  // 메인 컬러 (깊고 안정적인 블루 톤)
  static const Color primary = Color(0xFF1E40AF); // 깊은 블루 (신뢰성, 전문성)
  static const Color primaryLight = Color(0xFF3B82F6); // 밝은 블루
  static const Color primaryDark = Color(0xFF1E3A8A); // 더 깊은 블루
  
  // 서브 컬러 (모던한 보조 톤)
  static const Color secondary = Color(0xFF6366F1); // 인디고 (현대적)
  static const Color secondaryLight = Color(0xFF8B5CF6); // 보라빛 인디고
  
  // 액센트 컬러 (포인트 컬러)
  static const Color accent = Color(0xFFEF4444); // 생동감 있는 레드
  static const Color accentOrange = Color(0xFFF59E0B); // 따뜻한 오렌지
  
  // 배경 및 표면 컬러 (깔끔하고 모던한 톤)
  static const Color background = Color(0xFFF8FAFC); // 아주 연한 블루 그레이
  static const Color surface = Color(0xFFFFFFFF); // 순수한 화이트
  static const Color surfaceLight = Color(0xFFF1F5F9); // 연한 그레이
  
  // 텍스트 컬러 (가독성 최적화)
  static const Color textPrimary = Color(0xFF0F172A); // 진한 슬레이트
  static const Color textSecondary = Color(0xFF475569); // 중간 톤 슬레이트
  static const Color textTertiary = Color(0xFF94A3B8); // 연한 슬레이트

  // 상태별 컬러 (직관적인 색상)
  static const Color success = Color(0xFF10B981); // 에메랄드 그린
  static const Color warning = Color(0xFFF59E0B); // 앰버
  static const Color error = Color(0xFFEF4444); // 레드
  static const Color info = Color(0xFF06B6D4); // 시안
  
  // 그라데이션 컬러
  static const List<Color> primaryGradient = [
    Color(0xFF1E40AF),
    Color(0xFF3B82F6),
  ];
  
  static const List<Color> secondaryGradient = [
    Color(0xFF6366F1),
    Color(0xFF8B5CF6),
  ];
}

// --- 개선된 텍스트 스타일 ---
class AppTextStyles {
  static final TextStyle displayLarge = GoogleFonts.inter(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static final TextStyle displayMedium = GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static final TextStyle headlineLarge = GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static final TextStyle headlineMedium = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static final TextStyle titleLarge = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static final TextStyle bodyLarge = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static final TextStyle bodyMedium = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  static final TextStyle bodySmall = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textTertiary,
    height: 1.4,
  );

  static final TextStyle labelLarge = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static final TextStyle labelMedium = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 1.4,
  );
}

// --- 모던한 앱 테마 ---
ThemeData getAppTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surface,
      background: AppColors.background,
      error: AppColors.error,
    ),
    
    scaffoldBackgroundColor: AppColors.background,
    
    textTheme: TextTheme(
      displayLarge: AppTextStyles.displayLarge,
      displayMedium: AppTextStyles.displayMedium,
      headlineLarge: AppTextStyles.headlineLarge,
      headlineMedium: AppTextStyles.headlineMedium,
      titleLarge: AppTextStyles.titleLarge,
      bodyLarge: AppTextStyles.bodyLarge,
      bodyMedium: AppTextStyles.bodyMedium,
      bodySmall: AppTextStyles.bodySmall,
      labelLarge: AppTextStyles.labelLarge,
      labelMedium: AppTextStyles.labelMedium,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.surface,
      elevation: 0,
      scrolledUnderElevation: 1,
      titleTextStyle: AppTextStyles.headlineMedium,
      iconTheme: const IconThemeData(color: AppColors.textPrimary),
    ),

    cardTheme: CardThemeData(
      elevation: 2,
      shadowColor: AppColors.textPrimary.withOpacity(0.08),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      color: AppColors.surface,
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textTertiary,
      elevation: 8,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: AppTextStyles.labelMedium.copyWith(
        color: AppColors.primary,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: AppTextStyles.labelMedium.copyWith(
        color: AppColors.textTertiary,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        textStyle: AppTextStyles.labelLarge.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return AppColors.primary;
        }
        return AppColors.textTertiary;
      }),
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return AppColors.primary.withOpacity(0.3);
        }
        return AppColors.surfaceLight;
      }),
    ),
  );
} 