import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:unplan/ui/views/drawer_view.dart';
import 'package:unplan/ui/views/leave_list_log_view.dart';
import 'package:unplan/utils/text_styles.dart';
import 'package:unplan/utils/utils.dart';
import 'package:unplan/utils/view_color.dart';
import 'package:unplan/view_models/leave_list_view_model.dart';

class LeaveListView extends StatefulWidget {
  @override
  _LeaveListViewState createState() => _LeaveListViewState();
}

class _LeaveListViewState extends State<LeaveListView> {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LeaveListViewModel>.reactive(
      viewModelBuilder: () => LeaveListViewModel(),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => Scaffold(
        key: _scaffoldState,
        backgroundColor: ViewColor.background_white_color,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 30, top: 70.0, right: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: SvgPicture.asset(
                        "assets/svg/hamburger.svg",
                        width: 40,
                      ),
                      onTap: () {
                        _scaffoldState.currentState.openDrawer();
                      },
                    ),
                    Container(
                      child: GestureDetector(
                        onTap: () {
                          model.navigateTOHomeView();
                        },
                        child: SvgPicture.asset("assets/svg/cancel.svg"),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
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
                  height: 20,
                ),
                Text(
                  'leave balance',
                  style: TextStyles.personalPageText,
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 80,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: ViewColor.text_grey_footer_color,
                      ),
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              Utils.statSub4,
                              style: TextStyles.leaveText1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 2.0),
                            child: Container(
                              width: 40,
                              height: 40,
                              child: Center(
                                child: Text(
                                  '04',
                                  style: TextStyles.leaveText,
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: ViewColor.text_white_color,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 80,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: ViewColor.text_grey_footer_color,
                      ),
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              Utils.statSub6,
                              style: TextStyles.leaveText1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 2.0),
                            child: Container(
                              width: 40,
                              height: 40,
                              child: Center(
                                child: Text(
                                  '03',
                                  style: TextStyles.leaveText,
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: ViewColor.text_white_color,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'leave applications',
                      style: TextStyles.personalPageText,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/svg/filter.svg",
                        ),
                        Text(
                          'this year',
                          style: TextStyles.leaveText2,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  color: ViewColor.text_grey_color,
                  thickness: 2,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Applied",
                        style: TextStyles.leaveText3,
                      ),
                      Text(
                        "Duration",
                        style: TextStyles.leaveText3,
                      ),
                      Text(
                        "Type",
                        style: TextStyles.leaveText3,
                      ),
                      Text(
                        "Status",
                        style: TextStyles.leaveText3,
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: ViewColor.text_grey_color,
                  thickness: 2,
                ),
                Expanded(
                  child: LeaveListLogView(),
                ),
              ],
            ),
          ),
        ),
        drawer: DrawerView(),
      ),
    );
  }
}
