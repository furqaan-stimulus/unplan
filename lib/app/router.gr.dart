// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../ui/views/bottom_sheet_view.dart';
import '../ui/views/home_data_view.dart';
import '../ui/views/home_log_view.dart';
import '../ui/views/home_stats_view.dart';
import '../ui/views/home_view.dart';
import '../ui/views/login_view.dart';
import '../ui/views/splash_view.dart';

class Routes {
  static const String splashView = '/';
  static const String loginView = '/login-view';
  static const String homeView = '/home-view';
  static const String homeStatsView = '/home-stats-view';
  static const String bottomSheetView = '/bottom-sheet-view';
  static const String homeLogView = '/home-log-view';
  static const String homeDataView = '/home-data-view';
  static const all = <String>{
    splashView,
    loginView,
    homeView,
    homeStatsView,
    bottomSheetView,
    homeLogView,
    homeDataView,
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
    RouteDef(Routes.bottomSheetView, page: BottomSheetView),
    RouteDef(Routes.homeLogView, page: HomeLogView),
    RouteDef(Routes.homeDataView, page: HomeDataView),
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
      final args = data.getArgs<HomeViewArguments>(
        orElse: () => HomeViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeView(
          key: args.key,
          name: args.name,
        ),
        settings: data,
      );
    },
    HomeStatsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeStatsView(),
        settings: data,
      );
    },
    BottomSheetView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => BottomSheetView(),
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
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// HomeView arguments holder class
class HomeViewArguments {
  final Key key;
  final String name;
  HomeViewArguments({this.key, this.name});
}
