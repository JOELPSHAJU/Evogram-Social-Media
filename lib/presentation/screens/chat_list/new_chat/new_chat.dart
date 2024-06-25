import 'package:evogram/application/core/constants.dart';
import 'package:evogram/domain/models/followings_model.dart';
import 'package:evogram/presentation/bloc/conversation_bloc/conversation_bloc.dart';
import 'package:evogram/presentation/bloc/fetch_all_conversations_bloc.dart/fetch_all_conversations_bloc.dart';
import 'package:evogram/presentation/bloc/fetch_followers/fetch_followers_bloc.dart';
import 'package:evogram/presentation/bloc/fetch_followings_bloc/fetch_followings_bloc.dart';
import 'package:evogram/presentation/screens/chat_list/new_chat/rich_text.dart';
import 'package:evogram/presentation/screens/chat_screen/chat_screen.dart';
import 'package:evogram/presentation/screens/suggessions_screen/followers_loading.dart';
import 'package:evogram/presentation/screens/userprofile/profile_screen/profile_screen.dart';
import 'package:evogram/presentation/screens/widgets/custom_navigators.dart';
import 'package:evogram/presentation/screens/widgets/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_bloc_builder/builders/multi_bloc_consumer.dart';

class NewChatScreen extends StatefulWidget {
  const NewChatScreen({super.key});

  @override
  State<NewChatScreen> createState() => _NewChatScreenState();
}

class _NewChatScreenState extends State<NewChatScreen> {
  @override
  void initState() {
    context.read<FetchFollowingsBloc>().add(FollowingsInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: Border(
            bottom: BorderSide(
                color: Theme.of(context).brightness == Brightness.light
                    ? Color.fromARGB(255, 211, 210, 210)
                    : black,
                width: 1.5)),
        backgroundColor:
            Theme.of(context).brightness == Brightness.light ? white : black,
        surfaceTintColor:
            Theme.of(context).brightness == Brightness.light ? white : black,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        title: appbarTitle(title: 'New Chat'),
      ),
      body: MultiBlocConsumer(
        blocs: [
          context.watch<FetchFollowingsBloc>(),
          context.watch<ConversationBloc>(),
        ],
        buildWhen: null,
        listener: (context, state) {},
        builder: (context, state) {
          if (state[0] is FetchFollowingsSuccesfulState) {
            final FollowingModel followings = state[0].followingsModel;
            return followings.following.isEmpty
                ? const Center(child: Richtext())
                : ListView.builder(
                    itemCount: followings.totalCount,
                    itemBuilder: (context, index) {
                      final Following following = followings.following[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 500),
                            child: GestureDetector(
                                onTap: () {
                                  context.read<ConversationBloc>().add(
                                          CreateConversationButtonClickEvent(
                                              members: [
                                            loginuserinfo.id,
                                            following.id.toString()
                                          ]));
                                  if (state[1] is ConversationSuccesfulState) {
                                    context
                                        .read<FetchAllConversationsBloc>()
                                        .add(
                                            AllConversationsInitialFetchEvent());
                                    navigatePushAnimaterighttoleft(
                                        context,
                                        ChatScreen(
                                          username:
                                              following.userName.toString(),
                                          recieverid: following.id.toString(),
                                          name: following.userName.toString(),
                                          profilepic:
                                              following.profilePic.toString(),
                                          conversationId:
                                              state[1].conversationId,
                                        ));
                                  }
                                },
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: white,
                                    radius: 28,
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          following.profilePic.toString()),
                                      radius: 26,
                                    ),
                                  ),
                                  title: Text(
                                    following.userName.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  subtitle: Text(
                                    following.name == null
                                        ? 'Guest User'
                                        : following.name.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15),
                                  ),
                                )),
                          ),
                        ),
                      );
                    });
          }
          if (state[0] is FetchFollowersLoadingState) {
            return followersLoading(context);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
