import 'package:evogram/domain/models/conversation_model.dart';
import 'package:evogram/domain/models/get_user_model.dart';
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
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: NetworkImage(user.profilePic),
      ),
      title: Text(
        user.userName,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        conversation.lastMessage ?? "",
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
