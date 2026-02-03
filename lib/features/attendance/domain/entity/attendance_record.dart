class AttendanceRecord {
  final DateTime date;
  final String employeeId;
  final DateTime? checkInTime;
  final DateTime? checkOutTime;
  final String? status;
  final String? notes;

  AttendanceRecord({
    required this.date,
    required this.employeeId,
    this.checkInTime,
    this.checkOutTime,
    this.status,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'employeeId': employeeId,
      'checkInTime': checkInTime?.toIso8601String(),
      'checkOutTime': checkOutTime?.toIso8601String(),
      'status': status,
      'notes': notes,
    };
  }

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) {
    return AttendanceRecord(
      date: DateTime.parse(json['date']),
      employeeId: json['employeeId'],
      checkInTime: json['checkInTime'] != null ? DateTime.parse(json['checkInTime']) : null,
      checkOutTime: json['checkOutTime'] != null ? DateTime.parse(json['checkOutTime']) : null,
      status: json['status'],
      notes: json['notes'],
    );
  }
}