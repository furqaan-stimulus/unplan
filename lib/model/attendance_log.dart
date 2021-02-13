class AttendanceLog {
  AttendanceLog({
    this.id,
    this.empId,
    this.dateTime,
    this.time,
    this.date,
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
  DateTime date;
  String type;
  String location;
  dynamic totalHour;
  dynamic avgHour;
  String curruntLat;
  String curruntLong;
  DateTime createdAt;
  DateTime updatedAt;

  factory AttendanceLog.fromJson(Map<String, dynamic> json) => AttendanceLog(
        id: json["id"],
        empId: json["emp_id"],
        dateTime: json["date_time"] == null ? null : DateTime.parse(json["date_time"]),
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        type: json["type"],
        location: json["location"],
        totalHour: json["total_hour"],
        avgHour: json["avg_hour"],
        curruntLat: json["currunt_lat"],
        curruntLong: json["currunt_long"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "emp_id": empId,
        "date_time": dateTime.toIso8601String(),
        "time": time.toIso8601String(),
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "type": type,
        "location": location,
        "total_hour": totalHour,
        "avg_hour": avgHour,
        "currunt_lat": curruntLat,
        "currunt_long": curruntLong,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };

// DateTime getDateWithMinutes() {
//   int cltime = DateTime.parse(this.dateTime.toString()).millisecondsSinceEpoch;
//   return DateTime.fromMillisecondsSinceEpoch(cltime);
// }
}
