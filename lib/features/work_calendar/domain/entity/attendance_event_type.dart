enum AttendanceEventType {
  late,           // Yellow
  present,        // Green (On Time)
  pending,        // Orange
  leave,          // Blue
  businessTrip,   // Purple
  working,        // White
  absent,         // Red
  unknown
}

extension AttendanceEventTypeX on AttendanceEventType {
  static AttendanceEventType fromString(String value) {
    switch (value.toUpperCase()) {
      case 'LATE':
        return AttendanceEventType.late;
      case 'PRESENT':
        return AttendanceEventType.present;
      case 'ON_TIME':
        return AttendanceEventType.present;
      case 'PENDING':
        return AttendanceEventType.pending;
      case 'LEAVE':
        return AttendanceEventType.leave;
      case 'BUSINESS_TRIP':
        return AttendanceEventType.businessTrip;
      case 'WORKING':
        return AttendanceEventType.working;
      case 'ABSENT':
        return AttendanceEventType.absent;
      default:
        return AttendanceEventType.unknown;
    }
  }

  String get label {
    switch (this) {
      case AttendanceEventType.late:
        return 'Late';
      case AttendanceEventType.present:
        return 'On Time';
      case AttendanceEventType.pending:
        return 'Pending';
      case AttendanceEventType.leave:
        return 'Leave';
      case AttendanceEventType.businessTrip:
        return 'Business Trip';
      case AttendanceEventType.working:
        return 'Working';
      case AttendanceEventType.absent:
        return 'Absent';
      case AttendanceEventType.unknown:
      default:
        return 'Unknown';
    }
  }
}
