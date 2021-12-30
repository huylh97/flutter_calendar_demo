// ignore_for_file: override_on_non_overriding_member, prefer_const_constructors_in_immutables, avoid_print, sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_calendar_demo/constants.dart';
import 'package:flutter_calendar_demo/models/event.dart';
import 'package:flutter_calendar_demo/responsive.dart';
import 'package:flutter_calendar_demo/views/calender_small_view/widgets/apointment_card.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';

import '../../utils.dart';
import 'widgets/event_card_style1.dart';
import 'widgets/event_card_style2.dart';

class CalenderSmallView extends StatefulWidget {
  CalenderSmallView({Key? key}) : super(key: key);

  @override
  _CalenderSmallViewState createState() => _CalenderSmallViewState();
}

class _CalenderSmallViewState extends State<CalenderSmallView> {
  @override
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  int counterEventCardStyle = -1;

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
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
    counterEventCardStyle = -1;
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
              TableCalendar<Event>(
                firstDay: DateTime(kToday.year, kToday.month - 5, kToday.day),
                lastDay: DateTime(kToday.year, kToday.month + 5, kToday.day),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                calendarFormat: _calendarFormat,
                availableCalendarFormats: const {CalendarFormat.month: 'Month'},
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
                eventLoader: _getEventsForDay,
                startingDayOfWeek: StartingDayOfWeek.sunday,
                daysOfWeekStyle: DaysOfWeekStyle(
                  dowTextFormatter: (date, locale) => DateFormat.E(locale)
                      .format(date)
                      .toString()
                      .toUpperCase(),
                  weekdayStyle: buildDaysOfWeekTextStyle(),
                  weekendStyle: buildDaysOfWeekTextStyle(),
                ),
                calendarStyle: CalendarStyle(
                  outsideDaysVisible: true,
                  markerSize: 6,
                  markerDecoration: const BoxDecoration(
                      color: darkOrangeColor, shape: BoxShape.circle),
                  todayDecoration: const BoxDecoration(
                      color: lightBlueColor, shape: BoxShape.circle),
                  selectedDecoration: const BoxDecoration(
                      color: darkBlueColor, shape: BoxShape.circle),
                ),
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
              ),
              const Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Divider(color: Colors.grey, height: 3, thickness: 0.5),
              ),
              const SizedBox(height: 5.0),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Text(
                  'Upcoming Events',
                  style: TextStyle(
                    color: darkBlueColor,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: defaultPadding),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Text(
                  isSameDay(_selectedDay, DateTime.now())
                      ? "Today, " + formatDate(_selectedDay!, [d, ' ', M])
                      : formatDate(_selectedDay!, [d, ' ', M]),
                  style: const TextStyle(
                    color: daysOfWeekTextColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: defaultPadding),
              Expanded(
                child: ValueListenableBuilder<List<Event>>(
                  valueListenable: _selectedEvents,
                  builder: (context, value, _) {
                    return ListView.builder(
                      padding: const EdgeInsets.only(bottom: 30),
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        if (EventType.values[value[index].eventType!] ==
                            EventType.event) {
                          counterEventCardStyle += 1;
                          return counterEventCardStyle % 2 == 0
                              ? EventCardStyle1(event: value[index])
                              : EventCardStyle2(event: value[index]);
                        } else {
                          return ApointmentCard(event: value[index]);
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
