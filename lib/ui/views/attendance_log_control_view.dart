import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stacked/stacked.dart';
import 'package:unplan/utils/text_styles.dart';
import 'package:unplan/utils/utils.dart';
import 'package:unplan/utils/view_color.dart';
import 'package:unplan/view_models/attendance_log_control_view_model.dart';
import 'package:unplan/widgets/show_icon.dart';
import 'package:unplan/widgets/show_location.dart';
import 'package:unplan/widgets/show_log_buttons.dart';
import 'package:unplan/widgets/show_log_text.dart';
import 'package:unplan/widgets/show_time_difference.dart';

class AttendanceLogControlView extends StatefulWidget {
  const AttendanceLogControlView({
    Key key,
  }) : super(
          key: key,
        );

  @override
  _AttendanceLogControlViewState createState() => _AttendanceLogControlViewState();
}

class _AttendanceLogControlViewState extends State<AttendanceLogControlView> {
  double officeDist;
  double homeDist;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AttendanceLogControlViewModel>.reactive(
      viewModelBuilder: () => AttendanceLogControlViewModel(),
      onModelReady: (model) {
        model.initialise();
        model.getLogType();
        model.getCurrentLocation();
        model.getAddressFromLatLng();
        model.fetchLogs();
        model.fetchAddress();
      },
      createNewModelOnInsert: true,
      builder: (context, model, child) {
        if (double.parse((model.addressDetail.first.officeLatitude)) == null &&
                double.parse((model.addressDetail.first.officeLongitude)) == null ||
            double.parse((model.addressDetail.first.homeLatitude)) == null &&
                double.parse((model.addressDetail.first.homeLongitude)) == null) {
          officeDist = Geolocator.distanceBetween(
            model.currentPosition.latitude,
            model.currentPosition.longitude,
            model.currentPosition.latitude,
            model.currentPosition.longitude,
          );
          homeDist = Geolocator.distanceBetween(
            model.currentPosition.latitude,
            model.currentPosition.longitude,
            model.currentPosition.latitude,
            model.currentPosition.longitude,
          );
        } else {
          officeDist = Geolocator.distanceBetween(
              double.parse((model.addressDetail.first.officeLatitude)),
              double.parse((model.addressDetail.first.officeLongitude)),
              model.currentPosition.latitude,
              model.currentPosition.longitude);
          homeDist = Geolocator.distanceBetween(
              double.parse((model.addressDetail.first.homeLatitude)),
              double.parse((model.addressDetail.first.homeLongitude)),
              model.currentPosition.latitude,
              model.currentPosition.longitude);
        }
        if (model.currentPosition == null) {
          return Container(
            height: 300,
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(25.0),
                topRight: const Radius.circular(25.0),
              ),
            ),
            child: Center(
              child: Text('no location detected'),
            ),
          );
        } else {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            width: double.infinity,
            child: FlatButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              color: (model.logType == null)
                  ? ViewColor.button_grey_color
                  : (model.logs.last.type == Utils.CLOCKOUT || model.logs.last.type == Utils.TIMEOUT)
                      ? ViewColor.button_green_color
                      : ViewColor.button_grey_color,
              onPressed: () {
                model.getCurrentLocation();
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return Container(
                      height: 300,
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(25.0),
                          topRight: const Radius.circular(25.0),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          ShowIcon(
                            officeDist: officeDist,
                            homeDist: homeDist,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ShowLogText(
                            homeDist: homeDist,
                            officeDist: officeDist,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          ShowLocation(
                            homeDist: homeDist,
                            officeDist: officeDist,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          (model.currentPosition != null)
                              ? (officeDist <= 10.0)
                                  ? Text(
                                      model.currentAddress,
                                      style: TextStyles.bottomTextStyle2,
                                    )
                                  : (homeDist <= 10.0)
                                      ? Text(
                                          model.currentAddress,
                                          style: TextStyles.bottomTextStyle2,
                                        )
                                      : Text(
                                          model.currentAddress,
                                          style: TextStyles.bottomTextStyle2,
                                        )
                              : Text(''),
                          SizedBox(
                            height: 10,
                          ),
                          ShowTimeDifference(
                            homeDist: homeDist,
                            officeDist: officeDist,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ShowLogButtons(
                            homeDist: homeDist,
                            officeDist: officeDist,
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: (model.logType == null)
                    ? Text(
                        Utils.buttonIn,
                        style: TextStyles.buttonTextStyle2,
                      )
                    : (model.logs.last.type == Utils.CLOCKOUT || model.logs.last.type == Utils.TIMEOUT)
                        ? Text(
                            Utils.buttonOut,
                            style: TextStyles.buttonTextStyle2,
                          )
                        : Text(
                            Utils.buttonIn,
                            style: TextStyles.buttonTextStyle2,
                          ),
              ),
            ),
          );
        }
      },
    );
  }
}
