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
    if (kDebugMode) {
      // 디버그 모드에서는 테스트 광고 ID 사용
      if (Platform.isAndroid) {
        return 'ca-app-pub-3940256099942544/6300978111';
      } else if (Platform.isIOS) {
        return 'ca-app-pub-3940256099942544/2934735716';
      }
    }
    // 실제 배포용 광고 ID
    if (Platform.isAndroid) {
      return 'ca-app-pub-3397931650520195/2194067779'; // Android 배너 광고 ID
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3397931650520195/6851498087'; // iOS 배너 광고 ID
    }
    throw UnsupportedError('Unsupported platform');
  }



  // AdMob 초기화
  static Future<void> initialize() async {
    await MobileAds.instance.initialize();
  }

  // 배너광고 생성
  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (kDebugMode) {
            print('배너광고 로드 완료: ${ad.adUnitId}');
          }
        },
        onAdFailedToLoad: (ad, error) {
          if (kDebugMode) {
            print('배너광고 로드 실패: $error');
          }
          ad.dispose();
        },
        onAdOpened: (ad) {
          if (kDebugMode) {
            print('배너광고 열림');
          }
        },
        onAdClosed: (ad) {
          if (kDebugMode) {
            print('배너광고 닫힘');
          }
        },
      ),
    );
  }
}