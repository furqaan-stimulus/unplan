class LeaveListLog {
  LeaveListLog({
    this.id,
    this.empId,
    this.dateTime,
    this.from,
    this.to,
    this.leaveType,
    this.reasonOfLeave,
    this.status,
    this.totalDays,
  });

  int id;
  int empId;
  DateTime dateTime;
  DateTime from;
  DateTime to;
  String leaveType;
  String reasonOfLeave;
  String status;
  int totalDays;


  factory LeaveListLog.fromJson(Map<String, dynamic> json) => LeaveListLog(
    id: json["id"],
    empId: json["emp_id"],
    dateTime: DateTime.parse(json["date_time"]),
    from: DateTime.parse(json["from"]),
    to: DateTime.parse(json["to"]),
    leaveType: json["leave_type"],
    reasonOfLeave: json["reason_of_leave"],
    status: json["status"],
    totalDays: json["total_days"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "emp_id": empId,
    "date_time": dateTime.toIso8601String(),
    "from": from.toIso8601String(),
    "to": to.toIso8601String(),
    "leave_type": leaveType,
    "reason_of_leave": reasonOfLeave,
    "status": status,
    "total_days": totalDays,
  };

  int getTotalLeaveDays() {
    return this.totalDays;
  }
}