class EmployeeInformation {
  EmployeeInformation({
    this.id,
    this.joiningDate,
    this.probetion,
    this.empType,
    this.paidLeave,
    this.sickLeave,
    this.totalDays,
  });

  int id;
  dynamic joiningDate;
  int probetion;
  String empType;
  int paidLeave;
  int sickLeave;
  int totalDays;

  factory EmployeeInformation.fromJson(Map<String, dynamic> json) => EmployeeInformation(
        id: json["id"],
        joiningDate: json["joining_date"] == null ? null : DateTime.parse(json["joining_date"]),
        probetion: json["probetion"],
        empType: json["emp_type"],
        paidLeave: json["unsc_leave"],
        sickLeave: json["sick_leave"],
        totalDays: json["total_days"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "joining_date": joiningDate,
        "probetion": probetion,
        "emp_type": empType,
        "unsc_leave": paidLeave,
        "sick_leave": sickLeave,
        "total_days": totalDays,
      };
}
