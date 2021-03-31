import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sigara_metre/util/constants.dart';

class MyAdWidget extends StatefulWidget {
  @override
  _MyAdWidgetState createState() => _MyAdWidgetState();
}

class _MyAdWidgetState extends State<MyAdWidget> {
  BannerAd bannerAd;
  @override
  void initState() {
    super.initState();
    bannerAd = BannerAd(
      adUnitId: Platform.isAndroid ? admob_unit_id_android : '',
      size: AdSize.banner,
      request: AdRequest(
          // // keywords: <String>['foo', 'bar'],
          ),
      listener: AdListener(
        onAdLoaded: (Ad ad) => print('Ad loaded.'),
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          print('Ad failed to load: $error');
        },
        onAdOpened: (Ad ad) => print('Ad opened.'),
        onAdClosed: (Ad ad) => print('Ad closed.'),
        onApplicationExit: (Ad ad) => print('Left application.'),
      ),
    );
    bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return AdWidget(
      ad: bannerAd,
    );
  }
}
