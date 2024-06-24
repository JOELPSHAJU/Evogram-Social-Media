
import 'package:evogram/domain/models/getall_message_model.dart';
import 'package:evogram/presentation/screens/chat_screen/widgets/own_message_card.dart';
import 'package:evogram/presentation/screens/chat_screen/widgets/replay_card.dart';
import 'package:evogram/presentation/screens/userprofile/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';

Widget getMessageCard(AllMessagesModel message) {
  if (message.senderId == loginuserinfo.id) {
    return OwnMessageCard(
      message: message.text.trim(),
      time: message.createdAt,
    );
  } else {
    return ReplayCard(
      message: message.text.trim(),
      time: message.updatedAt,
    );
  }
}