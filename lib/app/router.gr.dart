// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../ui/views/bottom_sheet_view.dart';
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
  static const all = <String>{
    splashView,
    loginView,
    homeView,
    homeStatsView,
    bottomSheetView,
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
        builder: (context) => HomeView(),
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
  };
}
