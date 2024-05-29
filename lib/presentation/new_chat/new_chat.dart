import '../../core/constants.dart';
import '../chat_screen/chat_screen.dart';
import '../widgets/text_styles.dart';
import 'package:flutter/material.dart';

class NewChatScreen extends StatelessWidget {
  const NewChatScreen({super.key});
  final profilepic =
      'https://media.glamour.com/photos/60d117f9d3094557c1d38582/16:9/w_1280,c_limit/Jordana-Brewster-social.jpg';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        surfaceTintColor: white,
        title: appbarTitle(title: 'New Chat'),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const ChatScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(0.0, 1.0);
                      const end = Offset.zero;
                      const curve = Curves.ease;

                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));

                      var offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                        position: offsetAnimation,
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
                    'Jordana Brewster',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text(
                    'im_jordana',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  trailing: const Text(''),
                ),
              ));
        },
      ),
    );
  }
}
