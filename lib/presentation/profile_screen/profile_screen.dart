import 'package:evogram/presentation/profile_screen/widgets/grid.dart';
import 'package:evogram/presentation/profile_screen/widgets/profile_header.dart';

import '../../core/constants.dart';

import '../settings_screen/settings_screen.dart';

import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final String mainImages =
      'https://www.motortrend.com/uploads/sites/25/2019/05/2019-Petersen-Japanse-Car-Cruise-In-x-SS-Meet-Fast-and-Furious-Eclipse.jpg?w=768&width=768&q=75&format=webp';
  final coverpic =
      'https://di-uploads-pod47.dealerinspire.com/subaruofglendale/uploads/2023/11/2023-subaru-wrx-rally.jpg';
  final profilepic =
      'https://yt3.googleusercontent.com/0P0WUIUvlJ2KfaoTeDy5Xm-14u7m-7NJLy_2wa1pjBoxjHFuMqt7tMWWuZ93lETK-CYKTt4O=s900-c-k-c0x00ffffff-no-rj';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        extendBody: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 50,
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'its_ken_block',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const SettingsScreen(),
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
                icon: const Icon(
                  Icons.more_vert,
                ))
          ],
        ),
        body: DefaultTabController(
            length: 2,
            child: NestedScrollView(
                headerSliverBuilder: (context, _) {
                  return [
                    SliverList(
                        delegate: SliverChildListDelegate([
                      profileHeaderWidgets(context, size, coverpic, profilepic)
                    ]))
                  ];
                },
                body: const Column(
                  children: [
                    Material(
                      child: TabBar(
                          dividerColor: blueaccent3,
                          unselectedLabelColor: grey,
                          labelColor: blueaccent2,
                          indicatorColor: blueaccent2,
                          tabs: [
                            Tab(
                              icon: Icon(
                                Icons.grid_on_sharp,
                                size: 30,
                              ),
                            ),
                            Tab(
                              icon: Icon(
                                Icons.save_outlined,
                                size: 30,
                              ),
                            )
                          ]),
                    ),
                    Expanded(
                        child: TabBarView(
                            children: [GridviewProfile(), GridviewProfile()]))
                  ],
                ))));
  }
}
