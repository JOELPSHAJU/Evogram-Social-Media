import 'package:evogram/domain/models/followers_model.dart';
import 'package:evogram/domain/models/searchusermodel.dart';
import 'package:evogram/presentation/screens/discover_screen/widgets/post_details/userprofile/user_profile_screen.dart';
import 'package:evogram/presentation/screens/widgets/custom_navigators.dart';

import '../../../application/core/constants.dart';

import '../widgets/text_styles.dart';

import 'package:flutter/material.dart';

class FollowersScreen extends StatelessWidget {
  final List<Follower> followers;
  FollowersScreen({super.key, required this.followers});
  final searchPersonController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        shadowColor: grey,
        elevation: 1,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
        automaticallyImplyLeading: false,
        title: appbarTitle(title: 'Followers'),
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
        //         h10,
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
            itemCount: followers.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(
                              image: NetworkImage(followers[index].profilePic),
                              fit: BoxFit.cover)),
                    ),
                    title: GestureDetector(
                      onTap: () {
                        final user = UserIdSearchModel(
                            id: followers[index].id.toString(),
                            userName: followers[index].userName.toString(),
                            email: followers[index].email.toString(),
                            profilePic: followers[index].profilePic.toString(),
                            online: followers[index].online,
                            blocked: followers[index].blocked,
                            verified: followers[index].verified,
                            role: followers[index].role.toString(),
                            isPrivate: followers[index].isPrivate,
                            backGroundImage:
                                followers[index].backGroundImage.toString(),
                            createdAt: followers[index].createdAt,
                            updatedAt: followers[index].updatedAt,
                            v: followers[index].v);
                        navigatePushAnimaterighttoleft(
                            context,
                            UserProfileScreen(
                                userId: followers[index].id.toString(),
                                user: user));
                      },
                      child: Text(
                        followers[index].userName.toString(),
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    subtitle: Text(
                      followers[index].name.toString(),
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    // trailing: MaterialButton(
                    //     minWidth: 80,
                    //     height: 27,
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(5),
                    //         side: const BorderSide(color: blueaccent2)),
                    //     onPressed: () {},
                    //     child: const Text('Follow back',
                    //         style: TextStyle(
                    //             fontWeight: FontWeight.bold,
                    //             color: blueaccent2,
                    //             fontSize: 13))),
                  ));
            },
          ),
        ),
      ),
    );
  }
}
