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
  late DateTime _focusedDay;
  late DateTime _prevMonth;
  late DateTime _nextMonth;
  final controller = Get.find<WorkCalendarController>();

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime(DateTime.now().year, DateTime.now().month, 1);
    _prevMonth = DateTime(_focusedDay.year, _focusedDay.month - 1);
    _nextMonth = DateTime(_focusedDay.year, _focusedDay.month + 1);
    // Load previous, current, and next month only once
    controller.loadCalendars([
      _prevMonth,
      _focusedDay,
      _nextMonth
    ]);
  }

  void _goToMonth(DateTime month) {
    setState(() {
      _focusedDay = month;
    });
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
        // Custom header to control previous/next
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.chevron_left),
                    onPressed: _focusedDay.isAtSameMomentAs(_prevMonth)
                        ? null
                        : () => _goToMonth(_prevMonth),
                  ),
                  Text(
                    DateFormat.yMMMM('id_ID').format(_focusedDay),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.blue,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.chevron_right),
                    onPressed: _focusedDay.isAtSameMomentAs(_nextMonth)
                        ? null
                        : () => _goToMonth(_nextMonth),
                  ),
                ],
              ),
            ),
            TableCalendar(
              firstDay: _prevMonth,
              lastDay: _nextMonth,
              focusedDay: _focusedDay,
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
                  final inMonth = date.month == _focusedDay.month;
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
              onPageChanged: (_) {}, // no-op
            ),
          ],
        );
      }),
    );
  }
}
