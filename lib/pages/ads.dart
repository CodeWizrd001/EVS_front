import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';

const String testDevice = 'MobileId';

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: true,
    keywords: <String>['Game', 'Mario'],
  );

  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;

  BannerAd createBannerAd() {
    print("Ad $targetingInfo");
    return BannerAd(
        //adUnitId: BannerAd.testAdUnitId,
        adUnitId: "ca-app-pub-9864167210400678/8432217385",
        //Change BannerAd adUnitId with Admob ID
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("BannerAd $event");
        });
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
        //adUnitId: InterstitialAd.testAdUnitId,
        adUnitId: 'ca-app-pub-9864167210400678/7724165595',
        //Change Interstitial AdUnitId with Admob ID
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("IntersttialAd $event");
        });
  }

  @override
  void initState() {
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-9864167210400678/8432217385");
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-9864167210400678/7724165595");
    //Change appId With Admob Id
    _bannerAd = createBannerAd()
      ..load()
      ..show();
    super.initState();
  }

  @override
  void dispose() {
    if (_bannerAd != null) _bannerAd.dispose();
    if (_interstitialAd != null) _interstitialAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo App"),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Click on Ads'),
          onPressed: () {
            createInterstitialAd()
              ..load()
              ..show();
          },
        ),
      ),
    );
  }
}
