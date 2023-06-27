import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_clone_instagram/src/contoller/auth_controller.dart';
import 'package:flutter_clone_instagram/src/model/instagram_user_model.dart';
import 'package:image_picker/image_picker.dart';

class SignUp extends StatefulWidget {
  final String uid;

  const SignUp({Key? key, required this.uid}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nickNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? thumbnailXFile;

  void update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          '회원가입',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 30,
            ),
            _avatar(),
            const SizedBox(
              height: 30,
            ),
            _nickName(),
            const SizedBox(
              height: 30,
            ),
            _description()
          ],
        ),
      ),
      bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
          child: ElevatedButton(
            onPressed: () {
              nickNameController.text;
              descriptionController.text;

              var signupUser = IUser(
                uid: widget.uid,
                nickname: nickNameController.text,
                description: descriptionController.text,
              );
              AuthController.to.signup(signupUser, thumbnailXFile);
            },
            child: (const Text('회원가입')),
          )),
    );
  }

  Widget _avatar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: SizedBox(
            width: 100,
            height: 100,
            child: thumbnailXFile != null
                ? Image.file(File(thumbnailXFile!.path))
                : Image.asset(
                    'assets/images/default_image.png',
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        ElevatedButton(
          onPressed: () async {
            thumbnailXFile = await _picker.pickImage(
                source: ImageSource.gallery, imageQuality: 100);
            update();
          },
          child: const Text('이미지 변경'),
        ),
      ],
    );
  }

  Widget _nickName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        controller: nickNameController,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(10),
          hintText: '닉네임',
        ),
      ),
    );
  }

  Widget _description() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        controller: descriptionController,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(10),
          hintText: '설명',
        ),
      ),
    );
  }
}
