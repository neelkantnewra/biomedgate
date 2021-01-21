import 'package:firebase_admob/firebase_admob.dart';

class CustomAdmob {
  MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['flutterio', 'beautiful apps'],
    contentUrl: 'https://flutter.io',
    childDirected: false,
    testDevices: <String>[], // Android emulators are considered test devices
  );

  // BannerAd bannerAd() {
  //   return BannerAd(
  //     adUnitId: InterstitialAd.testAdUnitId,
  //     size: AdSize.smartBanner,
  //     targetingInfo: targetingInfo,
  //     listener: (MobileAdEvent event) {
  //       print("BannerAd event is $event");
  //     },
  //   );
  // }

  InterstitialAd interstitialAd() {
    return InterstitialAd(
      adUnitId: "ca-app-pub-1433276656379191/5690779956",
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event is $event");
      },
    );
  }
}
