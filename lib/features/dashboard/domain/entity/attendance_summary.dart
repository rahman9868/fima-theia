class AttendanceSummary {
  final int workingDays;
  final int onTime;
  final int late;
  final int absent;
  final int businessTrip;
  final int leave;
  final int pending;
  final String lastUpdate;

  const AttendanceSummary({
    required this.workingDays,
    required this.onTime,
    required this.late,
    required this.absent,
    required this.businessTrip,
    required this.leave,
    required this.pending,
    required this.lastUpdate,
  });
}

enum AttendanceEventType {
  late('LATE'),
  onTime('ON_TIME'),
  absent('ABSENT'),
  pending('PENDING'),
  working('WORKING'),
  business('BUSINESS'),
  leave('LEAVE'),
  holiday('HOLIDAY');

  const AttendanceEventType(this.value);
  final String value;
}
