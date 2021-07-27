import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  var _enteredMessage = '';
  _sendMessage() {
    // FocusScope.of(context).unfocus();
    final User? user = FirebaseAuth.instance.currentUser;
    print('--------------------------');
    print(user!.uid);
    print('--------------------------');
    FirebaseFirestore.instance.collection('chat').add({
      'Text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Send a message..'),
              onSubmitted: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage(),
            icon: Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
