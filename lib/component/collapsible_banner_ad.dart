import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:my_casey/services/ad_manager.dart';
import 'package:my_casey/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CollapsibleBannerAd extends StatefulWidget {
  const CollapsibleBannerAd({Key? key}) : super(key: key);

  @override
  State<CollapsibleBannerAd> createState() => _CollapsibleBannerAdState();
}

class _CollapsibleBannerAdState extends State<CollapsibleBannerAd>
    with SingleTickerProviderStateMixin {
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;
  bool _isCollapsed = false;
  late AnimationController _animationController;
  late Animation<double> _heightAnimation;
  static const String _adCollapseKey = 'banner_ad_collapsed';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _heightAnimation = Tween<double>(
      begin: 70.0, // 배너 높이 + 패딩
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _loadAdCollapseState();
    _loadBannerAd();
  }

  void _loadAdCollapseState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isCollapsed = prefs.getBool(_adCollapseKey) ?? false;
      if (_isCollapsed) {
        _animationController.forward();
      }
    });
  }

  void _saveAdCollapseState(bool collapsed) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_adCollapseKey, collapsed);
  }

  void _loadBannerAd() {
    _bannerAd = AdManager.instance.createBannerAd();
    _bannerAd!.load().then((_) {
      if (mounted) {
        setState(() {
          _isAdLoaded = true;
        });
      }
    });
  }

  void _toggleCollapse() {
    setState(() {
      _isCollapsed = !_isCollapsed;
      if (_isCollapsed) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
      _saveAdCollapseState(_isCollapsed);
    });
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isAdLoaded || _bannerAd == null) {
      return const SizedBox.shrink();
    }

    return AnimatedBuilder(
      animation: _heightAnimation,
      builder: (context, child) {
        return Container(
          height: _heightAnimation.value,
          child: _heightAnimation.value > 5 ? child : null,
        );
      },
      child: Container(
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
        child: Stack(
          children: [
            // 배너광고
            Center(
              child: Container(
                width: _bannerAd!.size.width.toDouble(),
                height: _bannerAd!.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd!),
              ),
            ),
            
            // 접기/펼치기 버튼
            Positioned(
              top: 4,
              right: 8,
              child: GestureDetector(
                onTap: _toggleCollapse,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.textTertiary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _isCollapsed ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    size: 16,
                    color: AppColors.textTertiary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 접힌 상태에서 보여줄 미니 탭
class CollapsedAdTab extends StatelessWidget {
  final VoidCallback onTap;

  const CollapsedAdTab({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 24,
        width: double.infinity,
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
              blurRadius: 5,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: Center(
          child: Container(
            width: 40,
            height: 3,
            decoration: BoxDecoration(
              color: AppColors.textTertiary.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ),
    );
  }
}