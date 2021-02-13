// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../ui/views/attendance_log_control_view.dart';
import '../ui/views/drawer_view.dart';
import '../ui/views/employee_info_view.dart';
import '../ui/views/home_data_view.dart';
import '../ui/views/home_log_view.dart';
import '../ui/views/home_stats_view.dart';
import '../ui/views/home_view.dart';
import '../ui/views/leave_form_view.dart';
import '../ui/views/leave_list_log_view.dart';
import '../ui/views/leave_list_view.dart';
import '../ui/views/leaves_view.dart';
import '../ui/views/login_view.dart';
import '../ui/views/personal_info_view.dart';
import '../ui/views/splash_view.dart';

class Routes {
  static const String splashView = '/';
  static const String loginView = '/login-view';
  static const String homeView = '/home-view';
  static const String homeStatsView = '/home-stats-view';
  static const String homeLogView = '/home-log-view';
  static const String homeDataView = '/home-data-view';
  static const String personalInfoView = '/personal-info-view';
  static const String employeeInfoView = '/employee-info-view';
  static const String leavesView = '/leaves-view';
  static const String drawerView = '/drawer-view';
  static const String leaveFormView = '/leave-form-view';
  static const String leaveListView = '/leave-list-view';
  static const String leaveListLogView = '/leave-list-log-view';
  static const String attendanceLogControlView = '/attendance-log-control-view';
  static const all = <String>{
    splashView,
    loginView,
    homeView,
    homeStatsView,
    homeLogView,
    homeDataView,
    personalInfoView,
    employeeInfoView,
    leavesView,
    drawerView,
    leaveFormView,
    leaveListView,
    leaveListLogView,
    attendanceLogControlView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashView, page: SplashView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.homeStatsView, page: HomeStatsView),
    RouteDef(Routes.homeLogView, page: HomeLogView),
    RouteDef(Routes.homeDataView, page: HomeDataView),
    RouteDef(Routes.personalInfoView, page: PersonalInfoView),
    RouteDef(Routes.employeeInfoView, page: EmployeeInfoView),
    RouteDef(Routes.leavesView, page: LeavesView),
    RouteDef(Routes.drawerView, page: DrawerView),
    RouteDef(Routes.leaveFormView, page: LeaveFormView),
    RouteDef(Routes.leaveListView, page: LeaveListView),
    RouteDef(Routes.leaveListLogView, page: LeaveListLogView),
    RouteDef(Routes.attendanceLogControlView, page: AttendanceLogControlView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    SplashView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SplashView(),
        settings: data,
      );
    },
    LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginView(),
        settings: data,
      );
    },
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const HomeView(),
        settings: data,
      );
    },
    HomeStatsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeStatsView(),
        settings: data,
      );
    },
    HomeLogView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeLogView(),
        settings: data,
      );
    },
    HomeDataView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeDataView(),
        settings: data,
      );
    },
    PersonalInfoView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => PersonalInfoView(),
        settings: data,
      );
    },
    EmployeeInfoView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => EmployeeInfoView(),
        settings: data,
      );
    },
    LeavesView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LeavesView(),
        settings: data,
      );
    },
    DrawerView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => DrawerView(),
        settings: data,
      );
    },
    LeaveFormView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LeaveFormView(),
        settings: data,
      );
    },
    LeaveListView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LeaveListView(),
        settings: data,
      );
    },
    LeaveListLogView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LeaveListLogView(),
        settings: data,
      );
    },
    AttendanceLogControlView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const AttendanceLogControlView(),
        settings: data,
      );
    },
  };
}
