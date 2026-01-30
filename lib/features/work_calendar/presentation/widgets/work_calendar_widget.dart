import 'package:flutter/material.dart';
import '../../domain/entity/attendance_event.dart';

final Map<AttendanceEventType, Color> eventTypeColor = {
  AttendanceEventType.late: Colors.deepOrange,
  AttendanceEventType.onTime: Colors.green,
  AttendanceEventType.absent: Colors.red,
  AttendanceEventType.pending: Colors.grey,
  AttendanceEventType.working: Colors.blue,
  AttendanceEventType.business: Colors.teal,
  AttendanceEventType.leave: Colors.purple,
  AttendanceEventType.holiday: Colors.yellow.shade700,
};

// Optionally remove mockAttendance for production!
List<AttendanceEvent> mockAttendance = [
  AttendanceEvent(date: DateTime.now().subtract(const Duration(days: 1)), type: AttendanceEventType.onTime),
  AttendanceEvent(date: DateTime.now(), type: AttendanceEventType.business),
  AttendanceEvent(date: DateTime.now().add(const Duration(days: 1)), type: AttendanceEventType.absent),
  AttendanceEvent(date: DateTime.now().add(const Duration(days: 5)), type: AttendanceEventType.late),
  AttendanceEvent(date: DateTime.now().add(const Duration(days: 7)), type: AttendanceEventType.leave),
];

class WorkCalendarWidget extends StatelessWidget {
  final List<AttendanceEvent> attendanceEvents;
  const WorkCalendarWidget({super.key, required this.attendanceEvents});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime previousMonth = DateTime(now.year, now.month - 1);
    DateTime nextMonth = DateTime(now.year, now.month + 1);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CalendarMonth(
            label: _monthLabel(previousMonth),
            year: previousMonth.year,
            month: previousMonth.month,
            attendanceEvents: attendanceEvents,
          ),
          CalendarMonth(
            label: _monthLabel(now),
            year: now.year,
            month: now.month,
            attendanceEvents: attendanceEvents,
          ),
          CalendarMonth(
            label: _monthLabel(nextMonth),
            year: nextMonth.year,
            month: nextMonth.month,
            attendanceEvents: attendanceEvents,
          ),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            children: AttendanceEventType.values.map((type) => _legend(type)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _legend(AttendanceEventType type) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14, height: 14,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          color: eventTypeColor[type] ?? Colors.grey,
        ),
        Text(type.value),
      ],
    );
  }

  String _monthLabel(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}";
  }
}

class CalendarMonth extends StatelessWidget {
  final String label;
  final int year;
  final int month;
  final List<AttendanceEvent> attendanceEvents;

  const CalendarMonth({super.key, required this.label, required this.year, required this.month, required this.attendanceEvents});

  @override
  Widget build(BuildContext context) {
    final int daysCount = DateTime(year, month + 1, 0).day;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
          itemCount: daysCount,
          itemBuilder: (context, index) {
            final date = DateTime(year, month, index + 1);
            final event = attendanceEvents.firstWhere(
              (ev) => ev.date.year == year && ev.date.month == month && ev.date.day == index + 1,
              orElse: () => AttendanceEvent(date: date, type: AttendanceEventType.working),
            );
            final color = eventTypeColor[event.type] ?? Colors.grey;
            return Container(
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: color.withOpacity(0.3),
                border: Border.all(color: color, width: 1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(child: Text('${index + 1}')),
            );
          },
        ),
      ],
    );
  }
}
