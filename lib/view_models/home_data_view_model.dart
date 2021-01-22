import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:unplan/enum/log_type.dart';

class HomeDataViewModel extends BaseViewModel {
  String _logType;

  String get logType => _logType;

  DateTime _lastDateTime;

  DateTime get lastDateTime => _lastDateTime;

  Future getLogType() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _logType = preferences.getString('type');
    notifyListeners();
    return _logType;
  }

  Future getLastDateTime() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String tiny = preferences.getString('date_time');
    var p = DateTime.parse(tiny);
    var format = DateFormat('h:mm a, d MMM');
    var s = format.format(p);
    notifyListeners();
    return s;
  }
}
