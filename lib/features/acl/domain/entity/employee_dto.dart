import 'package:hive/hive.dart';
part 'employee_dto.g.dart';

@HiveType(typeId: 2)
class EmployeeDto extends HiveObject {
  @HiveField(0)
  final AccountDto? account;
  @HiveField(1)
  final AssignmentDto? assignment;
  EmployeeDto({this.account, this.assignment});
  factory EmployeeDto.fromJson(Map<String, dynamic> json) => EmployeeDto(
    account: json['account'] != null ? AccountDto.fromJson(json['account']) : null,
    assignment: json['assignment'] != null ? AssignmentDto.fromJson(json['assignment']) : null,
  );
}

@HiveType(typeId: 3)
class AccountDto extends HiveObject {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? username;
  @HiveField(2)
  final String? name;
  @HiveField(3)
  final String? email;
  @HiveField(4)
  final String? phone;
  @HiveField(5)
  final String? timezone;
  @HiveField(6)
  final String? picture;
  @HiveField(7)
  final List<RoleDto>? roles;
  @HiveField(8)
  final List<AccessDto>? accesses;
  @HiveField(9)
  final DateTime? created;
  @HiveField(10)
  final DateTime? modified;
  AccountDto({this.id, this.username, this.name, this.email, this.phone, this.timezone, this.picture, this.roles, this.accesses, this.created, this.modified});
  factory AccountDto.fromJson(Map<String, dynamic> json) => AccountDto(
    id: json['id'],
    username: json['username'],
    name: json['name'],
    email: json['email'],
    phone: json['phone'],
    timezone: json['timezone'],
    picture: json['picture'],
    roles: json['roles'] != null ? List<RoleDto>.from((json['roles'] as List).map((x) => RoleDto.fromJson(x))) : null,
    accesses: json['accesses'] != null ? List<AccessDto>.from((json['accesses'] as List).map((x) => AccessDto.fromJson(x))) : null,
    created: json['created'] != null ? DateTime.parse(json['created']) : null,
    modified: json['modified'] != null ? DateTime.parse(json['modified']) : null,
  );
}

@HiveType(typeId: 4)
class RoleDto extends HiveObject {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? code;
  @HiveField(2)
  final String? name;
  RoleDto({this.id, this.code, this.name});
  factory RoleDto.fromJson(Map<String, dynamic> json) => RoleDto(
    id: json['id'],
    code: json['code'],
    name: json['name'],
  );
}

@HiveType(typeId: 5)
class AccessDto extends HiveObject {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? domain;
  @HiveField(2)
  final String? action;
  AccessDto({this.id, this.domain, this.action});
  factory AccessDto.fromJson(Map<String, dynamic> json) => AccessDto(
    id: json['id'],
    domain: json['domain'],
    action: json['action'],
  );
}

@HiveType(typeId: 6)
class AssignmentDto extends HiveObject {
  @HiveField(0)
  final OrganizationDto? organization;
  @HiveField(1)
  final JobDto? job;
  AssignmentDto({this.organization, this.job});
  factory AssignmentDto.fromJson(Map<String, dynamic> json) => AssignmentDto(
    organization: json['organization'] != null ? OrganizationDto.fromJson(json['organization']) : null,
    job: json['job'] != null ? JobDto.fromJson(json['job']) : null,
  );
}

@HiveType(typeId: 7)
class OrganizationDto extends HiveObject {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? organizationCode;
  @HiveField(2)
  final String? organizationName;
  @HiveField(3)
  final String? description;
  @HiveField(4)
  final LocationDto? location;
  @HiveField(5)
  final OrganizationConfigDto? organizationConfig;
  OrganizationDto({this.id,this.organizationCode,this.organizationName,this.description,this.location,this.organizationConfig});
  factory OrganizationDto.fromJson(Map<String, dynamic> json) => OrganizationDto(
    id: json['id'],
    organizationCode: json['organizationCode'],
    organizationName: json['organizationName'],
    description: json['description'],
    location: json['location'] != null ? LocationDto.fromJson(json['location']) : null,
    organizationConfig: json['organizationConfig'] != null ? OrganizationConfigDto.fromJson(json['organizationConfig']) : null,
  );
}

@HiveType(typeId: 8)
class LocationDto extends HiveObject {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? description;
  @HiveField(2)
  final int? versionNumber;
  @HiveField(3)
  final double? longitude;
  @HiveField(4)
  final double? latitude;
  @HiveField(5)
  final String? timezone;
  @HiveField(6)
  final WorkingScheduleDto? workingSchedule;
  @HiveField(7)
  final LocationDetailDto? locationDetail;
  LocationDto({this.id,this.description,this.versionNumber,this.longitude,this.latitude,this.timezone,this.workingSchedule,this.locationDetail});
  factory LocationDto.fromJson(Map<String, dynamic> json) => LocationDto(
    id: json['id'],
    description: json['description'],
    versionNumber: json['versionNumber'],
    longitude: (json['longitude'] is int) ? (json['longitude'] as int).toDouble() : (json['longitude'] as num?)?.toDouble(),
    latitude: (json['latitude'] is int) ? (json['latitude'] as int).toDouble() : (json['latitude'] as num?)?.toDouble(),
    timezone: json['timezone'],
    workingSchedule: json['workingSchedule'] != null ? WorkingScheduleDto.fromJson(json['workingSchedule']) : null,
    locationDetail: json['locationDetail'] != null ? LocationDetailDto.fromJson(json['locationDetail']) : null,
  );
}

@HiveType(typeId: 9)
class WorkingScheduleDto extends HiveObject {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? workingScheduleName;
  @HiveField(2)
  final String? description;
  @HiveField(3)
  final int? companyId;
  @HiveField(4)
  final String? scheduleFrom;
  @HiveField(5)
  final String? scheduleTo;
  @HiveField(6)
  final String? scheduleType;
  @HiveField(7)
  final int? versionNumber;
  WorkingScheduleDto({this.id,this.workingScheduleName,this.description,this.companyId,this.scheduleFrom,this.scheduleTo,this.scheduleType,this.versionNumber});
  factory WorkingScheduleDto.fromJson(Map<String, dynamic> json) => WorkingScheduleDto(
    id: json['id'],
    workingScheduleName: json['workingScheduleName'],
    description: json['description'],
    companyId: json['companyId'],
    scheduleFrom: json['scheduleFrom'],
    scheduleTo: json['scheduleTo'],
    scheduleType: json['scheduleType'],
    versionNumber: json['versionNumber'],
  );
}

@HiveType(typeId: 10)
class LocationDetailDto extends HiveObject {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final int? radius;
  LocationDetailDto({this.id, this.radius});
  factory LocationDetailDto.fromJson(Map<String, dynamic> json) => LocationDetailDto(
    id: json['id'],
    radius: json['radius'],
  );
}

@HiveType(typeId: 11)
class OrganizationConfigDto extends HiveObject {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? orgFP;
  @HiveField(2)
  final String? orgFR;
  @HiveField(3)
  final String? orgGPS;
  @HiveField(4)
  final String? receiveNotification;
  @HiveField(5)
  final String? receiveMail;
  OrganizationConfigDto({this.id,this.orgFP,this.orgFR,this.orgGPS,this.receiveNotification,this.receiveMail});
  factory OrganizationConfigDto.fromJson(Map<String, dynamic> json) => OrganizationConfigDto(
    id: json['id'],
    orgFP: json['orgFP'],
    orgFR: json['orgFR'],
    orgGPS: json['orgGPS'],
    receiveNotification: json['receiveNotification'],
    receiveMail: json['receiveMail'],
  );
}

@HiveType(typeId: 12)
class JobDto extends HiveObject {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? jobCode;
  @HiveField(2)
  final String? jobName;
  @HiveField(3)
  final String? jobUuid;
  @HiveField(4)
  final bool? isSupervisor;
  @HiveField(5)
  final CompanyDto? company;
  @HiveField(6)
  final int? countApproval;
  @HiveField(7)
  final JobGroupDto? jobGroup;
  JobDto({this.id,this.jobCode,this.jobName,this.jobUuid,this.isSupervisor,this.company,this.countApproval,this.jobGroup});
  factory JobDto.fromJson(Map<String, dynamic> json) => JobDto(
    id: json['id'],
    jobCode: json['jobCode'],
    jobName: json['jobName'],
    jobUuid: json['jobUuid'],
    isSupervisor: json['isSupervisor'],
    company: json['company'] != null ? CompanyDto.fromJson(json['company']) : null,
    countApproval: json['countApproval'],
    jobGroup: json['jobGroup'] != null ? JobGroupDto.fromJson(json['jobGroup']) : null,
  );
}

@HiveType(typeId: 13)
class CompanyDto extends HiveObject {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? compCode;
  @HiveField(2)
  final String? compName;
  @HiveField(3)
  final bool? compActive;
  CompanyDto({this.id,this.compCode,this.compName,this.compActive});
  factory CompanyDto.fromJson(Map<String, dynamic> json) => CompanyDto(
    id: json['id'],
    compCode: json['compCode'],
    compName: json['compName'],
    compActive: json['compActive'],
  );
}

@HiveType(typeId: 14)
class JobGroupDto extends HiveObject {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? jobGroupCode;
  @HiveField(2)
  final String? jobGroupName;
  @HiveField(3)
  final List<dynamic>? jobGroupCompanyPolicies;
  JobGroupDto({this.id,this.jobGroupCode,this.jobGroupName,this.jobGroupCompanyPolicies});
  factory JobGroupDto.fromJson(Map<String, dynamic> json) => JobGroupDto(
    id: json['id'],
    jobGroupCode: json['jobGroupCode'],
    jobGroupName: json['jobGroupName'],
    jobGroupCompanyPolicies: json['jobGroupCompanyPolicies'],
  );
}
