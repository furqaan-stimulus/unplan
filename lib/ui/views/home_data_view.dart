import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
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
    return ViewModelBuilder<HomeDataViewModel>.reactive(
      viewModelBuilder: () => HomeDataViewModel(),
      onModelReady: (model) {
        HomeLogView();
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
              child: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Last Clock-Out: ', style: TextStyles.homeText),
                    TextSpan(text: '20:22, 06 JAN', style: TextStyles.homeText),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Hours Today: ', style: TextStyles.homeText1),
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
                    TextSpan(
                        text: 'Avg. This Month: ', style: TextStyles.homeText1),
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
