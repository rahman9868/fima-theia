class EmployeeDto {
  final AccountDto? account;
  final AssignmentDto? assignment;

  EmployeeDto({this.account, this.assignment});

  factory EmployeeDto.fromJson(Map<String, dynamic> json) {
    return EmployeeDto(
      account: json['account'] != null ? AccountDto.fromJson(json['account']) : null,
      assignment: json['assignment'] != null ? AssignmentDto.fromJson(json['assignment']) : null,
    );
  }
}

class AccountDto {
  final int? id;
  final String? username;
  final String? name;
  final String? email;
  final String? phone;
  final String? timezone;
  final String? picture;
  final List<RoleDto>? roles;
  final List<AccessDto>? accesses;
  final DateTime? created;
  final DateTime? modified;

  AccountDto({
    this.id,
    this.username,
    this.name,
    this.email,
    this.phone,
    this.timezone,
    this.picture,
    this.roles,
    this.accesses,
    this.created,
    this.modified,
  });

  factory AccountDto.fromJson(Map<String, dynamic> json) {
    return AccountDto(
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
}

class RoleDto {
  final int? id;
  final String? code;
  final String? name;
  RoleDto({this.id, this.code, this.name});
  factory RoleDto.fromJson(Map<String, dynamic> json) {
    return RoleDto(
      id: json['id'],
      code: json['code'],
      name: json['name'],
    );
  }
}

class AccessDto {
  final int? id;
  final String? domain;
  final String? action;
  AccessDto({this.id, this.domain, this.action});
  factory AccessDto.fromJson(Map<String, dynamic> json) {
    return AccessDto(
      id: json['id'],
      domain: json['domain'],
      action: json['action'],
    );
  }
}

class AssignmentDto {
  final OrganizationDto? organization;
  final JobDto? job;
  AssignmentDto({this.organization, this.job});
  factory AssignmentDto.fromJson(Map<String, dynamic> json) {
    return AssignmentDto(
      organization: json['organization'] != null ? OrganizationDto.fromJson(json['organization']) : null,
      job: json['job'] != null ? JobDto.fromJson(json['job']) : null,
    );
  }
}

class OrganizationDto {
  final int? id;
  final String? organizationCode;
  final String? organizationName;
  final String? description;
  final LocationDto? location;
  final OrganizationConfigDto? organizationConfig;
  OrganizationDto({this.id,this.organizationCode,this.organizationName,this.description,this.location,this.organizationConfig});
  factory OrganizationDto.fromJson(Map<String, dynamic> json) {
    return OrganizationDto(
      id: json['id'],
      organizationCode: json['organizationCode'],
      organizationName: json['organizationName'],
      description: json['description'],
      location: json['location'] != null ? LocationDto.fromJson(json['location']) : null,
      organizationConfig: json['organizationConfig'] != null ? OrganizationConfigDto.fromJson(json['organizationConfig']) : null,
    );
  }
}

class LocationDto {
  final int? id;
  final String? description;
  final int? versionNumber;
  final double? longitude;
  final double? latitude;
  final String? timezone;
  final WorkingScheduleDto? workingSchedule;
  final LocationDetailDto? locationDetail;
  LocationDto({this.id,this.description,this.versionNumber,this.longitude,this.latitude,this.timezone,this.workingSchedule,this.locationDetail});
  factory LocationDto.fromJson(Map<String, dynamic> json) {
    return LocationDto(
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
}

class WorkingScheduleDto {
  final int? id;
  final String? workingScheduleName;
  final String? description;
  final int? companyId;
  final String? scheduleFrom;
  final String? scheduleTo;
  final String? scheduleType;
  final int? versionNumber;
  WorkingScheduleDto({this.id,this.workingScheduleName,this.description,this.companyId,this.scheduleFrom,this.scheduleTo,this.scheduleType,this.versionNumber});
  factory WorkingScheduleDto.fromJson(Map<String, dynamic> json) {
    return WorkingScheduleDto(
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
}

class LocationDetailDto {
  final int? id;
  final int? radius;
  LocationDetailDto({this.id, this.radius});
  factory LocationDetailDto.fromJson(Map<String, dynamic> json) {
    return LocationDetailDto(
      id: json['id'],
      radius: json['radius'],
    );
  }
}

class OrganizationConfigDto {
  final int? id;
  final String? orgFP;
  final String? orgFR;
  final String? orgGPS;
  final String? receiveNotification;
  final String? receiveMail;
  OrganizationConfigDto({this.id,this.orgFP,this.orgFR,this.orgGPS,this.receiveNotification,this.receiveMail});
  factory OrganizationConfigDto.fromJson(Map<String, dynamic> json) {
    return OrganizationConfigDto(
      id: json['id'],
      orgFP: json['orgFP'],
      orgFR: json['orgFR'],
      orgGPS: json['orgGPS'],
      receiveNotification: json['receiveNotification'],
      receiveMail: json['receiveMail'],
    );
  }
}

class JobDto {
  final int? id;
  final String? jobCode;
  final String? jobName;
  final String? jobUuid;
  final bool? isSupervisor;
  final CompanyDto? company;
  final int? countApproval;
  final JobGroupDto? jobGroup;
  JobDto({this.id,this.jobCode,this.jobName,this.jobUuid,this.isSupervisor,this.company,this.countApproval,this.jobGroup});
  factory JobDto.fromJson(Map<String, dynamic> json) {
    return JobDto(
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
}

class CompanyDto {
  final int? id;
  final String? compCode;
  final String? compName;
  final bool? compActive;
  CompanyDto({this.id,this.compCode,this.compName,this.compActive});
  factory CompanyDto.fromJson(Map<String, dynamic> json) {
    return CompanyDto(
      id: json['id'],
      compCode: json['compCode'],
      compName: json['compName'],
      compActive: json['compActive'],
    );
  }
}

class JobGroupDto {
  final int? id;
  final String? jobGroupCode;
  final String? jobGroupName;
  final List<dynamic>? jobGroupCompanyPolicies;
  JobGroupDto({this.id,this.jobGroupCode,this.jobGroupName,this.jobGroupCompanyPolicies});
  factory JobGroupDto.fromJson(Map<String, dynamic> json) {
    return JobGroupDto(
      id: json['id'],
      jobGroupCode: json['jobGroupCode'],
      jobGroupName: json['jobGroupName'],
      jobGroupCompanyPolicies: json['jobGroupCompanyPolicies'],
    );
  }
}
