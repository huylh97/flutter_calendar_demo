// ignore_for_file: sized_box_for_whitespace

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_demo/constants.dart';
import 'package:flutter_calendar_demo/models/event.dart';

class ApointmentCard extends StatelessWidget {
  const ApointmentCard({
    Key? key,
    required this.event,
  }) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 4.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(eventCardBorder),
      ),
      child: Container(
        height: 90,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 7,
              decoration: const BoxDecoration(
                color: lightBlueColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(eventCardBorder),
                  bottomLeft: Radius.circular(eventCardBorder),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                decoration: const BoxDecoration(
                  color: superLightOrangeColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      event.title!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                        color: darkBlueColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      formatDate(event.startedTime!, [HH, ':', nn, ' ', am]) +
                          ' - ' +
                          formatDate(event.endedTime!, [HH, ':', nn, ' ', am]) +
                          ' ' +
                          formatDate(
                            event.startedTime!,
                            ["GTM", Z],
                          ),
                      style: const TextStyle(color: lightBlueColor),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 60,
              decoration: const BoxDecoration(
                color: superLightOrangeColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(eventCardBorder),
                  bottomRight: Radius.circular(eventCardBorder),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
