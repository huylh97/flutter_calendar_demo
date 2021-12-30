// ignore_for_file: override_on_non_overriding_member, prefer_const_constructors_in_immutables, avoid_print, sized_box_for_whitespace, prefer_const_constructors

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_demo/constants.dart';
import 'package:flutter_calendar_demo/models/event.dart';
import 'package:flutter_calendar_demo/responsive.dart';
import 'package:flutter_calendar_demo/views/calender_small_view/widgets/apointment_card.dart';
import 'package:flutter_calendar_demo/views/calender_small_view/widgets/event_card_style1.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import '../../utils.dart';
import 'widgets/small_event_card_style1.dart';
import 'widgets/small_event_card_style2.dart';
import 'widgets/small_event_card_style3.dart';

class CalendarLargeView extends StatefulWidget {
  CalendarLargeView({Key? key}) : super(key: key);

  @override
  _CalendarLargeViewState createState() => _CalendarLargeViewState();
}

class _CalendarLargeViewState extends State<CalendarLargeView> {
  @override
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    return fakeEvents[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    _selectedEvents.value = _getEventsForDay(selectedDay);

    showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Upcoming Events',
              style: TextStyle(color: darkBlueColor),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
            content: _selectedEvents.value.isEmpty
                ? Text('There are no events')
                : Container(
                    height: 500,
                    width: 350,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 30),
                      itemCount: _selectedEvents.value.length,
                      itemBuilder: (context, index) {
                        if (EventType.values[
                                _selectedEvents.value[index].eventType!] ==
                            EventType.event) {
                          return EventCardStyle1(
                              cardHeigt: 120,
                              event: _selectedEvents.value[index]);
                        } else {
                          return ApointmentCard(
                              event: _selectedEvents.value[index]);
                        }
                      },
                    ),
                  ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Responsive.isMobile(context) ? bgColor : Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TableCalendar<Event>(
                  firstDay: DateTime(kToday.year, kToday.month - 5, kToday.day),
                  lastDay: DateTime(kToday.year, kToday.month + 5, kToday.day),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  availableCalendarFormats: const {
                    CalendarFormat.month: 'Month'
                  },
                  shouldFillViewport: true,
                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    titleTextStyle: const TextStyle(
                      color: darkBlueColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    leftChevronPadding:
                        const EdgeInsets.all(12.0).copyWith(left: 0),
                    rightChevronPadding:
                        const EdgeInsets.all(12.0).copyWith(right: 0),
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    dowTextFormatter: (date, locale) => DateFormat.E(locale)
                        .format(date)
                        .toString()
                        .toUpperCase(),
                    weekdayStyle: buildDaysOfWeekTextStyle(),
                    weekendStyle: buildDaysOfWeekTextStyle(),
                  ),
                  calendarStyle:
                      CalendarStyle(markerSize: 0), // Remove marker icon
                  eventLoader: _getEventsForDay,
                  startingDayOfWeek: StartingDayOfWeek.sunday,
                  onDaySelected: _onDaySelected,
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                  calendarBuilders: CalendarBuilders(
                    // Mark: defaultBuilder
                    defaultBuilder: (context, day, focusedDay) {
                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(defaultCellMargin),
                        padding: const EdgeInsets.symmetric(
                            vertical: defaultCellPadding),
                        decoration: buildCellDecoration(),
                        child: Column(
                          children: [
                            Text(formatDate(day, [d]))
                          ],
                        ),
                      );
                    },
                    // Mark: outsideBuilder
                    outsideBuilder: (context, day, focusedDay) {
                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(defaultCellMargin),
                        padding: const EdgeInsets.symmetric(
                            vertical: defaultCellPadding),
                        decoration: buildCellDecoration(),
                        child: Column(
                          children: [
                            Text(
                              formatDate(day, [d]),
                              style: TextStyle(color: Colors.black26),
                            )
                          ],
                        ),
                      );
                    },
                    // Mark: markerBuilder
                    markerBuilder: (context, day, events) {
                      return events.isEmpty
                          ? Container()
                          : Container(
                              width: double.infinity,
                              margin: const EdgeInsets.all(defaultCellMargin),
                              padding: const EdgeInsets.symmetric(
                                  vertical: defaultCellPadding),
                              decoration: buildCellDecoration().copyWith(
                                  color: isSameDay(day, DateTime.now())
                                      ? lightBlueColor
                                      : lightOrangeColor),
                              child: Column(
                                children: [
                                  Text(formatDate(day, [d])),
                                  const SizedBox(height: 5.0),
                                  Expanded(
                                    child: LayoutBuilder(
                                      builder: (BuildContext context,
                                          BoxConstraints constraints) {
                                        if (constraints.maxHeight < 80) {
                                          return Column(children: [
                                            ...generateListEventCard(
                                                2, day, events)
                                          ]);
                                        } else {
                                          return Column(
                                            children: [
                                              ...generateListEventCard(
                                                  3, day, events)
                                            ],
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration buildCellDecoration() {
    return BoxDecoration(
      border: Border.all(
        color: Colors.grey.withOpacity(0.5),
      ),
      borderRadius: BorderRadius.circular(5.0),
    );
  }

  List<Widget> generateListEventCard(
      int numCard, DateTime day, List<Event> events) {
    List<Widget> list = [];
    for (int i = 0; i < events.length; i++) {
      if (i > numCard - 1) {
        list.add(Icon(Icons.more_horiz, color: darkBlueColor));
        break;
      }
      list.add(
        events[i].eventType! == 0
            ? SmallEventCallStyle2(event: events[i])
            : isSameDay(day, DateTime.now())
                ? SmallEventCallStyle3(event: events[i])
                : SmallEventCallStyle1(event: events[i]),
      );
    }
    return list;
  }
}
