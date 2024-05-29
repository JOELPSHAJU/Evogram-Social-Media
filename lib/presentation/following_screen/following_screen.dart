import '../../core/constants.dart';
import '../chat_screen/chat_screen.dart';
import '../chat_list/widgets.dart';

import '../widgets/text_styles.dart';
import 'package:flutter/material.dart';

class FollowingPersonScreen extends StatelessWidget {
  FollowingPersonScreen({super.key});
  final profilepic =
      'https://www.mensjournal.com/.image/t_share/MTk2MTM2NDk0NzM0MjU1MjQ5/jason-statham-main.jpg';

  final searchPersonController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        surfaceTintColor: white,
        backgroundColor: white,
        automaticallyImplyLeading: false,
        title: appbarTitle(title: 'Following'),
        bottom: PreferredSize(
          preferredSize: Size(size.width, 50),
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: TextFormFieldChatPage(
                controller: searchPersonController,
                hintText: 'Search..',
                keyboard: TextInputType.name),
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
                        'Decard Shaw',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text(
                        'decard_shaw',
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
                          child: const Text('Unfollow',
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
