import '../../core/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SpecificPostScreen extends StatelessWidget {
  const SpecificPostScreen({
    super.key,
    // required this.size,
    required this.mainimage,
    // required this.profileimage,
    // required this.likedpersonname,
    // required this.date,
    // required this.description,
    // required this.account,
  });
  final String mainimage;
  // final String profileimage;
  // final String likedpersonname;
  // final String date;
  // final String description;
  // final Size size;
  // final String account;
  final String profileimage =
      'https://hips.hearstapps.com/hmg-prod/images/gettyimages-492532708-copy.jpg';
  final String account = 'Dominic Toretto';
  // final String mainimage =
  //     'https://s.itl.cat/pngfile/s/163-1635626_10-latest-cool-dragons-wallpaper-3d-full-hd.jpg';
  final String description =
      'This is a must-have for anyone interested in achieving better performance through car modification!So you want to turn your Yugo into a Viper? Sorry--you need a certified magician. But if you want to turn your sedate';
  final String date = 'June 10';
  final String likedpersonname = 'Ramsey Allison';
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
        automaticallyImplyLeading: false,
        shape: const Border(
            bottom: BorderSide(
                color: Color.fromARGB(255, 211, 210, 210), width: 1.5)),
        title: Theme.of(context).brightness == Brightness.light
            ? Image.asset(
                logoletters,
                width: size.width * .2,
              )
            : Image.asset(
                logoletterswhite,
                width: size.width * .2,
              ),
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(profileimage),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(100)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          account,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                        const Text(
                          '2d',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: grey),
                        )
                      ],
                    ),
                  )
                ],
              ),
              h10,
              SizedBox(
                  height: size.width * .84,
                  width: size.width,
                  child: Image.network(
                    mainimage,
                    fit: BoxFit.cover,
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite_outline,
                            size: 25,
                          )),
                      w10,
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.message_outlined,
                            size: 25,
                          )),
                      w10,
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.share,
                            size: 25,
                          )),
                    ],
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.save,
                        size: 25,
                      ))
                ],
              ),
              RichText(
                text: TextSpan(
                    text: 'Liked by',
                    style: GoogleFonts.inter(
                        fontSize: 13,
                        color: Theme.of(context).brightness == Brightness.light
                            ? black
                            : white),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' $likedpersonname ',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: 'and others',
                        style: GoogleFonts.inter(
                            fontSize: 13,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? black
                                    : white),
                      ),
                    ]),
              ),
              h10,
              Text(
                description,
                maxLines: 3,
                style: const TextStyle(overflow: TextOverflow.ellipsis),
              ),
              Text(
                date,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).brightness == Brightness.light
                        ? grey
                        : grey),
              ),
              h10,
            ],
          ),
        ),
      ),
    );
  }
}
