import 'package:flutter/foundation.dart';
import 'package:fima_theia_flutter/features/work_calendar/domain/entity/attendance_event.dart';
import 'package:fima_theia_flutter/features/work_calendar/domain/usecase/get_attendance_events.dart';

class WorkCalendarController extends ChangeNotifier {
  final GetAttendanceEvents getAttendanceEventsUseCase;

  List<AttendanceEvent> events = [];
  bool isLoading = false;

  WorkCalendarController(this.getAttendanceEventsUseCase);

  Future<void> loadEvents(String employeeId, DateTime from) async {
    isLoading = true;
    notifyListeners();

    try {
      events = await getAttendanceEventsUseCase(employeeId, from);
    } catch (e) {
      events = [];
    }

    isLoading = false;
    notifyListeners();
  }
}
