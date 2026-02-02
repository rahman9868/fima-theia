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
  final controller = Get.find<WorkCalendarController>();

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime(DateTime.now().year, DateTime.now().month, 1);
    controller.loadCalendars([_focusedDay]);
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
        return Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2000, 1, 1),
              lastDay: DateTime.utc(2100, 12, 31),
              focusedDay: _focusedDay,
              locale: 'id_ID',
              calendarFormat: CalendarFormat.month,
              startingDayOfWeek: StartingDayOfWeek.sunday,
              headerStyle: const HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
                leftChevronIcon: Icon(Icons.chevron_left),
                rightChevronIcon: Icon(Icons.chevron_right),
              ),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  final att = controller.attendances[date];
                  if (att == null) return null;
                  // Red for absent, orange for late
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
                  // Same as today
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
              onPageChanged: (date) {
                setState(() {
                  _focusedDay = DateTime(date.year, date.month, 1);
                });
                controller.loadCalendars([_focusedDay]);
              },
              calendarStyle: CalendarStyle(
                markersAlignment: Alignment.bottomCenter,
                markersMaxCount: 1,
                markerSize: 16,
                weekendTextStyle: const TextStyle(color: Colors.black),
              ),
              eventLoader: (date) {
                final att = controller.attendances[date];
                if (att != null) return [att];
                return [];
              },
            ),
          ],
        );
      }),
    );
  }
}
