class AttendanceDetailModel {
  final int? employeeId;
  final String? employeeName;
  final String? userName;
  final String? picture;
  final Map<String, dynamic>? attJob;
  final Map<String, dynamic>? clockIn;
  final Map<String, dynamic>? clockOut;

  AttendanceDetailModel({
    this.employeeId,
    this.employeeName,
    this.userName,
    this.picture,
    this.attJob,
    this.clockIn,
    this.clockOut,
  });

  factory AttendanceDetailModel.fromJson(Map<String, dynamic> json) {
    return AttendanceDetailModel(
      employeeId: json['employeeId'],
      employeeName: json['employeeName'],
      userName: json['userName'],
      picture: json['picture'],
      attJob: json['attJob'],
      clockIn: json['clockIn'],
      clockOut: json['clockOut'],
    );
  }
}