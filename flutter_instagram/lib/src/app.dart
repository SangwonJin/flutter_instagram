import 'package:flutter/material.dart';
import 'package:flutter_clone_instagram/src/components/image_data.dart';
import 'package:flutter_clone_instagram/src/contoller/bottom_nav_controller.dart';
import 'package:flutter_clone_instagram/src/pages/active_history.dart';
import 'package:flutter_clone_instagram/src/pages/home.dart';
import 'package:flutter_clone_instagram/src/pages/my_page.dart';
import 'package:flutter_clone_instagram/src/pages/search.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class App extends GetView<BottomNavController> {
  const App({Key? key}) : super(key: key);

  // Future<bool> onWillPop() async {
  //   return false;
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: sort_child_properties_last
      child: Obx(
        (() => Scaffold(
              body: IndexedStack(
                index: controller.pageIndex.value,
                children: [
                  const Home(),
                  Navigator(
                    key: controller.searchPageNavigationKey,
                    onGenerateRoute: (settings) {
                      return MaterialPageRoute(
                        builder: (context) => const Search(),
                      );
                    },
                  ),
                  Container(),
                  const ActiveHistory(),
                  const MyPage(),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                currentIndex: controller.pageIndex.value,
                elevation: 0,
                onTap: controller.changeBottomIndex,
                items: [
                  BottomNavigationBarItem(
                      icon: ImageData(IconsPath.homeOff),
                      activeIcon: ImageData(IconsPath.homeOn),
                      label: 'home'),
                  BottomNavigationBarItem(
                      icon: ImageData(IconsPath.searchOff),
                      activeIcon: ImageData(IconsPath.searchOn),
                      label: 'home'),
                  BottomNavigationBarItem(
                    icon: ImageData(IconsPath.uploadIcon),
                    label: 'home',
                  ),
                  BottomNavigationBarItem(
                      icon: ImageData(IconsPath.activeOff),
                      activeIcon: ImageData(IconsPath.activeOn),
                      label: 'home'),
                  BottomNavigationBarItem(
                      icon: Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                      ),
                      label: 'home'),
                ],
              ),
            )),
      ),
      onWillPop: controller.willPopAction,
    );
  }
}
