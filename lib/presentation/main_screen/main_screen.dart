
import 'package:evogram/presentation/add_post/add_post.dart';
import 'package:evogram/presentation/chat_list/chat_list.dart';
import 'package:evogram/presentation/discover_screen/discover_screen.dart';

import 'package:evogram/presentation/userprofile/profile_screen/profile_screen.dart';

import '../../../core/constants.dart';

import '../home_screen/home_screen.dart';

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
        bottomNavigationBar: Container(
            decoration: const BoxDecoration(
                border: Border.symmetric(horizontal: BorderSide(color: grey))),
            height: 70,
            child: BottomNavigationBar(
                selectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.bold),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                type: BottomNavigationBarType.fixed,
                backgroundColor: white,
                iconSize: 25.0,
                selectedIconTheme: const IconThemeData(
                  size: 34.0,
                ),
                selectedItemColor: blueaccent3,
                unselectedItemColor: grey,
                selectedFontSize: 14.0,
                unselectedFontSize: 12,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                currentIndex: currentPage.value,
                onTap: (index) {
                  setState(() {
                    currentPage.value = index;
                  });
                },
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.home),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.search),
                    label: "Discover",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.add_circled),
                    label: "Add Post",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.chat_bubble),
                    label: "Chat",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: "Account",
                  ),
                ])));
  }
}
