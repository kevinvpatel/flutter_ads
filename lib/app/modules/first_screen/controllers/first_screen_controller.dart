import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dummy_ad_flutter/app/data/AdServices.dart';
import 'package:dummy_ad_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class FirstScreenController extends GetxController {
  //TODO: Implement FirstScreenController

  AdService adService = AdService();

  RxInt counter = 1.obs;
  checkCounterAd({required BuildContext context}) {
    print('counterr -> $counter');
    if(counter.value == configData.value['counter']) {

      update();
      counter.value = 1;
      Get.dialog(AlertDialog(
        content: Row(
          children: const [
            CircularProgressIndicator(),
            Spacer(),
            Text('Please Wait...  Counter'),
            Spacer(),
          ],
        ),
      ));
      Future.delayed(const Duration(milliseconds: 1000), () {
        adService.interstitialAd(onAdFailedToLoad: (error) {
          adService.interstitialAdMob = null;
          adService.interstitialAd(
              adId: configData.value['interstitial-admob'],
              onAdFailedToLoad: (LoadAdError ) {
                counter.value = 1;
                Future.delayed(const Duration(milliseconds: 1000), () => Get.back());
              }
          );
        });
      });

    } else {
      counter.value++;
    }
  }


  RxInt backCounter = 1.obs;
  checkBackCounterAd() {
    print('backCounter -> $backCounter');
    if(backCounter.value == configData.value['back_counter']) {
      backCounter.value = 1;
      Get.dialog(AlertDialog(
        content: Row(
          children: const [
            CircularProgressIndicator(),
            Spacer(),
            Text('Please Wait...  Back_counter'),
            Spacer(),
          ],
        ),
      ));
      Future.delayed(const Duration(milliseconds: 1000), () {
        adService.interstitialAd(onAdFailedToLoad: (error) {
          adService.interstitialAdMob = null;
          adService.interstitialAd(
              adId: configData.value['interstitial-admob'],
              onAdFailedToLoad: (LoadAdError ) {
                backCounter.value = 1;
                Future.delayed(const Duration(milliseconds: 1000), () => Get.back());
              },
              isBack: true
          );
        }, isBack: true);
      });
    } else {
      backCounter.value++;
    }
  }


  ConnectivityResult connectionStatus = ConnectivityResult.none;
  final Connectivity connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      Fluttertoast.showToast(msg: 'Couldn\'t check connectivity status : $e');
      return;
    }
    print('connectionStatus stream 22-> $connectionStatus');
    return updateConnectionStatus(result);
  }

  Future<void> updateConnectionStatus(ConnectivityResult result) async {
    connectionStatus = result;
    print('connectionStatus stream -> $connectionStatus');
    Get.dialog(AlertDialog(
      content: Row(
        children: const [
          CircularProgressIndicator(),
          Spacer(),
          Text('connectionStatus.name'),
          Spacer(),
        ],
      ),
    ));
    // if(connectionStatus == ConnectionState.none) {
    //   Get.dialog(AlertDialog(
    //     content: Row(
    //       children: const [
    //         CircularProgressIndicator(),
    //         Spacer(),
    //         Text('connectionStatus.name'),
    //         Spacer(),
    //       ],
    //     ),
    //   ));
    // } else {
    //   Get.back();
    // }

    update();
  }

  RxInt dialogeCounter = 0.obs;

  @override
  void onInit() {
    super.onInit();

    final StreamSubscription<InternetConnectionStatus> listener =
    InternetConnectionChecker().onStatusChange.listen(
          (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
          // Do what you want to do
          if(dialogeCounter.value == 1) {Navigator.pop(Get.overlayContext!);}
            break;
          case InternetConnectionStatus.disconnected:
          // Do what you want to do
            dialogeCounter.value = 1;
            print('InternetConnectionStatus.disconnected -> ${InternetConnectionStatus.disconnected}');
            showDialog(
                context: Get.overlayContext!,
                builder: (context) {
                  return WillPopScope(child: AlertDialog(
                    content: Row(
                      children: const [
                        CircularProgressIndicator(),
                        Spacer(),
                        Text('connectionStatus.name'),
                        Spacer(),
                      ],
                    ),
                  ), onWillPop: () => Future.value(false),);
                }
            );
            break;
        }
      },
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
