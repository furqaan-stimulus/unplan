import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:unplan/ui/views/home_log_view.dart';
import 'package:unplan/utils/date_time_format.dart';
import 'package:unplan/utils/text_styles.dart';
import 'package:unplan/utils/utils.dart';
import 'package:unplan/utils/view_color.dart';
import 'package:unplan/view_models/home_data_view_model.dart';

class HomeDataView extends StatefulWidget {
  @override
  _HomeDataViewState createState() => _HomeDataViewState();
}

class _HomeDataViewState extends State<HomeDataView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeDataViewModel>.reactive(
      viewModelBuilder: () => HomeDataViewModel(),
      onModelReady: (model) {
        HomeLogView();
        model.initialise();
      },
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: ViewColor.background_purple_color,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: (model.logs.length == 0)
                    ? Text('')
                    : RichText(
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(text: Utils.last, style: TextStyles.homeText),
                          (model.logs.last.type == "clock-out" || model.logs.last.type == "break")
                              ? TextSpan(text: Utils.homeOut, style: TextStyles.homeText)
                              : TextSpan(text: Utils.homeIn, style: TextStyles.homeText),
                          (model.logs.last.type == "clock-out" || model.logs.last.type == "break")
                              ? TextSpan(
                                  text: DateTimeFormat.formatDateTime(model.logs.last.dateTime.toString()),
                                  style: TextStyles.homeText)
                              : TextSpan(
                                  text: DateTimeFormat.formatDateTime(model.logs.last.dateTime.toString()),
                                  style: TextStyles.homeText),
                        ]),
                      ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: Utils.hourToday, style: TextStyles.homeText1),
                      TextSpan(text: '00:00', style: TextStyles.homeText1),
                      TextSpan(text: Utils.Hrs, style: TextStyles.homeText1),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: Utils.avgMonth, style: TextStyles.homeText1),
                      TextSpan(text: '08:12', style: TextStyles.homeText1),
                      TextSpan(text: Utils.Hrs, style: TextStyles.homeText1),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
