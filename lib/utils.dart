import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'constants.dart';

final DateFormat dateFormatStyle1 = DateFormat('dd MM');

TextStyle buildDaysOfWeekTextStyle() {
  return const TextStyle(
      color: daysOfWeekTextColor, fontSize: 12, fontWeight: FontWeight.w500);
}
