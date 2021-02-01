import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:unplan/utils/text_styles.dart';
import 'package:unplan/utils/utils.dart';
import 'package:unplan/view_models/home_stats_view_model.dart';

class HomeStatsView extends StatefulWidget {
  @override
  _HomeStatsViewState createState() => _HomeStatsViewState();
}

class _HomeStatsViewState extends State<HomeStatsView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => HomeStatsViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 30.0, top: 35.0, right: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Utils.statTitle0,
                style: TextStyles.homeBottomText,
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Utils.statSub1,
                        style: TextStyles.bottomTextStyle2,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '13',
                        style: TextStyles.homeText2,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Utils.statSub2,
                        style: TextStyles.bottomTextStyle2,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '13',
                        style: TextStyles.homeText2,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Utils.statSub3,
                        style: TextStyles.bottomTextStyle2,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '13',
                        style: TextStyles.homeText2,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                Utils.statTitle1,
                style: TextStyles.homeBottomText,
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 35.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Utils.statSub4,
                          style: TextStyles.bottomTextStyle2,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '12',
                          style: TextStyles.homeText2,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Utils.statSub5,
                            style: TextStyles.bottomTextStyle2,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '4',
                            style: TextStyles.homeText2,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Utils.statSub6,
                          style: TextStyles.bottomTextStyle2,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '4',
                          style: TextStyles.homeText2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
