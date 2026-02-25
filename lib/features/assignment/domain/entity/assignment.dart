import 'package:hive/hive.dart';
part 'assignment.g.dart';

@HiveType(typeId: 20)
class Assignment extends HiveObject {
  @HiveField(0)
  final int attendanceType;

  @HiveField(1)
  final String attendanceTypeStr;

  @HiveField(2)
  final int id;

  @HiveField(3)
  final int scheduleId;

  @HiveField(4)
  final String workingDayCode;

  Assignment({
    required this.attendanceType,
    required this.attendanceTypeStr,
    required this.id,
    required this.scheduleId,
    required this.workingDayCode,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) => Assignment(
        attendanceType: json['attendanceType'] ?? 0,
        attendanceTypeStr: json['attendanceTypeStr'] ?? '',
        id: json['id'] ?? 0,
        scheduleId: json['scheduleId'] ?? 0,
        workingDayCode: json['workingDayCode'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'attendanceType': attendanceType,
        'attendanceTypeStr': attendanceTypeStr,
        'id': id,
        'scheduleId': scheduleId,
        'workingDayCode': workingDayCode,
      };
}
