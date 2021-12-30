import 'package:flutter/material.dart';
import 'package:flutter_calendar_demo/models/event.dart';

import '../../../constants.dart';

class SmallEventCallStyle2 extends StatelessWidget {
  const SmallEventCallStyle2({Key? key, required this.event}) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: smallEventCardHeight,
      margin: const EdgeInsets.only(bottom: 1.0),
      decoration: BoxDecoration(
        color: darkOrangeColor,
        borderRadius: BorderRadius.circular(2.0),
      ),
      child: Text(
        event.title!,
        style: const TextStyle(fontSize: 10, color: darkBlueColor),
        overflow: TextOverflow.fade,
      ),
    );
  }
}
