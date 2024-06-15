import '../../../application/core/constants.dart';

import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});
  final profileimage =
      'https://hips.hearstapps.com/hmg-prod/images/gettyimages-492532708-copy.jpg';
  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    final TextEditingController messageinput = TextEditingController();
    final size = MediaQuery.of(context).size;
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
                      image: NetworkImage(profileimage), fit: BoxFit.cover)),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Dominic Toretto',
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
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: Theme.of(context).brightness == Brightness.light
                    ? const AssetImage(chatbg)
                    : const AssetImage(chatbgdark),
                fit: BoxFit.cover)),
        child: Form(
          key: formkey,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .83,
                          child: Card(
                            margin: const EdgeInsets.only(
                                left: 2, right: 2, bottom: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: TextFormField(
                              controller: messageinput,
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              minLines: 1,
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(left: 10, bottom: 10),
                                border: InputBorder.none,
                                hintText: "Type a message",
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 8,
                          ),
                          child: CircleAvatar(
                            backgroundColor: green50,
                            radius: 25,
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.send,
                                  color: white,
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
