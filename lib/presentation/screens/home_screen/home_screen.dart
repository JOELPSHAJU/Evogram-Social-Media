import '../../../application/core/constants.dart';
import 'list_tile_main.dart';
import '../suggessions_screen/suggession_screen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  late List<String> profileImages = [
    'https://media.cnn.com/api/v1/images/stellar/prod/131130213718-paul-walker.jpg?q=x_17,y_55,h_937,w_1666,c_crop/w_800',
    'https://media.glamour.com/photos/60d117f9d3094557c1d38582/16:9/w_1280,c_limit/Jordana-Brewster-social.jpg',
    'https://hips.hearstapps.com/hmg-prod/images/gettyimages-492532708-copy.jpg',
    'https://i.redd.it/rate-actress-michelle-rodriguez-had-roles-in-avatar-fast-v0-5ajp4kyc4iva1.jpg?width=2527&format=pjpg&auto=webp&s=e0e15527167cf143508acc91e2d25d021e6e24f8',
    'https://www.mensjournal.com/.image/t_share/MTk2MTM2NDk0NzM0MjU1MjQ5/jason-statham-main.jpg'
  ];

  late List<String> mainImages = [
    'https://www.motortrend.com/uploads/sites/25/2019/05/2019-Petersen-Japanse-Car-Cruise-In-x-SS-Meet-Fast-and-Furious-Eclipse.jpg?w=768&width=768&q=75&format=webp',
    'https://live.staticflickr.com/8255/8750940484_ddbfee1410_b.jpg',
    'https://mir-s3-cdn-cf.behance.net/project_modules/fs/abd02a98993327.5ee8e3a24669e.jpg',
    'https://4kwallpapers.com/images/wallpapers/fast-furious-9-vin-diesel-jordana-brewster-ludacris-2048x2048-561.jpg',
    'https://static1.moviewebimages.com/wordpress/wp-content/uploads/article/Ybqs2RxTrf0vkMuDCPdm34stmtHmuz.jpg'
  ];

  final List<String> likedPerson = [
    'Roman Pierce',
    'Tej Parkor',
    'Ramsey Allison',
    'Ken Block',
    'Luke Hobbs'
  ];
  final List<String> date = [
    'May 15',
    ' May 16',
    'May 26',
    'June 10',
    'June 12'
  ];
  final List<String> description = [
    'Thinking about a knockout audio system for your car? Not sure what you need, want, or can afford? Car Audio For Dummies is a great place to find some answers! But wait — what if speakers that vibrate your floorboards',
    'This is a must-have for anyone interested in achieving better performance through car modification!So you want to turn your Yugo into a Viper? Sorry--you need a certified magician. But if you want to turn your sedate',
    'A practical guide that gets you geared up with proper riding techniques, safety gear, indispensable items for long trips, and handling characteristics of various motorcycle types Few activities offer more fun and',
    'Auto Repair For Dummies, 2nd Edition (9781119543619) was previously published as Auto Repair For Dummies, 2nd Edition (9780764599026). While this version features a new Dummies cover and design, the',
    'Drive into the 21st century in an electric car With falling cost of ownership, expanded incentives for purchasing, and more model and body type options than ever, it may finally be time to retire the old gas-'
  ];
  final List<String> account = [
    'Paul William Walker',
    'Jordana Breuster',
    'Dominic Toretto',
    'Michele Rodregues',
    'Decard Shaw'
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: lightgrey,
        automaticallyImplyLeading: false,
        title: Theme.of(context).brightness == Brightness.light
            ? Image.asset(
                logoletters,
                width: size.width * .2,
              )
            : Image.asset(
                logoletterswhite,
                width: size.width * .2,
              ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const SuggessionScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(0.0, 1.0);
                  const end = Offset.zero;
                  const curve = Curves.ease;

                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));

                  var offsetAnimation = animation.drive(tween);

                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
              ));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                addperson,
                width: 40,
              ),
            ),
          )
        ],
      ),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTileMainScreen(
                  size: size,
                  account: account[index],
                  mainimage: mainImages[index],
                  profileimage: profileImages[index],
                  likedpersonname: likedPerson[index],
                  date: date[index],
                  description: description[index]),
            );
          }),
    );
  }
}
