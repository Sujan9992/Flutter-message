import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  MessageBubble(this.message, this.isMe);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isMe ? Colors.redAccent : Theme.of(context).accentColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14.0),
              topRight: Radius.circular(14.0),
              bottomLeft: isMe ? Radius.circular(14.0) : Radius.circular(0),
              bottomRight: isMe ? Radius.circular(0) : Radius.circular(14.0),
            ),
          ),
          // width: 140.0,
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
          margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: Text(
            message,
            style: TextStyle(
                color: isMe
                    ? Colors.black
                    : Theme.of(context).accentTextTheme.bodyText1!.color),
          ),
        ),
      ],
    );
  }
}
