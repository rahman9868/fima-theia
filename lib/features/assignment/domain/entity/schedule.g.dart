// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScheduleAdapter extends TypeAdapter<Schedule> {
  @override
  final int typeId = 21;

  @override
  Schedule read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Schedule(
      id: fields[0] as String?,
      isActive: fields[1] as bool?,
      scheduleDate: fields[2] as String?,
      scheduleId: fields[3] as int?,
      scheduleVersionId: fields[4] as int?,
      startTimeDate: fields[5] as String?,
      endTimeDate: fields[6] as String?,
      workingDayCode: fields[7] as String?,
      workingHourFromDate: fields[8] as String?,
      workingHourToDate: fields[9] as String?,
      breakHourFromDate: fields[10] as String?,
      breakHourToDate: fields[11] as String?,
      toleranceInDate: fields[12] as String?,
      toleranceLateInDate: fields[13] as String?,
      toleranceLateOutDate: fields[14] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Schedule obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.isActive)
      ..writeByte(2)
      ..write(obj.scheduleDate)
      ..writeByte(3)
      ..write(obj.scheduleId)
      ..writeByte(4)
      ..write(obj.scheduleVersionId)
      ..writeByte(5)
      ..write(obj.startTimeDate)
      ..writeByte(6)
      ..write(obj.endTimeDate)
      ..writeByte(7)
      ..write(obj.workingDayCode)
      ..writeByte(8)
      ..write(obj.workingHourFromDate)
      ..writeByte(9)
      ..write(obj.workingHourToDate)
      ..writeByte(10)
      ..write(obj.breakHourFromDate)
      ..writeByte(11)
      ..write(obj.breakHourToDate)
      ..writeByte(12)
      ..write(obj.toleranceInDate)
      ..writeByte(13)
      ..write(obj.toleranceLateInDate)
      ..writeByte(14)
      ..write(obj.toleranceLateOutDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FlexibleScheduleAdapter extends TypeAdapter<FlexibleSchedule> {
  @override
  final int typeId = 22;

  @override
  FlexibleSchedule read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FlexibleSchedule(
      id: fields[0] as String?,
      isActive: fields[1] as bool?,
      isFlexible: fields[2] as bool?,
      scheduleDate: fields[3] as String?,
      scheduleId: fields[4] as int?,
      scheduleVersionId: fields[5] as int?,
      startTimeDate: fields[6] as String?,
      endTimeDate: fields[7] as String?,
      workingDayCode: fields[8] as String?,
      workingHourFromDate: fields[9] as String?,
      workingHourToDate: fields[10] as String?,
      breakHourFromDate: fields[11] as String?,
      breakHourToDate: fields[12] as String?,
      breakDuration: fields[13] as int?,
      minimumDuration: fields[14] as int?,
      maximumDuration: fields[15] as int?,
      toleranceInDate: fields[16] as String?,
      toleranceLateInDate: fields[17] as String?,
      toleranceLateOutDate: fields[18] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FlexibleSchedule obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.isActive)
      ..writeByte(2)
      ..write(obj.isFlexible)
      ..writeByte(3)
      ..write(obj.scheduleDate)
      ..writeByte(4)
      ..write(obj.scheduleId)
      ..writeByte(5)
      ..write(obj.scheduleVersionId)
      ..writeByte(6)
      ..write(obj.startTimeDate)
      ..writeByte(7)
      ..write(obj.endTimeDate)
      ..writeByte(8)
      ..write(obj.workingDayCode)
      ..writeByte(9)
      ..write(obj.workingHourFromDate)
      ..writeByte(10)
      ..write(obj.workingHourToDate)
      ..writeByte(11)
      ..write(obj.breakHourFromDate)
      ..writeByte(12)
      ..write(obj.breakHourToDate)
      ..writeByte(13)
      ..write(obj.breakDuration)
      ..writeByte(14)
      ..write(obj.minimumDuration)
      ..writeByte(15)
      ..write(obj.maximumDuration)
      ..writeByte(16)
      ..write(obj.toleranceInDate)
      ..writeByte(17)
      ..write(obj.toleranceLateInDate)
      ..writeByte(18)
      ..write(obj.toleranceLateOutDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FlexibleScheduleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FlexibleTempScheduleAdapter extends TypeAdapter<FlexibleTempSchedule> {
  @override
  final int typeId = 23;

  @override
  FlexibleTempSchedule read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FlexibleTempSchedule(
      id: fields[0] as String?,
      isActive: fields[1] as bool?,
      isFlexible: fields[2] as bool?,
      scheduleDate: fields[3] as String?,
      scheduleId: fields[4] as int?,
      scheduleVersionId: fields[5] as int?,
      startTimeDate: fields[6] as String?,
      endTimeDate: fields[7] as String?,
      workingDayCode: fields[8] as String?,
      workingHourFromDate: fields[9] as String?,
      workingHourToDate: fields[10] as String?,
      breakHourFromDate: fields[11] as String?,
      breakHourToDate: fields[12] as String?,
      breakDuration: fields[13] as int?,
      minimumDuration: fields[14] as int?,
      maximumDuration: fields[15] as int?,
      toleranceInDate: fields[16] as String?,
      toleranceLateInDate: fields[17] as String?,
      toleranceLateOutDate: fields[18] as String?,
      limitWorkingFromDate: fields[19] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FlexibleTempSchedule obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.isActive)
      ..writeByte(2)
      ..write(obj.isFlexible)
      ..writeByte(3)
      ..write(obj.scheduleDate)
      ..writeByte(4)
      ..write(obj.scheduleId)
      ..writeByte(5)
      ..write(obj.scheduleVersionId)
      ..writeByte(6)
      ..write(obj.startTimeDate)
      ..writeByte(7)
      ..write(obj.endTimeDate)
      ..writeByte(8)
      ..write(obj.workingDayCode)
      ..writeByte(9)
      ..write(obj.workingHourFromDate)
      ..writeByte(10)
      ..write(obj.workingHourToDate)
      ..writeByte(11)
      ..write(obj.breakHourFromDate)
      ..writeByte(12)
      ..write(obj.breakHourToDate)
      ..writeByte(13)
      ..write(obj.breakDuration)
      ..writeByte(14)
      ..write(obj.minimumDuration)
      ..writeByte(15)
      ..write(obj.maximumDuration)
      ..writeByte(16)
      ..write(obj.toleranceInDate)
      ..writeByte(17)
      ..write(obj.toleranceLateInDate)
      ..writeByte(18)
      ..write(obj.toleranceLateOutDate)
      ..writeByte(19)
      ..write(obj.limitWorkingFromDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FlexibleTempScheduleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
