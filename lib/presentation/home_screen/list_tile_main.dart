import '../../core/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListTileMainScreen extends StatelessWidget {
  const ListTileMainScreen({
    super.key,
    required this.size,
    required this.mainimage,
    required this.profileimage,
    required this.likedpersonname,
    required this.date,
    required this.description,
    required this.account,
  });
  final String mainimage;
  final String profileimage;
  final String likedpersonname;
  final String date;
  final String description;
  final Size size;
  final String account;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(profileimage), fit: BoxFit.cover),
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
                          fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    const Text(
                      '2d',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Image.asset(
                        likeborderlogo,
                        width: 30,
                      ),
                    ),
                    w10,
                    GestureDetector(
                      onTap: () {},
                      child: Image.asset(
                        commentborderlogo,
                        width: 30,
                      ),
                    ),
                    w10,
                    GestureDetector(
                      onTap: () {},
                      child: Image.asset(
                        shareborderlogo,
                        width: 30,
                      ),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {},
                  child: Image.asset(
                    savedborderlogo,
                    width: 30,
                  ),
                )
              ],
            ),
          ),
          RichText(
            text: TextSpan(
                text: 'Liked by',
                style: GoogleFonts.inter(fontSize: 15, color: black),
                children: <TextSpan>[
                  TextSpan(
                    text: ' $likedpersonname ',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: 'and others',
                    style: GoogleFonts.inter(fontSize: 15, color: black),
                  ),
                ]),
          ),
          Text(
            date,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          h10,
          Text(
            description,
            maxLines: 3,
            style: const TextStyle(overflow: TextOverflow.ellipsis),
          ),
          h10
        ],
      ),
    );
  }
}
