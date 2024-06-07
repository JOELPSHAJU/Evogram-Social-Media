import 'package:evogram/infrastructure/fetchuserpost/fetching_user_post_bloc.dart';

import 'package:evogram/presentation/settings_screen/settings_screen.dart';
import 'package:evogram/presentation/userprofile/profile_screen/widgets/debouncer.dart';
import 'package:evogram/presentation/userprofile/profile_screen/widgets/example.dart';
import 'package:evogram/presentation/userprofile/profile_screen/widgets/grid.dart';
import 'package:evogram/presentation/userprofile/profile_screen/widgets/profile_header.dart';
import 'package:evogram/presentation/widgets/custom_navigators.dart';
import 'package:evogram/presentation/widgets/text_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../core/constants.dart';

import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final String mainImages =
      'https://www.motortrend.com/uploads/sites/25/2019/05/2019-Petersen-Japanse-Car-Cruise-In-x-SS-Meet-Fast-and-Furious-Eclipse.jpg?w=768&width=768&q=75&format=webp';

  final coverpic =
      'https://di-uploads-pod47.dealerinspire.com/subaruofglendale/uploads/2023/11/2023-subaru-wrx-rally.jpg';

  final profilepic =
      'https://yt3.googleusercontent.com/0P0WUIUvlJ2KfaoTeDy5Xm-14u7m-7NJLy_2wa1pjBoxjHFuMqt7tMWWuZ93lETK-CYKTt4O=s900-c-k-c0x00ffffff-no-rj';

  @override
  void initState() {
    context.read<FetchingUserPostBloc>().add(FetchingUserpostInitialEvent());
    super.initState();
  }

  final Debouncer debouncer = Debouncer(milliseconds: 500);
  Future<void> fetchDataProfileWithDebounce() async {
    await debouncer.run(() async {
      context.read<FetchingUserPostBloc>().add(FetchingUserpostInitialEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        extendBody: true,
        appBar: AppBar(
          backgroundColor:
              Theme.of(context).brightness == Brightness.light ? white : black,
          surfaceTintColor:
              Theme.of(context).brightness == Brightness.light ? white : black,
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
                          : const Color.fromARGB(255, 20, 20, 20),
                      child: TabBar(
                          dividerColor: blueaccent3,
                          unselectedLabelColor: grey,
                          labelColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? black
                                  : white,
                          indicatorColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? black
                                  : white,
                          tabs: const [
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
                        child: TabBarView(children: [
                      BlocConsumer<FetchingUserPostBloc, FetchingUserPostState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state is FetchUserPostLoadingState) {
                            return Center(
                                child: LoadingAnimationWidget.fourRotatingDots(
                                    color: blueaccent2, size: 40));
                          } else if (state is FetchUserPostSuccessState) {
                            return GridviewProfile(
                              state: state,
                            );
                          }
                          return Center(
                            child:
                                Theme.of(context).brightness == Brightness.light
                                    ? Image.asset(
                                        nopostblack,
                                        color: black,
                                        width: size.width * .4,
                                      )
                                    : Image.asset(nopostwht,
                                        width: size.width * .5),
                          );
                        },
                      ),
                      GridviewProfileExample()
                    ]))
                  ],
                ))));
  }
}
