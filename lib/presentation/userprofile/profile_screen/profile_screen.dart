import 'package:evogram/presentation/userprofile/profile_screen/widgets/grid.dart';
import 'package:evogram/presentation/userprofile/profile_screen/widgets/profile_header.dart';
import 'package:evogram/presentation/widgets/custom_navigators.dart';

import '../../../core/constants.dart';

import '../../settings_screen/settings_screen.dart';

import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
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
                  navigatePushAnimaterighttoleft(
                      context, const SettingsScreen());
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
                body: Column(
                  children: [
                    Material(
                      color: Theme.of(context).brightness == Brightness.light
                          ? white
                          : black,
                      child: const TabBar(
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
