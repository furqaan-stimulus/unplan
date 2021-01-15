import 'package:auto_route/auto_route_annotations.dart';
import 'package:unplan/ui/views/bottom_sheet_view.dart';
import 'package:unplan/ui/views/home_data_view.dart';
import 'package:unplan/ui/views/home_log_view.dart';
import 'package:unplan/ui/views/home_stats_view.dart';
import 'package:unplan/ui/views/home_view.dart';
import 'package:unplan/ui/views/login_view.dart';
import 'package:unplan/ui/views/splash_view.dart';

@MaterialAutoRouter(routes: <AutoRoute>[
  MaterialRoute(page: SplashView, initial: true),
  MaterialRoute(page: LoginView),
  MaterialRoute(page: HomeView),
  MaterialRoute(page: HomeStatsView),
  MaterialRoute(page: BottomSheetView),
  MaterialRoute(page: HomeLogView),
  MaterialRoute(page: HomeDataView),
])
class $Router {}
