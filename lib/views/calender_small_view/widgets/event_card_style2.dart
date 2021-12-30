// ignore_for_file: sized_box_for_whitespace

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_demo/constants.dart';
import 'package:flutter_calendar_demo/models/event.dart';
import 'package:flutter_calendar_demo/responsive.dart';
import 'package:flutter_calendar_demo/views/webview/webview.dart';
import 'package:url_launcher/url_launcher.dart';

class EventCardStyle2 extends StatelessWidget {
  const EventCardStyle2({
    Key? key,
    required this.event,
  }) : super(key: key);

  final Event event;

  double cardHeight(BuildContext context) {
    if (Responsive.isTablet(context)) {
      return 105.0;
    }
    if (MediaQuery.of(context).size.width > 1300) {
      return 120.0;
    }

    return 130.0;
  }

  // ignore: unused_element
  void _launchURL(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: darkBlueColor,
      margin: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 4.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(eventCardBorder),
      ),
      child: Container(
        height: cardHeight(context),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 7,
              decoration: const BoxDecoration(
                color: darkOrangeColor,
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
                  color: darkBlueColor,
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
                        color: Colors.white,
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
                      style: const TextStyle(color: lightOrangeColor),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(event.avatarUrl!),
                          radius: 12,
                          backgroundColor: lightOrangeColor,
                        ),
                        const SizedBox(width: 10.0),
                        InkWell(
                          onTap: () {
                            if (!Responsive.isTablet(context)) {
                              _launchURL(event.clientProfileUrl!);
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WebViewPage(
                                        url: event.clientProfileUrl!)),
                              );
                            }
                          },
                          child: const Text(
                            "View Client Profile",
                            style: TextStyle(
                              color: lightOrangeColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 60,
              decoration: const BoxDecoration(
                color: darkBlueColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(eventCardBorder),
                  bottomRight: Radius.circular(eventCardBorder),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 12, right: 12),
                    child: const CircleAvatar(
                      backgroundColor: lightOrangeColor,
                      radius: 20,
                      child: Icon(
                        Icons.videocam_outlined,
                        color: darkBlueColor,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
