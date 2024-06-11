// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class GridviewProfileExample extends StatelessWidget {
  GridviewProfileExample({super.key});

  late List<String> mainImages = [
    'https://www.motortrend.com/uploads/sites/25/2019/05/2019-Petersen-Japanse-Car-Cruise-In-x-SS-Meet-Fast-and-Furious-Eclipse.jpg?w=768&width=768&q=75&format=webp',
    'https://live.staticflickr.com/8255/8750940484_ddbfee1410_b.jpg',
    'https://mir-s3-cdn-cf.behance.net/project_modules/fs/abd02a98993327.5ee8e3a24669e.jpg',
    'https://4kwallpapers.com/images/wallpapers/fast-furious-9-vin-diesel-jordana-brewster-ludacris-2048x2048-561.jpg',
    'https://static1.moviewebimages.com/wordpress/wp-content/uploads/article/Ybqs2RxTrf0vkMuDCPdm34stmtHmuz.jpg'
  ];

  @override
  Widget build(context) {
    return Scaffold(
        body: GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      mainAxisSpacing: .1,
      crossAxisSpacing: .1,
      childAspectRatio: 1 / 1,
      children: List.generate(mainImages.length, (index) {
        return GestureDetector(
          onTap: () {
            // navigatePush(
            //     context,
            //     UserPosts(
            //       index: index,
            //     ));
          },
          child: Card(
            child: GridTile(
              child: Image.network(
                mainImages[index],
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      }),
    ));
  }
}
