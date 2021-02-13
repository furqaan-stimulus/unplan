class EmployeeInformation {
  EmployeeInformation({
    this.id,
    this.joiningDate,
    this.probetion,
    this.empType,
    this.scLeave,
    this.sickLeave,
  });

  int id;
  dynamic joiningDate;
  int probetion;
  String empType;
  int scLeave;
  int sickLeave;

  factory EmployeeInformation.fromJson(Map<String, dynamic> json) => EmployeeInformation(
        id: json["id"],
        joiningDate: json["joining_date"] == null ? null : DateTime.parse(json["joining_date"]),
        probetion: json["probetion"],
        empType: json["emp_type"],
        scLeave: json["sc_leave"],
        sickLeave: json["sick_leave"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "joining_date": joiningDate,
        "probetion": probetion,
        "emp_type": empType,
        "sc_leave": scLeave,
        "sick_leave": sickLeave,
      };
}
