import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clone_instagram/src/components/message_popup.dart';
import 'package:flutter_clone_instagram/src/contoller/auth_controller.dart';
import 'package:flutter_clone_instagram/src/model/post.dart';
import 'package:flutter_clone_instagram/src/pages/upload/upload_description.dart';
import 'package:flutter_clone_instagram/src/repo/post_repo.dart';
import 'package:flutter_clone_instagram/src/utils/data_utils.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photofilters/photofilters.dart';
import 'package:image/image.dart' as imageLib;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class UploadController extends GetxController {
  var albums = <AssetPathEntity>[];
  RxString headerTitle = 'Recent'.obs;
  RxList<AssetEntity> imageList = <AssetEntity>[].obs;
  TextEditingController textEditingController = TextEditingController();
  Rx<AssetEntity> selectedImage = const AssetEntity(
    id: '0',
    typeInt: 0,
    width: 0,
    height: 0,
  ).obs;
  File? filteredImage;
  Post? post;

  @override
  void onInit() {
    super.onInit();
    post = Post.init(AuthController.to.user.value);
    _loadPhotos();
  }

  void _loadPhotos() async {
    var result = await PhotoManager.requestPermissionExtend();
    if (result.isAuth) {
      albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        filterOption: FilterOptionGroup(
          imageOption: const FilterOption(
            sizeConstraint: SizeConstraint(minHeight: 100, minWidth: 100),
          ),
          orders: [
            const OrderOption(
              type: OrderOptionType.createDate,
              asc: false,
            ),
          ],
        ),
      );

      _loadData();
    } else {}
  }

  void _loadData() async {
    if (albums.isNotEmpty) {
      changeAlbums(albums.first);
    }
  }

  Future<void> _pagingPhotos(AssetPathEntity album) async {
    imageList.clear();
    var photos = await album.getAssetListPaged(page: 0, size: 30);
    if (photos.isEmpty) {
      return;
    }

    imageList.addAll(photos);
    changeSelectedImage(imageList.first);
  }

  changeSelectedImage(AssetEntity image) {
    selectedImage(image);
  }

  void changeAlbums(AssetPathEntity album) async {
    headerTitle(album.name);
    await _pagingPhotos(album);
    //Get.back();
  }

  void gotoImageFilter() async {
    var file = await selectedImage.value.file;
    var fileName = basename(file!.path);

    var image = imageLib.decodeImage(file.readAsBytesSync());
    image = imageLib.copyResize(image!, width: 600);
    Map imagefile = await Navigator.push(
      Get.context!,
      MaterialPageRoute(
        builder: (context) => PhotoFilterSelector(
          title: const Text("Photo Filter Example"),
          image: image!,
          filters: presetFiltersList,
          filename: fileName,
          loader: const Center(child: CircularProgressIndicator()),
          fit: BoxFit.contain,
        ),
      ),
    );
    if (imagefile != null && imagefile.containsKey('image_filtered')) {
      filteredImage = imagefile['image_filtered'];
      Get.to(() => const UploadDescription());
    }
  }

  void unfocusKeyBoard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void uploadPost() {
    unfocusKeyBoard();
    String userId = AuthController.to.user.value.uid!;
    String fileUid = DataUtil.makeFilePath();
    var task = uploadXFile(filteredImage!, '$userId/$fileUid');
    if (task != null) {
      task.snapshotEvents.listen((event) async {
        if (event.bytesTransferred == event.totalBytes &&
            event.state == TaskState.success) {
          var downloadUrl = await event.ref.getDownloadURL();
          var updatedPost = post!.copyWith(
            thumbnail: downloadUrl,
            description: textEditingController.text,
          );

          _submit(updatedPost);
        }
      });
    }
  }

  UploadTask uploadXFile(File file, String fileName) {
    var ref = FirebaseStorage.instance.ref().child('instagram').child(fileName);
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path},
    );

    return ref.putFile(file, metadata);
  }

  void _submit(Post updatedPost) async {
    await PostRepository.updatePost(updatedPost);
    showDialog(
      context: Get.context!,
      builder: (context) => MessagePopUp(
          title: '포스트',
          message: '포스팅이 완료되었습니다.',
          okCallback: () {
            Get.until((route) => Get.currentRoute == '/');
          }),
    );
  }
}
