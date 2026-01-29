class AttendanceSummaryDto {
  final int day;
  final String eventType;

  AttendanceSummaryDto({
    required this.day,
    required this.eventType,
  });

  factory AttendanceSummaryDto.fromJson(Map<String, dynamic> json) {
    return AttendanceSummaryDto(
      day: json['day'] ?? 0,
      eventType: json['eventType'] ?? '',
    );
  }
}

class AttendanceSummaryDataDto {
  final int employeeId;
  final int year;
  final int month;
  final List<AttendanceSummaryDto>? event;

  AttendanceSummaryDataDto({
    required this.employeeId,
    required this.year,
    required this.month,
    this.event,
  });

  factory AttendanceSummaryDataDto.fromJson(Map<String, dynamic> json) {
    final eventsJson = json['event'] as List?;
    return AttendanceSummaryDataDto(
      employeeId: json['employeeId'] ?? 0,
      year: json['year'] ?? 0,
      month: json['month'] ?? 0,
      event: eventsJson != null
          ? eventsJson
              .map((e) => AttendanceSummaryDto.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
    );
  }
}

class DataAttendanceSummaryDto {
  final List<AttendanceSummaryDataDto>? data;

  DataAttendanceSummaryDto({
    this.data,
  });

  factory DataAttendanceSummaryDto.fromJson(Map<String, dynamic> json) {
    final dataJson = json['data'] as List?;
    return DataAttendanceSummaryDto(
      data: dataJson != null
          ? dataJson
              .map((e) =>
                  AttendanceSummaryDataDto.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
    );
  }
}
