import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';
import '../work_calendar/domain/entity/attendance_event_type.dart';
import '../work_calendar/presentation/work_calendar_controller.dart';
import 'package:intl/intl.dart';

class WorkCalendarScreen extends StatefulWidget {
  const WorkCalendarScreen({super.key});
  @override
  State<WorkCalendarScreen> createState() => _WorkCalendarScreenState();
}

class _WorkCalendarScreenState extends State<WorkCalendarScreen> {
  late List<DateTime> _months;
  late int _currentMonthIndex;
  final controller = Get.find<WorkCalendarController>();

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _months = [
      DateTime(now.year, now.month - 1),
      DateTime(now.year, now.month),
      DateTime(now.year, now.month + 1),
    ];
    _currentMonthIndex = 1;
    // Only ONE call to load all three months' data!
    controller.loadThreeMonthCalendar(now.year, now.month);
  }

  void _goToPrevMonth() {
    if (_currentMonthIndex > 0) {
      setState(() {
        _currentMonthIndex--;
      });
    }
  }

  void _goToNextMonth() {
    if (_currentMonthIndex < 2) {
      setState(() {
        _currentMonthIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final focusedDay = _months[_currentMonthIndex];
    final prevEnabled = _currentMonthIndex > 0;
    final nextEnabled = _currentMonthIndex < 2;
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
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.chevron_left),
                    onPressed: prevEnabled ? _goToPrevMonth : null,
                  ),
                  Text(
                    DateFormat.yMMMM('id_ID').format(focusedDay),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.blue,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.chevron_right),
                    onPressed: nextEnabled ? _goToNextMonth : null,
                  ),
                ],
              ),
            ),
            TableCalendar(
              firstDay: _months.first,
              lastDay: _months.last,
              focusedDay: focusedDay,
              locale: 'id_ID',
              calendarFormat: CalendarFormat.month,
              startingDayOfWeek: StartingDayOfWeek.sunday,
              headerVisible: false,
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  final att = controller.attendances[date];
                  if (att == null) return null;
                  Color iconColor = Colors.red;
                  if (att.status == AttendanceEventType.late) iconColor = Colors.orange;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.bookmark, color: iconColor, size: 16),
                    ],
                  );
                },
                defaultBuilder: (context, date, _) {
                  final inMonth = date.month == focusedDay.month;
                  return Center(
                    child: Text(
                      '${date.day}',
                      style: TextStyle(
                        color: inMonth ? Colors.black : Colors.grey[400],
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  );
                },
                todayBuilder: (context, date, _) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text('${date.day}', style: const TextStyle(color: Colors.black)),
                    ),
                  );
                },
                selectedBuilder: (context, date, _) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text('${date.day}', style: const TextStyle(color: Colors.black)),
                    ),
                  );
                },
              ),
              eventLoader: (date) {
                final att = controller.attendances[date];
                if (att != null) return [att];
                return [];
              },
              onPageChanged: (_) {}, // handled with custom nav
            ),
          ],
        );
      }),
    );
  }
}
