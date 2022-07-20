// ignore_for_file: avoid_unnecessary_containers
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/chat/messages.dart';
import '../widgets/chat/new_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
    print('background message title: ${message.notification?.title}');
    print('background message: ${message.notification?.body}');
    return Future.delayed(Duration.zero); //Mock Future
  }

  @override
  void initState() {
    // FirebaseMessaging.onMessage.listen(myBackgroundMessageHandler);
    FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Chat'),
        actions: [
          DropdownButton(
            icon: const Icon(Icons.more_vert),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: const [
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 8),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'Logout',
              )
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'Logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
      body: Container(
          child: Column(
        children: const [
          Expanded(child: Messages()),
          NewMessage(),
        ],
      )),
    );
  }
}
