import 'package:evogram/presentation/add_post/add_post.dart';
import 'package:evogram/presentation/chat_list/chat_list.dart';
import 'package:evogram/presentation/discover_screen/discover_screen.dart';
import 'package:evogram/presentation/userprofile/profile_screen/profile_screen.dart';
import 'package:evogram/core/constants.dart';
import 'package:evogram/presentation/home_screen/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';

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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color:
              Theme.of(context).brightness == Brightness.light ? white : black,
          border: Border.symmetric(
              horizontal: BorderSide(
            color:
                Theme.of(context).brightness == Brightness.light ? grey : black,
          )),
        ),
        height: 62,
        child: FlashyTabBar(
          backgroundColor:
              Theme.of(context).brightness == Brightness.light ? white : black,
          selectedIndex: currentPage.value,
          showElevation: true,
          onItemSelected: (index) {
            setState(() {
              currentPage.value = index;
            });
          },
          items: [
            FlashyTabBarItem(
              inactiveColor: grey,
              activeColor: Theme.of(context).brightness == Brightness.light
                  ? black
                  : white,
              icon: const Icon(
                CupertinoIcons.home,
                size: 28,
              ),
              title: const Text("Home"),
            ),
            FlashyTabBarItem(
              inactiveColor: grey,
              activeColor: Theme.of(context).brightness == Brightness.light
                  ? black
                  : white,
              icon: const Icon(
                CupertinoIcons.search,
                size: 28,
              ),
              title: const Text("Discover"),
            ),
            FlashyTabBarItem(
              inactiveColor: grey,
              activeColor: Theme.of(context).brightness == Brightness.light
                  ? black
                  : white,
              icon: const Icon(
                CupertinoIcons.add_circled,
                size: 28,
              ),
              title: const Text("Add Post"),
            ),
            FlashyTabBarItem(
              inactiveColor: grey,
              activeColor: Theme.of(context).brightness == Brightness.light
                  ? black
                  : white,
              icon: const Icon(
                CupertinoIcons.chat_bubble,
                size: 28,
              ),
              title: const Text("Chat"),
            ),
            FlashyTabBarItem(
              inactiveColor: grey,
              activeColor: Theme.of(context).brightness == Brightness.light
                  ? black
                  : white,
              icon: const Icon(
                Icons.person,
                size: 28,
              ),
              title: const Text("Account"),
            ),
          ],
        ),
      ),
    );
  }
}
