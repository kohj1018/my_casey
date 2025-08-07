import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:my_casey/services/ad_manager.dart';
import 'package:my_casey/theme/app_theme.dart';

class SimpleBannerAd extends StatefulWidget {
  const SimpleBannerAd({Key? key}) : super(key: key);

  @override
  State<SimpleBannerAd> createState() => _SimpleBannerAdState();
}

class _SimpleBannerAdState extends State<SimpleBannerAd> {
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;
  bool _hasLoadError = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  void _loadBannerAd() {
    if (kDebugMode) {
      print('🟡 Google 공식 Collapsible Banner 로딩 시작...');
    }
    
    _bannerAd = AdManager.instance.createBannerAd();
    _bannerAd!.load().then((_) {
      if (kDebugMode) {
        print('🟢 Collapsible Banner 로딩 성공!');
        print('📏 광고 크기: ${_bannerAd!.size.width}x${_bannerAd!.size.height}');
      }
      if (mounted) {
        setState(() {
          _isAdLoaded = true;
          _hasLoadError = false;
          _errorMessage = null;
        });
      }
    }).catchError((error) {
      if (kDebugMode) {
        print('🔴 Collapsible Banner 로딩 실패: $error');
      }
      if (mounted) {
        setState(() {
          _isAdLoaded = false;
          _hasLoadError = true;
          _errorMessage = error.toString();
        });
      }
    });
  }

  void _retryLoadAd() {
    setState(() {
      _hasLoadError = false;
      _errorMessage = null;
      _isAdLoaded = false;
    });
    _bannerAd?.dispose();
    _loadBannerAd();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 광고 로딩 실패 시 에러 정보 표시 (디버그 모드에서만)
    if (_hasLoadError && kDebugMode) {
      return Container(
        height: 60,
        color: Colors.red.withOpacity(0.1),
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '광고 로딩 실패',
                    style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _errorMessage ?? "알 수 없는 오류",
                    style: TextStyle(color: Colors.red, fontSize: 10),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: _retryLoadAd,
              child: Text('재시도', style: TextStyle(color: Colors.red, fontSize: 12)),
            ),
          ],
        ),
      );
    }

    // 광고가 로딩되지 않았거나 광고 객체가 없는 경우
    if (!_isAdLoaded || _bannerAd == null) {
      // 디버그 모드에서는 로딩 상태 표시
      if (kDebugMode) {
        return Container(
          height: 50,
          color: Colors.yellow.withOpacity(0.1),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  '광고 로딩 중...',
                  style: TextStyle(color: Colors.orange, fontSize: 12),
                ),
              ],
            ),
          ),
        );
      }
      return const SizedBox.shrink();
    }

    // Google 공식 Collapsible Banner 표시
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(
            color: AppColors.surfaceLight,
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          width: _bannerAd!.size.width.toDouble(),
          height: _bannerAd!.size.height.toDouble(),
          alignment: Alignment.center,
          child: AdWidget(ad: _bannerAd!),
        ),
      ),
    );
  }
}
