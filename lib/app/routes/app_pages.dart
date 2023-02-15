import 'package:get/get.dart';

import '../modules/first_screen/bindings/first_screen_binding.dart';
import '../modules/first_screen/views/first_screen_view.dart';
import '../modules/second_screen/bindings/second_screen_binding.dart';
import '../modules/second_screen/views/second_screen_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.FIRST_SCREEN,
      page: () => const FirstScreenView(),
      binding: FirstScreenBinding(),
    ),
    GetPage(
      name: _Paths.SECOND_SCREEN,
      page: () => const SecondScreenView(),
      binding: SecondScreenBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
  ];
}
