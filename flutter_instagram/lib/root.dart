import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clone_instagram/src/app.dart';
import 'package:flutter_clone_instagram/src/contoller/auth_controller.dart';
import 'package:flutter_clone_instagram/src/model/instagram_user_model.dart';
import 'package:flutter_clone_instagram/src/pages/login.dart';
import 'package:flutter_clone_instagram/src/pages/sign_up.dart';
import 'package:get/get.dart';

class Root extends GetView<AuthController> {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext _, AsyncSnapshot<User?> user) {
          if (user.hasData) {
            return FutureBuilder<IUser?>(
              future: controller.loginUser(user.data!.uid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const App();
                } else {
                  return Obx(
                    () => controller.user.value.uid != null
                        ? const Login()
                        : SignUp(uid: user.data!.uid),
                  );
                }
              },
            );
          } else {
            return const App();
          }
        });
  }
}
