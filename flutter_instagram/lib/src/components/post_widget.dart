import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clone_instagram/src/components/avatar.widget.dart';
import 'package:flutter_clone_instagram/src/components/image_data.dart';
import 'package:flutter_clone_instagram/src/model/post.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostWidget extends StatelessWidget {
  final Post post;
  const PostWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _header(),
          const SizedBox(
            height: 15,
          ),
          _image(),
          const SizedBox(
            height: 15,
          ),
          _infoCount(),
          const SizedBox(
            width: 5,
          ),
          _infoDescription(),
          const SizedBox(
            width: 5,
          ),
          _replyTextButton(),
          const SizedBox(
            width: 5,
          ),
          _dateAgo(),
        ],
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AvatarWidget(
            type: AvatarType.Type3,
            nickName: post.userInfo!.nickname,
            thumbPath: post.userInfo!.thumbnail,
            size: 40,
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ImageData(
                IconsPath.postMoreIcon,
                width: 30,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _image() {
    return CachedNetworkImage(imageUrl: post.thumbnail!);
  }

  Widget _infoCount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ImageData(
                IconsPath.likeOffIcon,
                width: 65,
              ),
              ImageData(
                IconsPath.replyIcon,
                width: 60,
              ),
              const SizedBox(
                width: 15,
              ),
              ImageData(
                IconsPath.directMessage,
                width: 55,
              ),
            ],
          ),
          const SizedBox(
            width: 15,
          ),
          ImageData(
            IconsPath.bookMarkOffIcon,
            width: 55,
          ),
        ],
      ),
    );
  }

  Widget _infoDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '좋아요 ${post.likeCount ?? 0}개',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          ExpandableText(
            post.description ?? '',
            expandText: '더보기',
            collapseText: '접기',
            prefixText: post.userInfo!.nickname,
            prefixStyle: const TextStyle(fontWeight: FontWeight.bold),
            maxLines: 3,
            expandOnTextTap: true,
            collapseOnTextTap: true,
            onPrefixTap: () {
              print('진상원');
            },
            linkColor: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _replyTextButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: () {},
        child: const Text(
          '댓글 199개 모두 보기',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _dateAgo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        timeago.format(post.createAt!),
        style: const TextStyle(color: Colors.grey, fontSize: 11),
      ),
    );
  }
}
