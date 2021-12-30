// ignore_for_file: prefer_const_constructors

import 'dart:collection';
import 'dart:math';
import 'package:table_calendar/table_calendar.dart';

enum EventType {
  apointment, // index = 0
  event, // index = 1
}

class Event {
  final int? eventType;
  final String? title;
  final DateTime? startedTime;
  final DateTime? endedTime;
  final String? avatarUrl;
  final String? clientProfileUrl;

  Event({
    this.eventType,
    this.title,
    this.startedTime,
    this.endedTime,
    this.avatarUrl,
    this.clientProfileUrl,
  });
}

final exampleEvents = [
  Event(
    eventType: 1,
    title: "First Session with Alex Stan",
    startedTime: DateTime.now(),
    endedTime: DateTime.now().add(Duration(minutes: 30)),
    avatarUrl:
        "https://www.pngall.com/wp-content/uploads/12/Avatar-Profile-PNG-Free-Image.png",
    clientProfileUrl: "https://www.google.com/",
  ),
  Event(
    eventType: 0,
    title: 'Webinar: How to cope with trauma in professional life ',
    startedTime: DateTime.now(),
    endedTime: DateTime.now().add(Duration(minutes: 30)),
    avatarUrl:
        "https://www.pngall.com/wp-content/uploads/12/Avatar-Profile-PNG-Free-Image.png",
    clientProfileUrl: "https://www.google.com/",
  ),
  Event(
    eventType: 1,
    title:
        "Chemistry Session with Alex Stan (dummy text in order to text overflow for longth text)",
    startedTime: DateTime.now(),
    endedTime: DateTime.now().add(Duration(minutes: 30)),
    avatarUrl:
        "https://www.pngall.com/wp-content/uploads/12/Avatar-Profile-PNG-Free-Image.png",
    clientProfileUrl: "https://www.google.com/",
  )
];

/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final fakeEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(kEventSource);

// ignore: prefer_for_elements_to_map_fromiterable
final kEventSource = Map.fromIterable(
  List.generate(30, (index) => index),
  key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
  value: (item) => List.generate(
    Random().nextInt(6),
    (index) => exampleEvents[index % 3],
  ),
)..addAll(
    {kToday: exampleEvents},
  );

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 1, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 1, kToday.day);
