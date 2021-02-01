// To parse this JSON data, do
//
//     final attendanceLog = attendanceLogFromJson(jsonString);

import 'dart:convert';

AttendanceLog attendanceLogFromJson(String str) => AttendanceLog.fromJson(json.decode(str));

String attendanceLogToJson(AttendanceLog data) => json.encode(data.toJson());

class AttendanceLog {
  AttendanceLog({
    this.employeeDetail,
  });

  List<EmployeeDetail> employeeDetail;

  factory AttendanceLog.fromJson(Map<String, dynamic> json) => AttendanceLog(
    employeeDetail: List<EmployeeDetail>.from(json["Employee Detail"].map((x) => EmployeeDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Employee Detail": List<dynamic>.from(employeeDetail.map((x) => x.toJson())),
  };
}

class EmployeeDetail {
  EmployeeDetail({
    this.id,
    this.empId,
    this.dateTime,
    this.time,
    this.type,
    this.location,
    this.totalHour,
    this.avgHour,
    this.curruntLat,
    this.curruntLong,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int empId;
  DateTime dateTime;
  DateTime time;
  String type;
  String location;
  dynamic totalHour;
  dynamic avgHour;
  String curruntLat;
  String curruntLong;
  DateTime createdAt;
  DateTime updatedAt;

  factory EmployeeDetail.fromJson(Map<String, dynamic> json) => EmployeeDetail(
    id: json["id"],
    empId: json["emp_id"],
    dateTime: DateTime.parse(json["date_time"]),
    time: DateTime.parse(json["time"]),
    type: json["type"],
    location: json["location"],
    totalHour: json["total_hour"],
    avgHour: json["avg_hour"],
    curruntLat: json["currunt_lat"],
    curruntLong: json["currunt_long"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "emp_id": empId,
    "date_time": dateTime.toIso8601String(),
    "time": time.toIso8601String(),
    "type": type,
    "location": location,
    "total_hour": totalHour,
    "avg_hour": avgHour,
    "currunt_lat": curruntLat,
    "currunt_long": curruntLong,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };


  // DateTime getDate() {
  //   return DateTime.fromMillisecondsSinceEpoch(this.time);
  // }
  //
  // DateTime getDateWithMinutes() {
  //   return DateTime.fromMillisecondsSinceEpoch(this.dateWithMinutes);
  // }
}
