enum AttendanceEventType { present, absent, late, holiday, leave, unknown }

extension AttendanceEventTypeX on AttendanceEventType {
  static AttendanceEventType fromString(String value) {
    switch (value.toUpperCase()) {
      case 'PRESENT':
        return AttendanceEventType.present;
      case 'ABSENT':
        return AttendanceEventType.absent;
      case 'LATE':
        return AttendanceEventType.late;
      case 'HOLIDAY':
        return AttendanceEventType.holiday;
      case 'LEAVE':
        return AttendanceEventType.leave;
      default:
        return AttendanceEventType.unknown;
    }
  }

  String get label {
    switch (this) {
      case AttendanceEventType.present:
        return 'Present';
      case AttendanceEventType.absent:
        return 'Absent';
      case AttendanceEventType.late:
        return 'Late';
      case AttendanceEventType.holiday:
        return 'Holiday';
      case AttendanceEventType.leave:
        return 'Leave';
      case AttendanceEventType.unknown:
      default:
        return 'Unknown';
    }
  }
}
