import 'package:hive/hive.dart';
part 'schedule.g.dart';

// Base schedule model
@HiveType(typeId: 21)
class Schedule extends HiveObject {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final bool? isActive;

  @HiveField(2)
  final String? scheduleDate;

  @HiveField(3)
  final int? scheduleId;

  @HiveField(4)
  final int? scheduleVersionId;

  @HiveField(5)
  final String? startTimeDate;

  @HiveField(6)
  final String? endTimeDate;

  @HiveField(7)
  final String? workingDayCode;

  @HiveField(8)
  final String? workingHourFromDate;

  @HiveField(9)
  final String? workingHourToDate;

  @HiveField(10)
  final String? breakHourFromDate;

  @HiveField(11)
  final String? breakHourToDate;

  @HiveField(12)
  final String? toleranceInDate;

  @HiveField(13)
  final String? toleranceLateInDate;

  @HiveField(14)
  final String? toleranceLateOutDate;

  Schedule({
    this.id,
    this.isActive,
    this.scheduleDate,
    this.scheduleId,
    this.scheduleVersionId,
    this.startTimeDate,
    this.endTimeDate,
    this.workingDayCode,
    this.workingHourFromDate,
    this.workingHourToDate,
    this.breakHourFromDate,
    this.breakHourToDate,
    this.toleranceInDate,
    this.toleranceLateInDate,
    this.toleranceLateOutDate,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        id: json['id'],
        isActive: json['isActive'],
        scheduleDate: json['scheduleDate'],
        scheduleId: json['scheduleId'],
        scheduleVersionId: json['scheduleVersionId'],
        startTimeDate: json['startTimeDate'],
        endTimeDate: json['endTimeDate'],
        workingDayCode: json['workingDayCode'],
        workingHourFromDate: json['workingHourFromDate'],
        workingHourToDate: json['workingHourToDate'],
        breakHourFromDate: json['breakHourFromDate'],
        breakHourToDate: json['breakHourToDate'],
        toleranceInDate: json['toleranceInDate'],
        toleranceLateInDate: json['toleranceLateInDate'],
        toleranceLateOutDate: json['toleranceLateOutDate'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'isActive': isActive,
        'scheduleDate': scheduleDate,
        'scheduleId': scheduleId,
        'scheduleVersionId': scheduleVersionId,
        'startTimeDate': startTimeDate,
        'endTimeDate': endTimeDate,
        'workingDayCode': workingDayCode,
        'workingHourFromDate': workingHourFromDate,
        'workingHourToDate': workingHourToDate,
        'breakHourFromDate': breakHourFromDate,
        'breakHourToDate': breakHourToDate,
        'toleranceInDate': toleranceInDate,
        'toleranceLateInDate': toleranceLateInDate,
        'toleranceLateOutDate': toleranceLateOutDate,
      };
}

// Flexible schedule model
@HiveType(typeId: 22)
class FlexibleSchedule extends HiveObject {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final bool? isActive;

  @HiveField(2)
  final bool? isFlexible;

  @HiveField(3)
  final String? scheduleDate;

  @HiveField(4)
  final int? scheduleId;

  @HiveField(5)
  final int? scheduleVersionId;

  @HiveField(6)
  final String? startTimeDate;

  @HiveField(7)
  final String? endTimeDate;

  @HiveField(8)
  final String? workingDayCode;

  @HiveField(9)
  final String? workingHourFromDate;

  @HiveField(10)
  final String? workingHourToDate;

  @HiveField(11)
  final String? breakHourFromDate;

  @HiveField(12)
  final String? breakHourToDate;

  @HiveField(13)
  final int? breakDuration;

  @HiveField(14)
  final int? minimumDuration;

  @HiveField(15)
  final int? maximumDuration;

  @HiveField(16)
  final String? toleranceInDate;

  @HiveField(17)
  final String? toleranceLateInDate;

  @HiveField(18)
  final String? toleranceLateOutDate;

  FlexibleSchedule({
    this.id,
    this.isActive,
    this.isFlexible,
    this.scheduleDate,
    this.scheduleId,
    this.scheduleVersionId,
    this.startTimeDate,
    this.endTimeDate,
    this.workingDayCode,
    this.workingHourFromDate,
    this.workingHourToDate,
    this.breakHourFromDate,
    this.breakHourToDate,
    this.breakDuration,
    this.minimumDuration,
    this.maximumDuration,
    this.toleranceInDate,
    this.toleranceLateInDate,
    this.toleranceLateOutDate,
  });

  factory FlexibleSchedule.fromJson(Map<String, dynamic> json) => FlexibleSchedule(
        id: json['id'],
        isActive: json['isActive'],
        isFlexible: json['isFlexible'],
        scheduleDate: json['scheduleDate'],
        scheduleId: json['scheduleId'],
        scheduleVersionId: json['scheduleVersionId'],
        startTimeDate: json['startTimeDate'],
        endTimeDate: json['endTimeDate'],
        workingDayCode: json['workingDayCode'],
        workingHourFromDate: json['workingHourFromDate'],
        workingHourToDate: json['workingHourToDate'],
        breakHourFromDate: json['breakHourFromDate'],
        breakHourToDate: json['breakHourToDate'],
        breakDuration: json['breakDuration'],
        minimumDuration: json['minimumDuration'],
        maximumDuration: json['maximumDuration'],
        toleranceInDate: json['toleranceInDate'],
        toleranceLateInDate: json['toleranceLateInDate'],
        toleranceLateOutDate: json['toleranceLateOutDate'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'isActive': isActive,
        'isFlexible': isFlexible,
        'scheduleDate': scheduleDate,
        'scheduleId': scheduleId,
        'scheduleVersionId': scheduleVersionId,
        'startTimeDate': startTimeDate,
        'endTimeDate': endTimeDate,
        'workingDayCode': workingDayCode,
        'workingHourFromDate': workingHourFromDate,
        'workingHourToDate': workingHourToDate,
        'breakHourFromDate': breakHourFromDate,
        'breakHourToDate': breakHourToDate,
        'breakDuration': breakDuration,
        'minimumDuration': minimumDuration,
        'maximumDuration': maximumDuration,
        'toleranceInDate': toleranceInDate,
        'toleranceLateInDate': toleranceLateInDate,
        'toleranceLateOutDate': toleranceLateOutDate,
      };
}

// Flexible Temp schedule model
@HiveType(typeId: 23)
class FlexibleTempSchedule extends HiveObject {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final bool? isActive;

  @HiveField(2)
  final bool? isFlexible;

  @HiveField(3)
  final String? scheduleDate;

  @HiveField(4)
  final int? scheduleId;

  @HiveField(5)
  final int? scheduleVersionId;

  @HiveField(6)
  final String? startTimeDate;

  @HiveField(7)
  final String? endTimeDate;

  @HiveField(8)
  final String? workingDayCode;

  @HiveField(9)
  final String? workingHourFromDate;

  @HiveField(10)
  final String? workingHourToDate;

  @HiveField(11)
  final String? breakHourFromDate;

  @HiveField(12)
  final String? breakHourToDate;

  @HiveField(13)
  final int? breakDuration;

  @HiveField(14)
  final int? minimumDuration;

  @HiveField(15)
  final int? maximumDuration;

  @HiveField(16)
  final String? toleranceInDate;

  @HiveField(17)
  final String? toleranceLateInDate;

  @HiveField(18)
  final String? toleranceLateOutDate;

  @HiveField(19)
  final String? limitWorkingFromDate;

  FlexibleTempSchedule({
    this.id,
    this.isActive,
    this.isFlexible,
    this.scheduleDate,
    this.scheduleId,
    this.scheduleVersionId,
    this.startTimeDate,
    this.endTimeDate,
    this.workingDayCode,
    this.workingHourFromDate,
    this.workingHourToDate,
    this.breakHourFromDate,
    this.breakHourToDate,
    this.breakDuration,
    this.minimumDuration,
    this.maximumDuration,
    this.toleranceInDate,
    this.toleranceLateInDate,
    this.toleranceLateOutDate,
    this.limitWorkingFromDate,
  });

  factory FlexibleTempSchedule.fromJson(Map<String, dynamic> json) =>
      FlexibleTempSchedule(
        id: json['id'],
        isActive: json['isActive'],
        isFlexible: json['isFlexible'],
        scheduleDate: json['scheduleDate'],
        scheduleId: json['scheduleId'],
        scheduleVersionId: json['scheduleVersionId'],
        startTimeDate: json['startTimeDate'],
        endTimeDate: json['endTimeDate'],
        workingDayCode: json['workingDayCode'],
        workingHourFromDate: json['workingHourFromDate'],
        workingHourToDate: json['workingHourToDate'],
        breakHourFromDate: json['breakHourFromDate'],
        breakHourToDate: json['breakHourToDate'],
        breakDuration: json['breakDuration'],
        minimumDuration: json['minimumDuration'],
        maximumDuration: json['maximumDuration'],
        toleranceInDate: json['toleranceInDate'],
        toleranceLateInDate: json['toleranceLateInDate'],
        toleranceLateOutDate: json['toleranceLateOutDate'],
        limitWorkingFromDate: json['limitWorkingFromDate'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'isActive': isActive,
        'isFlexible': isFlexible,
        'scheduleDate': scheduleDate,
        'scheduleId': scheduleId,
        'scheduleVersionId': scheduleVersionId,
        'startTimeDate': startTimeDate,
        'endTimeDate': endTimeDate,
        'workingDayCode': workingDayCode,
        'workingHourFromDate': workingHourFromDate,
        'workingHourToDate': workingHourToDate,
        'breakHourFromDate': breakHourFromDate,
        'breakHourToDate': breakHourToDate,
        'breakDuration': breakDuration,
        'minimumDuration': minimumDuration,
        'maximumDuration': maximumDuration,
        'toleranceInDate': toleranceInDate,
        'toleranceLateInDate': toleranceLateInDate,
        'toleranceLateOutDate': toleranceLateOutDate,
        'limitWorkingFromDate': limitWorkingFromDate,
      };
}