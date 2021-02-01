import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:unplan/ui/views/home_log_view.dart';
import 'package:unplan/ui/views/home_stats_view.dart';
import 'package:unplan/utils/date_time_format.dart';
import 'package:unplan/utils/text_styles.dart';
import 'package:unplan/utils/utils.dart';
import 'package:unplan/view_models/home_view_model.dart';
import 'package:timezone/data/latest.dart' as tzd;

class HomeView extends StatefulWidget {
  final String name;

  const HomeView({Key key, this.name}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.nonReactive(
      viewModelBuilder: () => HomeViewModel(),
      fireOnModelReadyOnce: true,
      onModelReady: (model) async {
        model.initialise();
        tzd.initializeTimeZones();
        model.initializeNotification();
      },
      builder: (context, model, child) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3.8,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, top: 80.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder(
                      future: model.getName(),
                      builder: (context, snapshot) {
                        return RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(text: Utils.HI, style: TextStyles.homeTitle),
                              snapshot.hasData
                                  ? TextSpan(text: '${snapshot.data}', style: TextStyles.homeTitle)
                                  : TextSpan(text: ''),
                              TextSpan(text: Utils.COMMA, style: TextStyles.homeTitle),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      DateTimeFormat.homeDate(),
                      style: TextStyles.homeSubTitle,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 3.6,
              width: double.infinity,
              child: HomeLogView(),
            ),
            Container(
              height: 300,
              child: HomeStatsView(),
            ),
          ],
        ),
      ),
    );
  }
}
