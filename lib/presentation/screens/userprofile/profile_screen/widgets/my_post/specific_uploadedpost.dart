// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:evogram/application/core/constants.dart';
import 'package:evogram/infrastructure/fetchuserpost/fetching_user_post_bloc.dart';
import 'package:evogram/presentation/screens/userprofile/profile_screen/widgets/debouncer.dart';
import 'package:evogram/presentation/screens/userprofile/profile_screen/widgets/my_post/widgets/popupbutton.dart';
import 'package:evogram/presentation/screens/userprofile/profile_screen/widgets/shimmer.dart';
import 'package:evogram/presentation/screens/widgets/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class UserPosts extends StatefulWidget {
  final String userId;
  final int initialindex;
  const UserPosts({
    super.key,
    required this.userId,
    required this.initialindex,
  });

  @override
  State<UserPosts> createState() => _UserPostsState();
}

class _UserPostsState extends State<UserPosts> {
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
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor:
              Theme.of(context).brightness == Brightness.light ? white : black,
          surfaceTintColor:
              Theme.of(context).brightness == Brightness.light ? white : black,
          shape: Border(
              bottom: BorderSide(
                  color: Theme.of(context).brightness == Brightness.light
                      ? lightgreyauth
                      : black,
                  width: 1.5)),
          title: appbarTitle(title: 'My Posts'),
        ),
        body: BlocConsumer<FetchingUserPostBloc, FetchingUserPostState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is FetchUserPostLoadingState) {
              return ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return shimmerWidgetpost(size, context);
                  });
            } else if (state is FetchUserPostSuccessState) {
              return ListView.builder(
                  controller: ScrollController(
                      initialScrollOffset: widget.initialindex * 550),
                  itemCount: state.userposts.length,
                  itemBuilder: (BuildContext context, int index) {
                    String formatDate(String dateStr) {
                      DateTime dateTime = DateTime.parse(dateStr);
                      DateFormat formatter = DateFormat('d MMMM yyyy');
                      return formatter.format(dateTime);
                    }

                    String formattedDate =
                        formatDate('${state.userposts[index].date}');

                    return SizedBox(
                      width: size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          h10,
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: ClipOval(
                                      child: CachedNetworkImage(
                                        imageUrl: state.userposts[index].image
                                            .toString(),
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) {
                                          return LoadingAnimationWidget.flickr(
                                              leftDotColor: blueaccent2,
                                              rightDotColor: blueaccent3,
                                              size: 23);
                                        },
                                      ),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(left: 18.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.userposts[index].userId.userName,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                      ),
                                      Text(
                                        state.userposts[index].createdAt !=
                                                state.userposts[index].updatedAt
                                            ? '${timeago.format(state.userposts[index].updatedAt)} (Edited)'
                                            : timeago.format(state
                                                .userposts[index].createdAt),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            color: grey),
                                      )
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                PopupmenuButtons(
                                    list: state.userposts, index: index)
                              ],
                            ),
                          ),
                          h10,
                          SizedBox(
                              height: size.width * .84,
                              width: size.width,
                              child: CachedNetworkImage(
                                imageUrl:
                                    state.userposts[index].image.toString(),
                                fit: BoxFit.cover,
                                placeholder: (context, url) {
                                  return LoadingAnimationWidget.hexagonDots(
                                      color: blueaccent, size: 30);
                                },
                              )),
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Row(
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
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.chat_bubble_outline_rounded,
                                          size: 25,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: RichText(
                              text: TextSpan(
                                  text: 'Liked by',
                                  style: GoogleFonts.inter(
                                      fontSize: 13,
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? black
                                          : white),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          ' ${state.userposts[index].likes.length} ',
                                      style: GoogleFonts.inter(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                          h10,
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              child: ReadMoreText(
                                state.userposts[index].description.toString(),
                                trimMode: TrimMode.Line,
                                trimLines: 2,
                                colorClickableText: blue,
                                trimCollapsedText: 'more.',
                                style: const TextStyle(fontWeight: FontWeight.w500),
                                lessStyle: const TextStyle(
                                    fontSize: 14,
                                    color: grey,
                                    fontWeight: FontWeight.bold),
                                trimExpandedText: 'show less',
                                moreStyle: const TextStyle(
                                    fontSize: 14,
                                    color: grey,
                                    fontWeight: FontWeight.bold),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              formattedDate,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? grey
                                      : grey),
                            ),
                          ),
                          h20,
                        ],
                      ),
                    );
                  });
            }
            return ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return shimmerWidgetpost(size, context);
                });
          },
        ));
  }
}
