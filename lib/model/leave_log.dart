class LeaveLog {
  LeaveLog({
    this.empId,
    this.dateTime,
    this.from,
    this.to,
    this.leaveType,
    this.reasonOfLeave,
    this.status,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  String empId;
  DateTime dateTime;
  DateTime from;
  DateTime to;
  String leaveType;
  String reasonOfLeave;
  String status;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  factory LeaveLog.fromJson(Map<String, dynamic> json) => LeaveLog(
    empId: json["emp_id"],
    dateTime: DateTime.parse(json["date_time"]),
    from: DateTime.parse(json["from"]),
    to: DateTime.parse(json["to"]),
    leaveType: json["leave_type"],
    reasonOfLeave: json["reason_of_leave"],
    status: json["status"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "emp_id": empId,
    "date_time": dateTime.toIso8601String(),
    "from": from.toIso8601String(),
    "to": to.toIso8601String(),
    "leave_type": leaveType,
    "reason_of_leave": reasonOfLeave,
    "status": status,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "id": id,
  };
}