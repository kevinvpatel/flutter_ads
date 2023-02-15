import 'dart:convert';

import 'package:dummy_ad_flutter/app/modules/splash_screen/controllers/splash_screen_controller.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'app/routes/app_pages.dart';

///Firebase Config
final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
RxMap configData = {}.obs;

Future initConfig() async {
  await remoteConfig.setConfigSettings(
      RemoteConfigSettings(fetchTimeout: const Duration(milliseconds: 1000), minimumFetchInterval: const Duration(seconds: 10))
  );
  await remoteConfig.fetchAndActivate();
}

///App Open Ad
AppOpenAd? appOpenAd;
initAppOpenAd() {
  AppOpenAd.load(
      adUnitId: configData['app_open-admob'],
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          appOpenAd = ad;
          appOpenAd?.show();
        },
        onAdFailedToLoad: (err) {},
      ),
      orientation: AppOpenAd.orientationPortrait
  );
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  FacebookAudienceNetwork.init(
    testingId: "37b1da9d-b48c-4103-a393-2e095e734bd6",
    // iOSAdvertiserTrackingEnabled: true //default false
  );

  initConfig().whenComplete(() {
    configData.value = json.decode(remoteConfig.getString('Ad'));
    initAppOpenAd();
    print('remoteConfig ->  ${configData}');
    SplashScreenController controller = Get.put(SplashScreenController());
  });

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
