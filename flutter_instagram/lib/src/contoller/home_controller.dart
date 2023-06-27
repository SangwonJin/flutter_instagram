import 'package:flutter_clone_instagram/src/model/post.dart';
import 'package:flutter_clone_instagram/src/repo/post_repo.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomeController extends GetxController {
  RxList<Post> postList = <Post>[].obs;
  @override
  void onInit() {
    super.onInit();
    _loadFeedList();
  }

  void _loadFeedList() async {
    List<Post> feedList = await PostRepository.loadFeedList();
    postList.addAll(feedList);
  }
}
