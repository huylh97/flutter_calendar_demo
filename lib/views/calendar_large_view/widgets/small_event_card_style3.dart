import 'package:flutter/material.dart';
import 'package:flutter_calendar_demo/models/event.dart';
import 'package:flutter_calendar_demo/responsive.dart';

import '../../../constants.dart';

class SmallEventCallStyle3 extends StatelessWidget {
  const SmallEventCallStyle3({Key? key, required this.event}) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: smallEventCardHeight,
      margin: EdgeInsets.only(bottom: Responsive.isMobile(context) ? 1.0 : 2.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            event.title!,
            style: const TextStyle(fontSize: 10, color: darkBlueColor),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
