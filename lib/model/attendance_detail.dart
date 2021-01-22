// To parse this JSON data, do
//
//     final attendanceDetail = attendanceDetailFromJson(jsonString);

import 'dart:convert';

AttendanceDetail attendanceDetailFromJson(String str) =>
    AttendanceDetail.fromJson(json.decode(str));

String attendanceDetailToJson(AttendanceDetail data) =>
    json.encode(data.toJson());

class AttendanceDetail {
  AttendanceDetail({
    this.employeeAttendanceDetail,
  });

  EmployeeAttendanceDetail employeeAttendanceDetail;

  factory AttendanceDetail.fromJson(Map<String, dynamic> json) =>
      AttendanceDetail(
        employeeAttendanceDetail: EmployeeAttendanceDetail.fromJson(
            json["Employee Attendence Detail"]),
      );

  Map<String, dynamic> toJson() => {
        "Employee Attendence Detail": employeeAttendanceDetail.toJson(),
      };
}

class EmployeeAttendanceDetail {
  EmployeeAttendanceDetail({
    this.empId,
    this.dateTime,
    this.time,
    this.type,
    this.location,
    this.curruntLat,
    this.curruntLong,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  int empId;
  DateTime dateTime;
  DateTime time;
  String type;
  String location;
  double curruntLat;
  double curruntLong;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  factory EmployeeAttendanceDetail.fromJson(Map<String, dynamic> json) =>
      EmployeeAttendanceDetail(
        empId: json["emp_id"],
        dateTime: DateTime.parse(json["date_time"]),
        time: DateTime.parse(json["time"]),
        type: json["type"],
        location: json["location"],
        curruntLat: json["currunt_lat"],
        curruntLong: json["currunt_long"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "emp_id": empId,
        "date_time": dateTime.toIso8601String(),
        "time": time.toIso8601String(),
        "type": type,
        "location": location,
        "currunt_lat": curruntLat,
        "currunt_long": curruntLong,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}
