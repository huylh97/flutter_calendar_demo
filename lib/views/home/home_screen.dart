// ignore_for_file: override_on_non_overriding_member

import 'package:flutter/material.dart';
import 'package:flutter_calendar_demo/constants.dart';
import 'package:flutter_calendar_demo/models/calendar_view_style.dart';
import 'package:flutter_calendar_demo/views/calendar_large_view/calendar_large_view.dart';
import 'package:flutter_calendar_demo/views/calender_small_view/calender_small_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CalendarViewStyle calendarViewStyle = CalendarViewStyle.smallViewMonth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlueColor,
        title: const Text("Calendar"),
      ),
      drawer: buildDrawer(),
      body: calendarViewStyle == CalendarViewStyle.smallViewMonth
          ? CalenderSmallView()
          : CalendarLargeView(),
    );
  }

  Drawer buildDrawer() {
    return Drawer(
      backgroundColor: lightBlueColor,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              leading: const Icon(
                Icons.calendar_today,
                color: Colors.white,
              ),
              title: const Text('Small View Calendar'),
              textColor: Colors.white,
              onTap: () {
                setState(() {
                  calendarViewStyle = CalendarViewStyle.smallViewMonth;
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.calendar_view_month,
                color: Colors.white,
              ),
              title: const Text('Large View Calendar'),
              textColor: Colors.white,
              onTap: () {
                setState(() {
                  calendarViewStyle = CalendarViewStyle.largeViewMonth;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
