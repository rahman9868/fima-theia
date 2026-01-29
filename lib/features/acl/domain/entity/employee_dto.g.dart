// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmployeeDtoAdapter extends TypeAdapter<EmployeeDto> {
  @override
  final int typeId = 2;

  @override
  EmployeeDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmployeeDto(
      account: fields[0] as AccountDto?,
      assignment: fields[1] as AssignmentDto?,
      id: fields[2] as int?,
      isVip: fields[3] as bool?,
      vipIn: fields[4] as bool?,
      vipOut: fields[5] as bool?,
      created: fields[6] as String?,
      employeeActive: fields[7] as bool?,
      employeeExt: fields[8] as bool?,
      modified: fields[9] as String?,
      supervisor: (fields[10] as List?)?.cast<EmployeeSupervisorDto>(),
      lastSync: fields[11] as String?,
      syncSource: fields[12] as String?,
      status: fields[13] as String?,
      useKeycloak: fields[14] as bool?,
      lastUpdate: fields[15] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, EmployeeDto obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.account)
      ..writeByte(1)
      ..write(obj.assignment)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.isVip)
      ..writeByte(4)
      ..write(obj.vipIn)
      ..writeByte(5)
      ..write(obj.vipOut)
      ..writeByte(6)
      ..write(obj.created)
      ..writeByte(7)
      ..write(obj.employeeActive)
      ..writeByte(8)
      ..write(obj.employeeExt)
      ..writeByte(9)
      ..write(obj.modified)
      ..writeByte(10)
      ..write(obj.supervisor)
      ..writeByte(11)
      ..write(obj.lastSync)
      ..writeByte(12)
      ..write(obj.syncSource)
      ..writeByte(13)
      ..write(obj.status)
      ..writeByte(14)
      ..write(obj.useKeycloak)
      ..writeByte(15)
      ..write(obj.lastUpdate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AccountDtoAdapter extends TypeAdapter<AccountDto> {
  @override
  final int typeId = 3;

  @override
  AccountDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccountDto(
      id: fields[0] as int?,
      username: fields[1] as String?,
      name: fields[2] as String?,
      email: fields[3] as String?,
      phone: fields[4] as String?,
      timezone: fields[5] as String?,
      picture: fields[6] as String?,
      roles: (fields[7] as List?)?.cast<RoleDto>(),
      accesses: (fields[8] as List?)?.cast<AccessDto>(),
      created: fields[9] as DateTime?,
      modified: fields[10] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, AccountDto obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.phone)
      ..writeByte(5)
      ..write(obj.timezone)
      ..writeByte(6)
      ..write(obj.picture)
      ..writeByte(7)
      ..write(obj.roles)
      ..writeByte(8)
      ..write(obj.accesses)
      ..writeByte(9)
      ..write(obj.created)
      ..writeByte(10)
      ..write(obj.modified);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RoleDtoAdapter extends TypeAdapter<RoleDto> {
  @override
  final int typeId = 4;

  @override
  RoleDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RoleDto(
      id: fields[0] as int?,
      code: fields[1] as String?,
      name: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, RoleDto obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoleDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AccessDtoAdapter extends TypeAdapter<AccessDto> {
  @override
  final int typeId = 5;

  @override
  AccessDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccessDto(
      id: fields[0] as int?,
      domain: fields[1] as String?,
      action: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AccessDto obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.domain)
      ..writeByte(2)
      ..write(obj.action);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccessDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AssignmentDtoAdapter extends TypeAdapter<AssignmentDto> {
  @override
  final int typeId = 6;

  @override
  AssignmentDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AssignmentDto(
      organization: fields[0] as OrganizationDto?,
      job: fields[1] as JobDto?,
    );
  }

  @override
  void write(BinaryWriter writer, AssignmentDto obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.organization)
      ..writeByte(1)
      ..write(obj.job);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AssignmentDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OrganizationDtoAdapter extends TypeAdapter<OrganizationDto> {
  @override
  final int typeId = 7;

  @override
  OrganizationDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrganizationDto(
      id: fields[0] as int?,
      organizationCode: fields[1] as String?,
      organizationName: fields[2] as String?,
      description: fields[3] as String?,
      location: fields[4] as LocationDto?,
      organizationConfig: fields[5] as OrganizationConfigDto?,
    );
  }

  @override
  void write(BinaryWriter writer, OrganizationDto obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.organizationCode)
      ..writeByte(2)
      ..write(obj.organizationName)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.location)
      ..writeByte(5)
      ..write(obj.organizationConfig);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrganizationDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LocationDtoAdapter extends TypeAdapter<LocationDto> {
  @override
  final int typeId = 8;

  @override
  LocationDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocationDto(
      id: fields[0] as int?,
      description: fields[1] as String?,
      versionNumber: fields[2] as int?,
      longitude: fields[3] as double?,
      latitude: fields[4] as double?,
      timezone: fields[5] as String?,
      workingSchedule: fields[6] as WorkingScheduleDto?,
      locationDetail: fields[7] as LocationDetailDto?,
    );
  }

  @override
  void write(BinaryWriter writer, LocationDto obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.versionNumber)
      ..writeByte(3)
      ..write(obj.longitude)
      ..writeByte(4)
      ..write(obj.latitude)
      ..writeByte(5)
      ..write(obj.timezone)
      ..writeByte(6)
      ..write(obj.workingSchedule)
      ..writeByte(7)
      ..write(obj.locationDetail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WorkingScheduleDtoAdapter extends TypeAdapter<WorkingScheduleDto> {
  @override
  final int typeId = 9;

  @override
  WorkingScheduleDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkingScheduleDto(
      id: fields[0] as int?,
      workingScheduleName: fields[1] as String?,
      description: fields[2] as String?,
      companyId: fields[3] as int?,
      scheduleFrom: fields[4] as String?,
      scheduleTo: fields[5] as String?,
      scheduleType: fields[6] as String?,
      versionNumber: fields[7] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, WorkingScheduleDto obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.workingScheduleName)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.companyId)
      ..writeByte(4)
      ..write(obj.scheduleFrom)
      ..writeByte(5)
      ..write(obj.scheduleTo)
      ..writeByte(6)
      ..write(obj.scheduleType)
      ..writeByte(7)
      ..write(obj.versionNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkingScheduleDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LocationDetailDtoAdapter extends TypeAdapter<LocationDetailDto> {
  @override
  final int typeId = 10;

  @override
  LocationDetailDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocationDetailDto(
      id: fields[0] as int?,
      radius: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, LocationDetailDto obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.radius);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationDetailDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OrganizationConfigDtoAdapter extends TypeAdapter<OrganizationConfigDto> {
  @override
  final int typeId = 11;

  @override
  OrganizationConfigDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrganizationConfigDto(
      id: fields[0] as int?,
      orgFP: fields[1] as String?,
      orgFR: fields[2] as String?,
      orgGPS: fields[3] as String?,
      receiveNotification: fields[4] as String?,
      receiveMail: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, OrganizationConfigDto obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.orgFP)
      ..writeByte(2)
      ..write(obj.orgFR)
      ..writeByte(3)
      ..write(obj.orgGPS)
      ..writeByte(4)
      ..write(obj.receiveNotification)
      ..writeByte(5)
      ..write(obj.receiveMail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrganizationConfigDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class JobDtoAdapter extends TypeAdapter<JobDto> {
  @override
  final int typeId = 12;

  @override
  JobDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return JobDto(
      id: fields[0] as int?,
      jobCode: fields[1] as String?,
      jobName: fields[2] as String?,
      jobUuid: fields[3] as String?,
      isSupervisor: fields[4] as bool?,
      company: fields[5] as CompanyDto?,
      countApproval: fields[6] as int?,
      jobGroup: fields[7] as JobGroupDto?,
    );
  }

  @override
  void write(BinaryWriter writer, JobDto obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.jobCode)
      ..writeByte(2)
      ..write(obj.jobName)
      ..writeByte(3)
      ..write(obj.jobUuid)
      ..writeByte(4)
      ..write(obj.isSupervisor)
      ..writeByte(5)
      ..write(obj.company)
      ..writeByte(6)
      ..write(obj.countApproval)
      ..writeByte(7)
      ..write(obj.jobGroup);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JobDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CompanyDtoAdapter extends TypeAdapter<CompanyDto> {
  @override
  final int typeId = 13;

  @override
  CompanyDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CompanyDto(
      id: fields[0] as int?,
      compCode: fields[1] as String?,
      compName: fields[2] as String?,
      compActive: fields[3] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, CompanyDto obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.compCode)
      ..writeByte(2)
      ..write(obj.compName)
      ..writeByte(3)
      ..write(obj.compActive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompanyDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class JobGroupDtoAdapter extends TypeAdapter<JobGroupDto> {
  @override
  final int typeId = 14;

  @override
  JobGroupDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return JobGroupDto(
      id: fields[0] as int?,
      jobGroupCode: fields[1] as String?,
      jobGroupName: fields[2] as String?,
      jobGroupCompanyPolicies: (fields[3] as List?)?.cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, JobGroupDto obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.jobGroupCode)
      ..writeByte(2)
      ..write(obj.jobGroupName)
      ..writeByte(3)
      ..write(obj.jobGroupCompanyPolicies);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JobGroupDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class EmployeeSupervisorDtoAdapter extends TypeAdapter<EmployeeSupervisorDto> {
  @override
  final int typeId = 15;

  @override
  EmployeeSupervisorDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmployeeSupervisorDto(
      employeeName: fields[0] as String?,
      employeeNo: fields[1] as String?,
      id: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, EmployeeSupervisorDto obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.employeeName)
      ..writeByte(1)
      ..write(obj.employeeNo)
      ..writeByte(2)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeSupervisorDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
