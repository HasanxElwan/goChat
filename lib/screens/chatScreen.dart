import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_chat/constants.dart';
import 'package:go_chat/models/message.dart';
import 'package:go_chat/screens/signInScreen.dart';
import 'package:go_chat/screens/signUpScreen.dart';
import 'package:go_chat/widgets/chatBubble.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);
  static String id = 'ChatScreen';
  final _controller = ScrollController();
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessageCollection);
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messageList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messageList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SignInScreen.id);
                      },
                      icon: const Icon(
                        Icons.logout,
                        color: Colors.black,
                      ))
                ],
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      kLogo,
                      height: 50,
                      width: 50,
                    ),
                    const Text(
                      'Go Chat',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                )),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: messageList.length,
                      itemBuilder: (context, index) {
                        return messageList[index].id == email
                            ? ChatBubble(message: messageList[index])
                            : ChatBubbleFromOther(message: messageList[index]);
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      messages.add({
                        kMessage: data,
                        kCreatedAt: DateTime.now(),
                        'id': email
                      });
                      controller.clear();
                      _controller.animateTo(0,
                          duration: Duration(seconds: 1),
                          curve: Curves.fastOutSlowIn);
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        hintText: 'Message',
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.send,
                            color: kPrimaryColor,
                          ),
                        )),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Scaffold();
        }
      },
    );
  }
}
