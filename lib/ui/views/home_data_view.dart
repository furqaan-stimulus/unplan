import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:unplan/enum/log_type.dart';
import 'package:unplan/ui/views/home_log_view.dart';
import 'package:unplan/utils/text_styles.dart';
import 'package:unplan/utils/view_color.dart';
import 'package:unplan/view_models/home_data_view_model.dart';

class HomeDataView extends StatefulWidget {
  @override
  _HomeDataViewState createState() => _HomeDataViewState();
}

class _HomeDataViewState extends State<HomeDataView> {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();

    var format2 = DateFormat('h:mm').format(now);
    return ViewModelBuilder<HomeDataViewModel>.reactive(
      viewModelBuilder: () => HomeDataViewModel(),
      onModelReady: (model) {
        HomeLogView();
        model.getLastDateTime();
      },
      builder: (context, model, child) => Scaffold(
        backgroundColor: ViewColor.background_purple_color,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.0,
            ),
            Center(
              child: FutureBuilder(
                future: model.getLogType(),
                builder: (context, snapLog) {
                  if (snapLog.hasData) {
                    return FutureBuilder(
                      future: model.getLastDateTime(),
                      builder: (context, snapDate) {
                        if (snapDate.hasData) {
                          return RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(text: 'Last ', style: TextStyles.homeText),
                                (snapLog.data == LogType.clockOut || snapLog.data == 'break')
                                    ? TextSpan(text: 'Clock-Out : ', style: TextStyles.homeText)
                                    : TextSpan(text: 'Clock-In : ', style: TextStyles.homeText),
                                TextSpan(text: '${snapDate.data}', style: TextStyles.homeText),
                              ],
                            ),
                          );
                        } else {
                          return Text('');
                        }
                      },
                    );
                  } else {
                    return Text('');
                  }
                },
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: 'Hours Today: ', style: TextStyles.homeText1),
                    TextSpan(text: '00:00 Hrs', style: TextStyles.homeText1),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Center(
              child: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: 'Avg. This Month: ', style: TextStyles.homeText1),
                    TextSpan(text: '08:12 Hrs', style: TextStyles.homeText1),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
