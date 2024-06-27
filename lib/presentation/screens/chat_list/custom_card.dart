import 'package:cached_network_image/cached_network_image.dart';
import 'package:evogram/domain/models/conversation_model.dart';
import 'package:evogram/domain/models/get_user_model.dart';
import 'package:evogram/presentation/screens/userprofile/profile_screen/widgets/my_post/widgets/gridshimmer.dart';
import 'package:evogram/presentation/screens/widgets/profilecircle.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomCard extends StatelessWidget {
  final GetUserModel user;
  final ConversationModel conversation;
  const CustomCard({
    super.key,
    required this.user,
    required this.conversation,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ProfileCircleTile(profilepic: user.profilePic),
      title: Text(
        user.userName,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        conversation.lastMessage ?? "${user.name ?? "Guest User"}",
        style: const TextStyle(fontSize: 15),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      trailing: conversation.lastMessageTime == null
          ? const Text('')
          : Text(
              DateFormat('h:mm a')
                  .format(conversation.lastMessageTime!.toLocal()),
              style: const TextStyle(fontSize: 13),
            ),
    );
  }
}
