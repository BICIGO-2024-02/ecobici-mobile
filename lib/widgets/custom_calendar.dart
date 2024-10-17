import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendar extends StatefulWidget {
  final Function(DateTimeRange) onDateRangeSelected;

  CustomCalendar({required this.onDateRangeSelected});

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: _focusedDay,
      firstDay: DateTime.now(),
      lastDay: DateTime.now().add(Duration(days: 365)),
      rangeStartDay: _rangeStart,
      rangeEndDay: _rangeEnd,
      rangeSelectionMode: RangeSelectionMode.toggledOn,
      onRangeSelected: _onRangeSelected,
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
      calendarFormat: CalendarFormat.month,
      calendarStyle: CalendarStyle(
        rangeHighlightColor: Color(0xFF325D67).withOpacity(0.2),
        rangeStartDecoration: BoxDecoration(
          color: Color(0xFF325D67),
          shape: BoxShape.circle,
        ),
        rangeEndDecoration: BoxDecoration(
          color: Color(0xFF325D67),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _rangeStart = start;
      _rangeEnd = end;
      _focusedDay = focusedDay;
    });

    if (start != null && end != null) {
      widget.onDateRangeSelected(DateTimeRange(start: start, end: end));
    }
  }
}