import '../../../application/core/constants.dart';
import '../chat_screen/chat_screen.dart';
import '../chat_list/widgets.dart';

import '../widgets/text_styles.dart';

import 'package:flutter/material.dart';

class FollowersScreen extends StatelessWidget {
  FollowersScreen({super.key});
  final profilepic =
      'https://i.redd.it/rate-actress-michelle-rodriguez-had-roles-in-avatar-fast-v0-5ajp4kyc4iva1.jpg?width=2527&format=pjpg&auto=webp&s=e0e15527167cf143508acc91e2d25d021e6e24f8';
  final searchPersonController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
        automaticallyImplyLeading: false,
        title: appbarTitle(title: 'Followers'),
        bottom: PreferredSize(
          preferredSize: Size(size.width, 50),
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: Column(
              children: [
                TextFormFieldChatPage(
                    controller: searchPersonController,
                    hintText: 'Search..',
                    keyboard: TextInputType.name),
                h10,
              ],
            ),
          ),
        ),
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ListView.builder(
            itemCount: 20,
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
                                image: NetworkImage(profilepic),
                                fit: BoxFit.cover)),
                      ),
                      title: const Text(
                        'Michele Rodrigues',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text(
                        'michele_rodrigues_here',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      trailing: MaterialButton(
                          minWidth: 80,
                          height: 27,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: const BorderSide(color: blueaccent2)),
                          onPressed: () {},
                          child: const Text('Follow back',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: blueaccent2,
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
