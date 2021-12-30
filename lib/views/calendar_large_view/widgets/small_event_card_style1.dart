import 'package:flutter/material.dart';
import 'package:flutter_calendar_demo/models/event.dart';

import '../../../constants.dart';

class SmallEventCallStyle1 extends StatelessWidget {
  const SmallEventCallStyle1({Key? key, required this.event}) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: smallEventCardHeight,
      margin: const EdgeInsets.only(bottom: 1.0),
      decoration: BoxDecoration(
        color: lightBlueColor,
        borderRadius: BorderRadius.circular(2.0),
      ),
      child: Text(
        event.title!,
        style: const TextStyle(fontSize: 10, color: Colors.white),
        overflow: TextOverflow.fade,
      ),
    );
  }
}
