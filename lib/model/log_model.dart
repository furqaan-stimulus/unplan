import 'package:unplan/enum/log_type.dart';

class LogModel {
  LogType type;
  int time;
  int dateWithMinutes;

  LogModel({
    this.type,
    this.time,
    this.dateWithMinutes,
  });

  DateTime getDate() {
    return DateTime.fromMillisecondsSinceEpoch(this.time);
  }

  DateTime getDateWithMinutes() {
    return DateTime.fromMillisecondsSinceEpoch(this.dateWithMinutes);
  }
}
