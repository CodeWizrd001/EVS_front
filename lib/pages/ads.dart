import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:evs_app/pages/globals.dart';
import 'package:evs_app/pages/request.dart';

const String testDevice = 'MobileId';
bool adinit = false;

BannerAd commonBanner;
RewardedVideoAd videoAd = RewardedVideoAd.instance;

getBannerAd() {
  print("Premium $premium");
  if (premium) return;
  AddState.adInit();
  //Change appId With Admob Id
  commonBanner = AddState.createBannerAd()
    ..load()
    ..show();
}

class Add extends StatefulWidget {
  @override
  AddState createState() => AddState();
}

class AddState extends State<Add> {
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    nonPersonalizedAds: true,
  );

  static BannerAd _bannerAd;
  static InterstitialAd _interstitialAd;

  static BannerAd createBannerAd() {
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

  static InterstitialAd createInterstitialAd() {
    return InterstitialAd(
        //adUnitId: InterstitialAd.testAdUnitId,
        adUnitId: 'ca-app-pub-9864167210400678/7724165595',
        //Change Interstitial AdUnitId with Admob ID
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("IntersttialAd $event");
        });
  }

  static createRewardAd() async {
    await videoAd.load(
      adUnitId: "ca-app-pub-9864167210400678/7399311081",
      targetingInfo: targetingInfo,
    );
    try {
      videoAd..show();
    } catch (e) {
      print(e);
    }
  }

  static adInit() {
    if (adinit) return;
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-9864167210400678/8432217385");
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-9864167210400678/7724165595");
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-9864167210400678/7399311081");
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-9864167210400678/3268494389");
    videoAd.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      for (int i = 0; i < 10; i += 1) print("Event $event");
      if (event == RewardedVideoAdEvent.rewarded) {
        coins += 30;
        makeRequest('/coins', {
          'id': androidInfo.androidId,
          'coins': coins,
        });
      }
    };
    adinit = true;
  }

  static disposeAds() {
    if (commonBanner != null) commonBanner.dispose();
  }

  @override
  void initState() {
    adInit();
    //Change appId With Admob Id
    //_bannerAd = createBannerAd()
    //  ..load()
    //  ..show();
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
        title: Text("View Ads"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Text(
              "View Reward Ad To Get 30 Coins",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            RaisedButton(
              child: Text('Click on Ads'),
              onPressed: () {
                createInterstitialAd()
                  ..load()
                  ..show();
              },
            ),
            RaisedButton(
              child: Text('Click on Reward Ad'),
              onPressed: () {
                createRewardAd();
              },
            ),
          ],
        ),
      ),
    );
  }
}
