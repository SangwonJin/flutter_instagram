import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_clone_instagram/src/binding/init_bindings.dart';
import 'package:flutter_clone_instagram/src/model/instagram_user_model.dart';
import 'package:flutter_clone_instagram/src/repo/user_repo.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();
  Rx<IUser> user = IUser().obs;

  Future<IUser?> loginUser(String uid) async {
    //DB조회
    var userData = await UserRepository.loginUserByUid(uid);
    if (userData != null) {
      user(userData);
      InitBindings.additionalBinding();
    }

    return userData!;
  }

  Future<void> signup(IUser signupUser, XFile? thumbnail) async {
    if (thumbnail == null) {
      _submitSignup(signupUser);
    } else {
      var imageExtension = thumbnail.path.split('.').last;
      var task =
          uploadXFile(thumbnail, '${signupUser.uid}/profile.$imageExtension');
      task.snapshotEvents.listen((event) async {
        print(event.bytesTransferred);
        if (event.bytesTransferred == event.totalBytes &&
            event.state == TaskState.success) {
          var downloadUrl = await event.ref.getDownloadURL();
          var updatedUserData = signupUser.copyWith(thumbnail: downloadUrl);
          _submitSignup(updatedUserData);
        }
      });
    }
  }

  void _submitSignup(IUser signupUser) async {
    var result = await UserRepository.signup(signupUser);
    if (result) {
      loginUser(signupUser.uid!);
    }
  }

  UploadTask uploadXFile(XFile thumbnail, String fileName) {
    var file = File(thumbnail.path);
    var ref = FirebaseStorage.instance.ref().child('users').child(fileName);
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path},
    );

    return ref.putFile(file, metadata);
  }
}
