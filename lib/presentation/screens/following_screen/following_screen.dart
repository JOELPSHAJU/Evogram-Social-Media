import 'package:evogram/domain/models/followings_model.dart';
import 'package:evogram/presentation/bloc/fetch_followers/fetch_followers_bloc.dart';
import 'package:evogram/presentation/bloc/follow_unfollow_user_bloc/follow_unfollow_user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/core/constants.dart';
import '../chat_screen/chat_screen.dart';
import '../chat_list/widgets.dart';

import '../widgets/text_styles.dart';
import 'package:flutter/material.dart';

class FollowingPersonScreen extends StatefulWidget {
  final List<Following> following;
  final FollowingModel model;
  FollowingPersonScreen(
      {super.key, required this.following, required this.model});

  @override
  State<FollowingPersonScreen> createState() => _FollowingPersonScreenState();
}

class _FollowingPersonScreenState extends State<FollowingPersonScreen> {
  final profilepic =
      'https://www.mensjournal.com/.image/t_share/MTk2MTM2NDk0NzM0MjU1MjQ5/jason-statham-main.jpg';

  final searchPersonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: grey,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        automaticallyImplyLeading: false,
        title: appbarTitle(title: 'Following'),
        // bottom: PreferredSize(
        //   preferredSize: Size(size.width, 50),
        //   child: Padding(
        //     padding: const EdgeInsets.only(left: 15.0, right: 15),
        //     child: Column(
        //       children: [
        //         TextFormFieldChatPage(
        //             controller: searchPersonController,
        //             hintText: 'Search..',
        //             keyboard: TextInputType.name),
        //         h10
        //       ],
        //     ),
        //   ),
        // ),
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ListView.builder(
            itemCount: widget.following.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const ChatScreen(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              const begin = Offset(0.0, 1.0);
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
                    child: ListTile(
                      leading: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(
                                image: NetworkImage(widget
                                    .following[index].profilePic
                                    .toString()),
                                fit: BoxFit.cover)),
                      ),
                      title: Text(
                        widget.following[index].userName.toString(),
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        widget.following[index].name.toString(),
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      trailing: MaterialButton(
                          minWidth: 80,
                          height: 27,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: const BorderSide(color: buttonclr)),
                          onPressed: () {
                            context.read<FollowUnfollowUserBloc>().add(
                                UnFollowUserButtonClickEvent(
                                    followeesId:
                                        widget.following[index].id.toString()));
                            setState(() {
                              widget.following.removeWhere((element) =>
                                  element.id == widget.following[index].id);
                            });
                            widget.model.totalCount--;
                            context.read<FetchFollowersBloc>();
                          },
                          child: const Text('Unfollow',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: buttonclr,
                                  fontSize: 13))),
                    ),
                  ));
            },
          ),
        ),
      ),
    );
  }
}
