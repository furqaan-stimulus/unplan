import 'package:auto_route/auto_route_annotations.dart';
import 'package:unplan/ui/views/attendance_log_control_view.dart';
import 'package:unplan/ui/views/drawer_view.dart';
import 'package:unplan/ui/views/employee_info_view.dart';
import 'package:unplan/ui/views/home_data_view.dart';
import 'package:unplan/ui/views/home_log_view.dart';
import 'package:unplan/ui/views/home_stats_view.dart';
import 'package:unplan/ui/views/home_view.dart';
import 'package:unplan/ui/views/leave_form_view.dart';
import 'package:unplan/ui/views/leave_list_log_view.dart';
import 'package:unplan/ui/views/leave_list_view.dart';
import 'package:unplan/ui/views/leaves_view.dart';
import 'package:unplan/ui/views/login_view.dart';
import 'package:unplan/ui/views/personal_info_view.dart';
import 'package:unplan/ui/views/splash_view.dart';

@MaterialAutoRouter(routes: <AutoRoute>[
  MaterialRoute(page: SplashView, initial: true),
  MaterialRoute(page: LoginView),
  MaterialRoute(page: HomeView),
  MaterialRoute(page: HomeStatsView),
  MaterialRoute(page: HomeLogView),
  MaterialRoute(page: HomeDataView),
  MaterialRoute(page: PersonalInfoView),
  MaterialRoute(page: EmployeeInfoView),
  MaterialRoute(page: LeavesView),
  MaterialRoute(page: DrawerView),
  MaterialRoute(page: LeaveFormView),
  MaterialRoute(page: LeaveListView),
  MaterialRoute(page: LeaveListLogView),
  MaterialRoute(page: AttendanceLogControlView),
])
class $Router {}
