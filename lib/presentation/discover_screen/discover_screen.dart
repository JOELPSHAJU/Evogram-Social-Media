import '../../core/constants.dart';
import 'explore_screen.dart';
import 'find_profile.dart';

import '../widgets/text_styles.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isTaped = true;

  final searchText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? lightgrey
              : black,
          surfaceTintColor: Theme.of(context).brightness == Brightness.light
              ? lightgrey
              : black,
          automaticallyImplyLeading: false,
          title: appbarTitle(title: 'Discover'),
          bottom: PreferredSize(
            preferredSize: Size(size.width, 50),
            child: Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15, bottom: 10),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      value.isEmpty ? isTaped = true : isTaped = false;
                    });
                  },
                  cursorWidth: 2,
                  controller: searchText,
                  cursorColor: Theme.of(context).brightness == Brightness.light
                      ? black
                      : white,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? lightgrey
                                  : black,
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? lightgrey
                                  : black,
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? lightgrey
                                  : black,
                        )),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? lightgrey
                                  : black,
                        )),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? lightgrey
                                  : black,
                        )),
                    prefixIcon: const Icon(
                      Icons.search,
                    ),
                    fillColor: Theme.of(context).brightness == Brightness.light
                        ? lightgrey
                        : darkgreymain,
                    filled: true,
                    hintText: 'Search',
                  ),
                )),
          ),
        ),
        body: Column(
          children: [_isEmpty(searchText.text)],
        ));
  }

  Widget _isEmpty(String value) {
    return isTaped
        ? Expanded(child: ExploreScreen())
        : const Expanded(child: FindProfileScreen());
  }
}
