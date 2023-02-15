import 'package:dummy_ad_flutter/app/data/AdServices.dart';
import 'package:dummy_ad_flutter/app/modules/second_screen/views/second_screen_view.dart';
import 'package:dummy_ad_flutter/app/routes/app_pages.dart';
import 'package:dummy_ad_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../controllers/first_screen_controller.dart';

class FirstScreenView extends GetView<FirstScreenController> {
  const FirstScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    FirstScreenController controller = Get.put(FirstScreenController());
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    AdService adService = AdService();



    return WillPopScope(
        onWillPop: () {
          // controller.checkBackCounterAd();
          return Future.value(true);
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('FirstScreenView'),
            centerTitle: false,
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                adService.nativeAd(width: width),
                adService.nativeAd(width: width),
                // Expanded(
                //   child: ListView.separated(
                //       itemBuilder: (context, index) {
                //         if(index == 3) {
                //           return adService.nativeAd(width: width);
                //         } else {
                //           return Text('Number $index', style: TextStyle(fontSize: 18), textAlign: TextAlign.center);
                //         }
                //       },
                //       separatorBuilder: (context, index) => SizedBox(height: 30),
                //       itemCount: 5
                //   )
                // ),
                FloatingActionButton.extended(
                    onPressed: () {
                      Get.to(SecondScreenView());
                      controller.checkCounterAd(context: context);
                    },
                    label: Text('Next Page')
                ),
                SizedBox(height: 25)
              ]),
          ),
          bottomNavigationBar: adService.bannerAd(width: width, data: configData.value[Get.currentRoute]),
        ),
    );
  }
}
