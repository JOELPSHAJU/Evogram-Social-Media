import 'package:evogram/application/socket/socket.dart';
import 'package:evogram/domain/models/getall_message_model.dart';
import 'package:evogram/presentation/bloc/add_message/add_message_bloc.dart';
import 'package:evogram/presentation/bloc/conversation_bloc/conversation_bloc.dart';
import 'package:evogram/presentation/screens/chat_screen/widgets.dart';
import 'package:evogram/presentation/screens/chat_screen/widgets/chat_cards.dart';
import 'package:evogram/presentation/screens/userprofile/profile_screen/profile_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/core/constants.dart';

import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String conversationId;
  final String recieverid;
  final String name;
  final String profilepic;
  ChatScreen(
      {super.key,
      required this.conversationId,
      required this.recieverid,
      required this.name,
      required this.profilepic});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _messageController = TextEditingController();
  final scrollController = ScrollController();

  @override
  void initState() {
    context.read<ConversationBloc>().add(
          GetAllMessagesInitialFetchEvent(
            conversationId: widget.conversationId,
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
            )),
        automaticallyImplyLeading: false,
        shape: const Border(
            bottom: BorderSide(
                color: Color.fromARGB(255, 211, 210, 210), width: 1.5)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                      image: NetworkImage(widget.profilepic),
                      fit: BoxFit.cover)),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text('vin_diesel',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: grey))
                ],
              ),
            )
          ],
        ),
      ),
      body: Form(
        key: _formkey,
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Expanded(
                  child: BlocConsumer<ConversationBloc, ConversationState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is GetAllMessagesLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is GetAllMessagesSuccesfulState) {
                        List<DateTime> dates = [];
                        List<List<AllMessagesModel>> messagesByDate = [];
                        for (var message in state.messagesList) {
                          DateTime date = DateTime(message.createdAt.year,
                              message.createdAt.month, message.createdAt.day);
                          if (!dates.contains(date)) {
                            dates.add(date);
                            messagesByDate.add([message]);
                          } else {
                            messagesByDate.last.add(message);
                          }
                        }
                        dates = dates.reversed.toList();
                        messagesByDate = messagesByDate.reversed.toList();
                        return ListView.builder(
                          controller: scrollController,
                          itemCount: dates.length,
                          reverse: true,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                DateDivider(date: dates[index]),
                                ...messagesByDate[index]
                                    .map((message) => getMessageCard(message)),
                              ],
                            );
                          },
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ),
                Row(
                  children: [
                    Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 440),
                        width: MediaQuery.of(context).size.width - 55,
                        child: Card(
                          margin: const EdgeInsets.only(
                              left: 2, right: 2, bottom: 8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          child: TextFormField(
                            controller: _messageController,
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            minLines: 1,
                            decoration: const InputDecoration(
                                prefix: SizedBox(
                                  width: 10,
                                ),
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide.none),
                                hintText: 'Type a message...',
                                contentPadding: EdgeInsets.all(5)),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_messageController.text.isNotEmpty) {
                          SocketService().sendMessgage(_messageController.text,
                              widget.recieverid, loginuserinfo.id);
                          final message = AllMessagesModel(
                              id: '',
                              senderId: loginuserinfo.id,
                              recieverId: widget.recieverid,
                              conversationId: widget.conversationId,
                              text: _messageController.text,
                              isRead: false,
                              deleteType: '',
                              createdAt: DateTime.now(),
                              updatedAt: DateTime.now(),
                              v: 0);
                          BlocProvider.of<ConversationBloc>(context)
                              .add(AddNewMessageEvent(message: message));
                          context.read<AddMessageBloc>().add(
                              AddMessageButtonClickEvent(
                                  message: _messageController.text,
                                  senderId: loginuserinfo.id,
                                  recieverId: widget.recieverid,
                                  conversationId: widget.conversationId));
                          _messageController.clear();
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 8, right: 2),
                        child: CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 25,
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
