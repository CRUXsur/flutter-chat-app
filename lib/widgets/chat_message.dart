import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String texto;
  final String uid;
  //final AnimationController animationController;

  const ChatMessage({
    Key? key,
    required this.texto,
    required this.uid,
    //required this.animationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //opacity: animationController,
      //child: SizeTransition(
      //sizeFactor:
      //CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      child: Container(
        child: uid == '123' ? _myMessage() : _notMyMessage(),
        //),
      ),
    );
  }

  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(right: 5, bottom: 5, left: 50),
        child: Text(
          texto,
          style: const TextStyle(color: Colors.white),
        ),
        decoration: BoxDecoration(
            color: const Color(0xff4D9EF6),
            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  Widget _notMyMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(left: 5, bottom: 5, right: 50),
        child: Text(
          texto,
          style: const TextStyle(color: Colors.black87),
        ),
        decoration: BoxDecoration(
          color: const Color(0xffE4E5E8),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
