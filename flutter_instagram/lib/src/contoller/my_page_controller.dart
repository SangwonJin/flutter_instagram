import 'package:flutter/material.dart';
import 'package:flutter_clone_instagram/src/contoller/auth_controller.dart';
import 'package:flutter_clone_instagram/src/model/instagram_user_model.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class MyPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  Rx<IUser> targetUser = IUser().obs;
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  void setTargetUser() {
    var uid = Get.parameters['targetUid'];
    if (uid == null) {
      targetUser(AuthController.to.user.value);
    } else {
      //상대Uid로 users collection 조회

    }
  }

  void _loadData() {
    setTargetUser();
  }
}
