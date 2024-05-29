import '../specific_post/specific_post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// ignore: must_be_immutable
class ExploreScreen extends StatelessWidget {
  ExploreScreen({super.key});
  late List<String> mainImages = [
    'https://www.motortrend.com/uploads/sites/25/2019/05/2019-Petersen-Japanse-Car-Cruise-In-x-SS-Meet-Fast-and-Furious-Eclipse.jpg?w=768&width=768&q=75&format=webp',
    'https://live.staticflickr.com/8255/8750940484_ddbfee1410_b.jpg',
    'https://mir-s3-cdn-cf.behance.net/project_modules/fs/abd02a98993327.5ee8e3a24669e.jpg',
    'https://s.itl.cat/pngfile/s/163-1635626_10-latest-cool-dragons-wallpaper-3d-full-hd.jpg',
    'https://a-static.besthdwallpaper.com/oppenheimer-movie-poster-wallpaper-3200x2400-120063_29.jpg',
    'https://www.hdwallpapers.in/download/marvel_deadpool_movie-wide.jpg',
    'https://i.redd.it/my-favourite-game-of-thrones-wallpapers-v0-1bmnreua3zx91.jpg?width=2448&format=pjpg&auto=webp&s=c295ee0c2ab6a9b9dfd09a5a9d7ad6d9b99baf20',
    'https://4kwallpapers.com/images/wallpapers/fast-furious-9-vin-diesel-jordana-brewster-ludacris-2048x2048-561.jpg',
    'https://static1.moviewebimages.com/wordpress/wp-content/uploads/article/Ybqs2RxTrf0vkMuDCPdm34stmtHmuz.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 10),
      child: MasonryGridView.builder(
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemCount: 20,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        SpecificPostScreen(
                      mainimage: mainImages[index],
                    ),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.ease;
                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));

                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                  ));
            },
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Image.network(mainImages[index % mainImages.length]),
            ),
          );
        },
      ),
    );
  }
}
