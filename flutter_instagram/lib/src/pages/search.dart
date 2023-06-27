import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clone_instagram/src/pages/search/search_focus.dart';
import 'package:get/get.dart';
import 'package:quiver/iterables.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<List<int>> groupBox = [[], [], []];
  List<int> groupIndex = [0, 0, 0];

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < 100; i++) {
      var size = 1;
      // var gridIndex = i % 3;
      var gi = groupIndex.indexOf(min<int>(groupIndex)!);
      if (gi != 1) {
        size = Random().nextInt(100) % 2 == 0 ? 1 : 2;
      }
      groupBox[gi].add(size);
      groupIndex[gi] += size;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _appbar(),
            Expanded(
              child: _body(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _appbar() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              // Get.to(SearchFocus());
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchFocus()));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 10,
              ),
              margin: const EdgeInsets.only(
                left: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: const Color(0xffefefef),
              ),
              child: Row(
                children: const [
                  Icon(Icons.search),
                  Text(
                    '검색',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xff838383),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(15.0),
          child: Icon(Icons.location_pin),
        ),
      ],
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: List.generate(
          groupBox.length,
          (indexI) => Expanded(
            child: Column(
              children: List.generate(
                groupBox[indexI].length,
                (indexJ) => Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: Colors.primaries[
                          Random().nextInt(Colors.primaries.length)]),
                  height: Get.width * 0.33 * groupBox[indexI][indexJ],
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://img.freepik.com/premium-photo/astronaut-outer-open-space-planet-earth-stars-provide-background-erforming-space-planet-earth-sunrise-sunset-our-home-iss-elements-this-image-furnished-by-nasa_150455-16829.jpg?w=2000',
                    fit: BoxFit.cover,
                  ),
                ),
              ).toList(),

              // children: [
              //   Container(
              //     height: Get.width * 0.33,
              //     color: Colors.red,
              //   ),
              // ],
            ),
          ),
        ).toList(),
        // children: [
        //   Expanded(
        //     child: Column(
        //       children: [
        //         Container(
        //           height: 140,
        //           color: Colors.red,
        //         )
        //       ],
        //     ),
        //   ),
        //   Expanded(
        //     child: Column(
        //       children: [
        //         Container(
        //           height: 140,
        //           color: Colors.blue,
        //         )
        //       ],
        //     ),
        //   ),
        //   Expanded(
        //     child: Column(
        //       children: [
        //         Container(
        //           height: 140,
        //           color: Colors.grey,
        //         )
        //       ],
        //     ),
        //   ),
        // ],
      ),
    );
  }
}
