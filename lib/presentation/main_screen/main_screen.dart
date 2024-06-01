import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../../core/constants.dart';
import '../add_post/add_post.dart';
import '../discover_screen/discover_screen.dart';
import '../chat_list/chat_list.dart';
import '../home_screen/home_screen.dart';
import '../profile_screen/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final ValueNotifier<int> currentPage = ValueNotifier(0);

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> pages = [
    HomeScreen(),
    const SearchScreen(),
    AddPostScreen(),
    FindChatPersonScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: ValueListenableBuilder<int>(
        valueListenable: currentPage,
        builder: (context, value, child) => IndexedStack(
          index: value,
          children: pages,
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Theme.of(context).brightness == Brightness.light
            ? lightgreyauth
            : black,
        color: Theme.of(context).brightness == Brightness.light
            ? lightgrey
            : black,
        height: 55,
        index: currentPage.value,
        items: const <Widget>[
          Icon(
            CupertinoIcons.home,
            size: 30,
            color: blueaccent3,
          ),
          Icon(
            CupertinoIcons.search,
            size: 30,
            color: blueaccent3,
          ),
          Icon(
            CupertinoIcons.add,
            size: 30,
            color: blueaccent3,
          ),
          Icon(
            CupertinoIcons.chat_bubble_text,
            size: 30,
            color: blueaccent3,
          ),
          Icon(
            CupertinoIcons.person_alt_circle,
            size: 30,
            color: blueaccent3,
          )
        ],
        onTap: (index) {
          currentPage.value = index;
        },
      ),
    );
  }
}
