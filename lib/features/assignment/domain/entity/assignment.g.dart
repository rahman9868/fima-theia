// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AssignmentAdapter extends TypeAdapter<Assignment> {
  @override
  final int typeId = 20;

  @override
  Assignment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Assignment(
      attendanceType: fields[0] as int,
      attendanceTypeStr: fields[1] as String,
      id: fields[2] as int,
      scheduleId: fields[3] as int,
      workingDayCode: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Assignment obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.attendanceType)
      ..writeByte(1)
      ..write(obj.attendanceTypeStr)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.scheduleId)
      ..writeByte(4)
      ..write(obj.workingDayCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AssignmentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
