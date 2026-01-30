enum AttendanceEventType {
  late('LATE'),
  onTime('ON_TIME'),
  absent('ABSENT'),
  pending('PENDING'),
  working('WORKING'),
  business('BUSINESS'),
  leave('LEAVE'),
  holiday('HOLIDAY');

  final String value;
  const AttendanceEventType(this.value);
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