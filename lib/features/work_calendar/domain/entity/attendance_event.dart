enum AttendanceEventType {
  present,
  absent,
  holiday,
  sick,
  remote,
}

class AttendanceEvent {
  final DateTime date;
  final AttendanceEventType type;
  final String? description;

  AttendanceEvent({
    required this.date,
    required this.type,
    this.description,
  });
}