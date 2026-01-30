import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../work_calendar/domain/entity/attendance_event_type.dart';
import '../work_calendar/presentation/work_calendar_controller.dart';

class WorkCalendarScreen extends StatefulWidget {
  const WorkCalendarScreen({super.key});
  @override
  State<WorkCalendarScreen> createState() => _WorkCalendarScreenState();
}

class _WorkCalendarScreenState extends State<WorkCalendarScreen> {
  late DateTime _currentMonth;
  late List<DateTime> _monthsToShow;
  final controller = Get.find<WorkCalendarController>();

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime(DateTime.now().year, DateTime.now().month);
    _monthsToShow = [
      DateTime(_currentMonth.year, _currentMonth.month - 1),
      _currentMonth,
      DateTime(_currentMonth.year, _currentMonth.month + 1),
    ];
    controller.loadCalendars(_monthsToShow);
  }

  Color eventColor(AttendanceEventType type) {
    switch (type) {
      case AttendanceEventType.present:
        return Colors.green;
      case AttendanceEventType.absent:
        return Colors.red;
      case AttendanceEventType.late:
        return Colors.orange;
      case AttendanceEventType.holiday:
        return Colors.blueGrey;
      case AttendanceEventType.leave:
        return Colors.purple;
      case AttendanceEventType.unknown:
      default:
        return Colors.grey;
    }
  }

  Widget buildCalendar(DateTime month) {
    final int daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final firstWeekday = DateTime(month.year, month.month, 1).weekday;
    List<Widget> dayWidgets = [];
    for (int i = 1; i < firstWeekday; i++) {
      dayWidgets.add(const SizedBox.shrink());
    }
    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(month.year, month.month, day);
      dayWidgets.add(Obx(() {
        final attendance = controller.attendances[date];
        return Tooltip(
          message: attendance?.status.label ?? 'No data',
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: attendance != null ? eventColor(attendance.status) : Colors.grey[200],
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                '$day',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: attendance != null && (attendance.status == AttendanceEventType.holiday || attendance.status == AttendanceEventType.absent)
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          ),
        );
      }));
    }
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(DateFormat.yMMMM().format(month), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            GridView.count(
              crossAxisCount: 7,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: dayWidgets,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLegend() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: AttendanceEventType.values
            .where((t) => t != AttendanceEventType.unknown)
            .map((type) => Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: eventColor(type),
                      radius: 8,
                    ),
                    const SizedBox(width: 4),
                    Text(type.label),
                  ],
                ))
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Work Calendar'),
      ),
      body: Obx(() {
        if (controller.loading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.error.isNotEmpty) {
          return Center(child: Text(controller.error.value));
        }
        return ListView(
          children: [
            buildLegend(),
            ..._monthsToShow.map((m) => buildCalendar(m)),
          ],
        );
      }),
    );
  }
}
