import 'package:flutter/material.dart';
import 'package:flutter_clone_instagram/src/components/avatar.widget.dart';
import 'package:flutter_clone_instagram/src/components/image_data.dart';
import 'package:flutter_clone_instagram/src/components/post_widget.dart';
import 'package:flutter_clone_instagram/src/contoller/home_controller.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class Home extends GetView<HomeController> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: ImageData(
          IconsPath.logo,
          width: 270,
        ),
        actions: [
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageData(
                IconsPath.directMessage,
                width: 50,
              ),
            ),
            onTap: () {},
          )
        ],
      ),
      body: ListView(
        children: [
          _storyBoardList(),
          _postList(),
        ],
      ),
    );
  }

  Widget _storyBoardList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        const SizedBox(
          width: 20,
        ),
        _myStory(),
        const SizedBox(
          width: 5,
        ),
        ...List.generate(
            100,
            (index) => AvatarWidget(
                  type: AvatarType.Type1,
                  thumbPath:
                      'https://img.freepik.com/premium-photo/astronaut-outer-open-space-planet-earth-stars-provide-background-erforming-space-planet-earth-sunrise-sunset-our-home-iss-elements-this-image-furnished-by-nasa_150455-16829.jpg?w=2000',
                )),
      ]),
    );
  }

  Widget _postList() {
    return Obx(
      () => Column(
        children: List.generate(controller.postList.length,
            (index) => PostWidget(post: controller.postList[index])).toList(),
      ),
    );
  }

  Widget _myStory() {
    return Stack(
      children: [
        AvatarWidget(
          type: AvatarType.Type2,
          thumbPath:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ24sk8gYDCX3n31OUwNA23xkCB7T3Sp1QXDv_RGu11PiY5wzliJczCBaUMhZId4eJPOo&usqp=CAU',
          size: 70,
        ),
        Positioned(
          right: 5,
          bottom: 0,
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
                border: Border.all(
                  width: 2,
                  color: Colors.white,
                )),
            child: const Center(
              child: Text(
                '+',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  height: 1.1,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
