// ignore_for_file: use_build_context_synchronously

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:evogram/domain/models/conversation_model.dart';
import 'package:evogram/domain/models/get_user_model.dart';
import 'package:evogram/presentation/bloc/add_message/add_message_bloc.dart';
import 'package:evogram/presentation/bloc/fetch_all_conversations_bloc.dart/fetch_all_conversations_bloc.dart';
import 'package:evogram/presentation/screens/chat_list/custom_card.dart';
import 'package:evogram/presentation/screens/chat_list/message_screen_loading.dart';
import 'package:evogram/presentation/screens/suggessions_screen/suggession_screen.dart';
import 'package:evogram/presentation/screens/widgets/custom_navigators.dart';
import 'package:evogram/presentation/screens/widgets/custom_profile_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:multi_bloc_builder/builders/multi_bloc_builder.dart';

import '../../../application/core/constants.dart';
import '../chat_screen/chat_screen.dart';
import '../widgets/text_styles.dart';
import 'new_chat/new_chat.dart';

class FindChatPersonScreen extends StatefulWidget {
  const FindChatPersonScreen({super.key});

  @override
  State<FindChatPersonScreen> createState() => _FindChatPersonScreenState();
}

class _FindChatPersonScreenState extends State<FindChatPersonScreen> {
  final profilepic =
      'https://yt3.googleusercontent.com/0P0WUIUvlJ2KfaoTeDy5Xm-14u7m-7NJLy_2wa1pjBoxjHFuMqt7tMWWuZ93lETK-CYKTt4O=s900-c-k-c0x00ffffff-no-rj';

  final searchPersonController = TextEditingController();
  List<ConversationModel> conversations = [];
  List<GetUserModel> users = [];
  List<GetUserModel> filteredUsers = [];
  String? onchanged;

  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context
        .read<FetchAllConversationsBloc>()
        .add(AllConversationsInitialFetchEvent());
  }

  Future<void> refresh() async {
    await Future.delayed(const Duration(seconds: 1));
    context
        .read<FetchAllConversationsBloc>()
        .add(AllConversationsInitialFetchEvent());
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
        elevation: 1,
        shadowColor: Theme.of(context).brightness == Brightness.light
            ? lightgrey
            : darkgrey,
        automaticallyImplyLeading: false,
        title: appbarTitle(title: 'Messages'),
        bottom: PreferredSize(
          preferredSize: Size(size.width, 50),
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: Column(
              children: [
                SearchBar(
                  textStyle: const WidgetStatePropertyAll(TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none)),
                  shadowColor: const WidgetStatePropertyAll(grey80),
                  backgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).brightness == Brightness.light
                        ? grey300
                        : darkbg,
                  ),
                  leading: const Icon(Icons.search),
                  onChanged: (value) {
                    onchanged = value;
                    setState(() {});
                  },
                  controller: searchController,
                  hintText: 'Search...',
                ),
                h10
              ],
            ),
          ),
        ),
      ),
      body: CustomMaterialIndicator(
        indicatorBuilder: (context, controller) {
          return LoadingAnimationWidget.inkDrop(
            color: buttonclr,
            size: 30,
          );
        },
        onRefresh: refresh,
        child: MultiBlocBuilder(
          blocs: [
            context.watch<FetchAllConversationsBloc>(),
            context.watch<AddMessageBloc>(),
          ],
          builder: (context, state) {
            var state1 = state[0];
            if (state1 is FetchAllConversationsLoadingState) {
              return Center(
                child: messageScreenShimmerLoading(context),
              );
            } else if (state1 is FetchAllConversationsSuccesfulState) {
              conversations = state1.conversations;
              users = state1.otherUsers;
              filteredUsers = state1.otherUsers
                  .where(
                      (element) => element.userName.contains(onchanged ?? ''))
                  .toList();
              return filteredUsers.isEmpty
                  ? Center(
                      child: Container(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.grey.shade300
                          : darkgreymain,
                      width: size.width,
                      height: size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/no data found.jpg',
                            width: size.width * .5,
                          ),
                          h10,
                          const Text(
                            'Looks a little quiet around here!',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          h10,
                          const Text(
                            textAlign: TextAlign.center,
                            'Follow some awesome people to chat with them.',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          h20,
                          SizedBox(
                            width: size.width * .55,
                            child: GestureDetector(
                              onTap: () {
                                navigatePushAnimaterighttoleft(
                                    context, const SuggessionScreen());
                              },
                              child: CustomProfileButton(
                                  size: size,
                                  text: 'See some suggession?',
                                  width: size.width * .5),
                            ),
                          ),
                          h40,
                          h10
                        ],
                      ),
                    ))
                  : ListView.builder(
                      itemCount: filteredUsers.length,
                      itemBuilder: (context, index) {
                        final ConversationModel conversation =
                            conversations[index];
                        final user = filteredUsers[index];
                        return Center(
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 500),
                            child: GestureDetector(
                              onTap: () {
                                navigatePushAnimaterbottomtotop(
                                    context,
                                    ChatScreen(
                                      username: user.userName,
                                      recieverid: user.id,
                                      name: user.userName,
                                      profilepic: user.profilePic,
                                      conversationId: conversation.id,
                                    ));
                              },
                              child: CustomCard(
                                user: user,
                                conversation: conversation,
                              ),
                            ),
                          ),
                        );
                      });
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: FloatingActionButton(
          backgroundColor: blueaccent3,
          shape: const CircleBorder(),
          onPressed: () {
            Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const NewChatScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(
                  1.0,
                  0.0,
                );
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
          child: const Icon(
            CupertinoIcons.person_add_solid,
            color: white,
          ),
        ),
      ),
    );
  }
}
