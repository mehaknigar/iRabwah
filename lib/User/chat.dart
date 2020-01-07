import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bubble/bubble.dart';

final Firestore firestore = Firestore.instance;

class Chat extends StatefulWidget {
  final String email;
  Chat(this.email);
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController messageController = TextEditingController();
  void sendMessage() {
    if (messageController.text != '') {
      firestore
          .collection('messages')
          .document(widget.email)
          .collection(widget.email)
          .add(
        {
          'message': messageController.text,
          'sender': 'user',
          'timestamp': FieldValue.serverTimestamp(),
        },
      );
    }
    messageController.clear();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Messages(widget.email),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  controller: messageController,
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.red,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    hintText: "Type message",
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(),
                child: RaisedButton(
                  elevation: 0,
                  highlightElevation: 0,
                  textColor: Colors.white,
                  color: Colors.red,
                  onPressed: () => sendMessage(),
                  child: Text("Send"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Messages extends StatelessWidget {
  final String email;
  Messages(this.email);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: firestore
            .collection('messages')
            .document(email)
            .collection(email)
            .orderBy('timestamp', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('Loading'),
            );
          }
          final messages = snapshot.data.documents.reversed;
          List<MessageBubble> messageBubbles = [];
          for (var message in messages) {
            final String text = message.data['message'];
            final String sender = message.data['sender'];

            final messageBubble = MessageBubble(
              message: text,
              sender: sender,
            );
            messageBubbles.add(messageBubble);
          }

          if (messageBubbles.length == 0) {
            return Center(child: Text('No Messages'));
          }

          return ListView(
            reverse: true,
            children: messageBubbles,
          );
        });
  }
}

class MessageBubble extends StatelessWidget {
  final String message, sender;

  MessageBubble({this.message, this.sender});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: sender == "user"
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: <Widget>[
          sender == 'user'
              ? Bubble(
                  margin: BubbleEdges.only(top: 10),
                  nip: BubbleNip.rightTop,
                  color: Color.fromRGBO(212, 234, 244, 1.0),
                  child: Text(message, textAlign: TextAlign.right),
                )
              : Bubble(
                  margin: BubbleEdges.only(top: 10),
                  nip: BubbleNip.leftTop,
                  color: Colors.red,
                  child: Text(message, textAlign: TextAlign.left),
                ),
        ],
      ),
    );
  }
}
