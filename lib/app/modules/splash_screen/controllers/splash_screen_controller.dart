import 'dart:convert';

import 'package:dummy_ad_flutter/app/modules/first_screen/views/first_screen_view.dart';
import 'package:dummy_ad_flutter/main.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  //TODO: Implement SplashScreenController

  final count = 0.obs;



  @override
  void onInit() {
    super.onInit();
    print('Splash screen oninit');
    configData.value != {}
        ? Future.delayed(Duration(seconds: 3), () {Get.off(FirstScreenView());})
        : initConfig().whenComplete(() {
      configData.value = json.decode(remoteConfig.getString('Ad'));
      initAppOpenAd();
      print('remoteConfig 2->  ${configData}');
    });
  }

  @override
  void onReady() {
    super.onReady();

  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
