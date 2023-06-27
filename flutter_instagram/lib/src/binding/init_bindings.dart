import 'package:flutter_clone_instagram/src/contoller/auth_controller.dart';
import 'package:flutter_clone_instagram/src/contoller/bottom_nav_controller.dart';
import 'package:flutter_clone_instagram/src/contoller/home_controller.dart';
import 'package:flutter_clone_instagram/src/contoller/my_page_controller.dart';
import 'package:flutter_clone_instagram/src/contoller/upload_controller.dart';
import 'package:get/instance_manager.dart';

class InitBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
  }

  static additionalBinding() {
    Get.put(BottomNavController(), permanent: true);
    Get.put(MyPageController(), permanent: true);
    Get.put(HomeController(), permanent: true);
  }
}
