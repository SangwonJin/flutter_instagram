// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_clone_instagram/src/components/message_popUp.dart';
import 'package:flutter_clone_instagram/src/contoller/upload_controller.dart';
import 'package:flutter_clone_instagram/src/pages/upload.dart';
import 'package:get/get.dart';

enum PageName { HOME, SEARCH, UPLOAD, ACTIVITY, MYPAGE }

class BottomNavController extends GetxController {
  static BottomNavController get to => Get.find();
  RxInt pageIndex = 0.obs;
  List<int> bottomHistory = [0];
  GlobalKey<NavigatorState> searchPageNavigationKey =
      GlobalKey<NavigatorState>();
  void changeBottomIndex(int value, {bool hasGesture = true}) {
    var page = PageName.values[value];

    switch (page) {
      case PageName.UPLOAD:
        Get.to(
          () => Upload(),
          binding: BindingsBuilder(
            () {
              Get.put(UploadController());
            },
          ),
        );
        break;
      case PageName.HOME:
      case PageName.SEARCH:
      case PageName.ACTIVITY:
      case PageName.MYPAGE:
        _changePage(value, hasGesture: hasGesture);
        break;
      default:
    }
  }

  void _changePage(int value, {bool hasGesture = true}) {
    pageIndex(value);
    if (!hasGesture) return;
    if (bottomHistory.last != value) {
      bottomHistory.add(value);
    }
    // if (!bottomHistory.contains(value)) {
    //   bottomHistory.remove(value);
    // }
  }

  Future<bool> willPopAction() async {
    if (bottomHistory.length == 1) {
      showDialog(
        context: Get.context!,
        builder: (context) => MessagePopUp(
          title: '시스템',
          message: '종료하시겠습니까?',
          okCallback: () {
            exit(0);
          },
          cancelCallback: Get.back,
        ),
      );
      return true;
    } else {
      var page = PageName.values[bottomHistory.last];
      if (page == PageName.SEARCH) {
        var value = await searchPageNavigationKey.currentState!.maybePop();
        if (value) return false;
      }
      bottomHistory.removeLast();
      var index = bottomHistory.last;
      changeBottomIndex(index, hasGesture: false);

      return false;
    }
  }
}
