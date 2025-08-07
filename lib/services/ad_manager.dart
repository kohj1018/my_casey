import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/foundation.dart';

class AdManager {
  static final AdManager _instance = AdManager._internal();
  factory AdManager() => _instance;
  AdManager._internal();

  static AdManager get instance => _instance;

  // 배너 광고 단위 ID
  static String get bannerAdUnitId {
    // kReleaseMode를 사용하여 릴리스 빌드에서만 실제 광고 표시
    if (kReleaseMode) {
      // 릴리스 모드에서는 실제 광고 ID 사용
      if (Platform.isAndroid) {
        return 'ca-app-pub-3397931650520195/2194067779'; // Android 배너 광고 ID
      } else if (Platform.isIOS) {
        return 'ca-app-pub-3397931650520195/6851498087'; // iOS 배너 광고 ID
      }
    } else {
      // 디버그/프로파일 모드에서는 테스트 광고 ID 사용
      if (Platform.isAndroid) {
        return 'ca-app-pub-3940256099942544/6300978111';
      } else if (Platform.isIOS) {
        return 'ca-app-pub-3940256099942544/2934735716';
      }
    }
    throw UnsupportedError('Unsupported platform');
  }



  // AdMob 초기화
  static Future<void> initialize() async {
    await MobileAds.instance.initialize();
  }

  // 공식 Collapsible 배너광고 생성 (2025년 최신 방식)
  BannerAd createBannerAd() {
    String adUnitId = bannerAdUnitId;
    if (kDebugMode) {
      print('🟡 Google 공식 Collapsible 배너광고 생성 중...');
      print('🟡 AdUnit ID: $adUnitId');
      print('🟡 플랫폼: ${Platform.isAndroid ? "Android" : "iOS"}');
      print('🟡 빌드 모드: ${kReleaseMode ? "Release" : (kProfileMode ? "Profile" : "Debug")}');
      print('🟡 테스트 광고 사용: ${!kReleaseMode}');
    }
    
    return BannerAd(
      adUnitId: adUnitId,
      size: AdSize.banner,
      request: AdRequest(
        // Google 공식 Collapsible Banner 설정 (2025년 최신)
        extras: {
          'collapsible': 'bottom', // 하단 고정용
        },
      ),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (kDebugMode) {
            print('🟢 배너광고 로드 완료: ${ad.adUnitId}');
          }
        },
        onAdFailedToLoad: (ad, error) {
          if (kDebugMode) {
            print('🔴 배너광고 로드 실패');
            print('🔴 Error Code: ${error.code}');
            print('🔴 Error Message: ${error.message}');
            print('🔴 Error Domain: ${error.domain}');
          }
          ad.dispose();
        },
        onAdOpened: (ad) {
          if (kDebugMode) {
            print('🟢 배너광고 열림');
          }
        },
        onAdClosed: (ad) {
          if (kDebugMode) {
            print('🟡 배너광고 닫힘');
          }
        },
        onAdClicked: (ad) {
          if (kDebugMode) {
            print('🟡 배너광고 클릭됨');
          }
        },
      ),
    );
  }
}