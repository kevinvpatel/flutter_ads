import 'package:dummy_ad_flutter/app/data/AdServices.dart';
import 'package:dummy_ad_flutter/app/modules/first_screen/controllers/first_screen_controller.dart';
import 'package:dummy_ad_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/second_screen_controller.dart';

class SecondScreenView extends GetView<SecondScreenController> {
  const SecondScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    FirstScreenController firstScreenController = Get.put(FirstScreenController());
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    AdService adService = AdService();




    return WillPopScope(
        onWillPop: () {
          Get.back();
          firstScreenController.checkBackCounterAd();
          return Future.value(true);
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('SecondScreenView'),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                adService.nativeAd(width: width),
                // Expanded(
                //     child: ListView.separated(
                //         itemBuilder: (context, index) {
                //           if(index == 4) {
                //             return adService.nativeAd(width: width);
                //           } else {
                //             return Text('Value $index', style: TextStyle(fontSize: 18), textAlign: TextAlign.center);
                //           }
                //         },
                //         separatorBuilder: (context, index) => SizedBox(height: 35),
                //         itemCount: 6
                //     )
                // ),
                FloatingActionButton.extended(
                    onPressed: (){
                      Get.back();
                      firstScreenController.checkBackCounterAd();
                    },
                    label: const Text('    Back    ')
                ),
                SizedBox(height: 25),
                Spacer(),
                Container(
                  child: adService.bannerAd(width: width, data: configData.value[Get.currentRoute]),
                ),
                SizedBox(height: 25),
              ],
            )
          ),
          bottomNavigationBar: adService.bannerAd(width: width, data: configData.value[Get.currentRoute]),
        ),
    );
  }
}
