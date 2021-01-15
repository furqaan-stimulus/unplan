import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:unplan/ui/views/home_data_view.dart';
import 'package:unplan/utils/text_styles.dart';
import 'package:unplan/utils/view_color.dart';
import 'package:unplan/view_models/home_log_view_model.dart';

class HomeLogView extends StatefulWidget {
  @override
  _HomeLogViewState createState() => _HomeLogViewState();
}

class _HomeLogViewState extends State<HomeLogView> {
  bool isClicked = true;

  void _isBtnClicked() {
    setState(() {
      isClicked = !isClicked;
    });
  }

  @override
  Widget build(BuildContext context) {
    // var userLocation = Provider.of<LocationModel>(context);
    return ViewModelBuilder<HomeLogViewModel>.reactive(
      viewModelBuilder: () => HomeLogViewModel(),
      onModelReady: (model) async {},
      builder: (context, model, child) => Scaffold(
        body: Container(
          color: ViewColor.background_purple_color,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 35.0,
                  right: 35.0,
                  top: 40.0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: double.infinity,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    color: isClicked
                        ? ViewColor.button_grey_color
                        : ViewColor.button_green_color,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => Container(
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
                              SvgPicture.asset(
                                'assets/svg/home.svg',
                                height: 45,
                                width: 45,
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              isClicked
                                  ? Text(
                                      'You are',
                                      style: TextStyles.buttonTextStyle2,
                                    )
                                  : Text(
                                      'Logging out from',
                                      style: TextStyles.buttonTextStyle2,
                                    ),
                              SizedBox(
                                height: 5.0,
                              ),
                              isClicked
                                  ? Text(
                                      'Working From Home',
                                      style: TextStyles.bottomTextStyle,
                                    )
                                  : Text(
                                      'Home',
                                      style: TextStyles.bottomTextStyle,
                                    ),
                              SizedBox(
                                height: 5.0,
                              ),
                              // (userLocation.longitude == null &&
                              //         userLocation?.latitude == null)
                              //     ? Text('getting location...')
                              //     : Text(
                              //         'long:${userLocation.longitude},lat:${userLocation.latitude}',
                              //         style: TextStyles.bottomTextStyle2,
                              //       ),
                              Text(
                                "Naranpura, Ahmedabad",
                                style: TextStyles.bottomTextStyle2,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              isClicked
                                  ? Text(
                                      'ON TIME',
                                      style: TextStyles.bottomTextStyle3,
                                    )
                                  : Text(''),
                              SizedBox(
                                height: 20.0,
                              ),
                              isClicked
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          left: 30.0, right: 30.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        width: double.infinity,
                                        child: FlatButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Text(
                                            "CONFIRM",
                                            style: TextStyles.bottomButtonText,
                                          ),
                                          textColor: Colors.white,
                                          padding: EdgeInsets.all(16),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            _isBtnClicked();
                                            Flushbar(
                                              messageText: Center(
                                                child: Text(
                                                  "Clocked In Successfully!",
                                                  style: TextStyles
                                                      .notificationTextStyle1,
                                                ),
                                              ),
                                              backgroundColor: ViewColor
                                                  .notification_green_color,
                                              flushbarPosition:
                                                  FlushbarPosition.TOP,
                                              flushbarStyle:
                                                  FlushbarStyle.FLOATING,
                                              duration: Duration(seconds: 2),
                                            )..show(context);
                                          },
                                          color:
                                              ViewColor.background_purple_color,
                                        ),
                                      ),
                                    )
                                  : Center(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            width: 160,
                                            child: FlatButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Text(
                                                "BREAK",
                                                style:
                                                    TextStyles.bottomButtonText,
                                              ),
                                              textColor: Colors.white,
                                              padding: EdgeInsets.all(16),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                _isBtnClicked();
                                                Flushbar(
                                                  messageText: Center(
                                                    child: Text(
                                                      " Taking Break!",
                                                      style: TextStyles
                                                          .notificationTextStyle1,
                                                    ),
                                                  ),
                                                  backgroundColor: ViewColor
                                                      .notification_green_color,
                                                  flushbarPosition:
                                                      FlushbarPosition.TOP,
                                                  flushbarStyle:
                                                      FlushbarStyle.FLOATING,
                                                  duration:
                                                      Duration(seconds: 2),
                                                )..show(context);
                                              },
                                              color: ViewColor
                                                  .background_purple_color,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            width: 160,
                                            child: FlatButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Text(
                                                "SIGN OFF",
                                                style:
                                                    TextStyles.buttonTextStyle1,
                                              ),
                                              textColor: Colors.white,
                                              padding: EdgeInsets.all(16),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                _isBtnClicked();
                                                Flushbar(
                                                  messageText: Center(
                                                    child: Text(
                                                      "Clocked Out Successfully!",
                                                      style: TextStyles
                                                          .notificationTextStyle1,
                                                    ),
                                                  ),
                                                  backgroundColor: ViewColor
                                                      .notification_green_color,
                                                  flushbarPosition:
                                                      FlushbarPosition.TOP,
                                                  flushbarStyle:
                                                      FlushbarStyle.FLOATING,
                                                  duration:
                                                      Duration(seconds: 2),
                                                )..show(context);
                                              },
                                              color:
                                                  ViewColor.button_green_color,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: isClicked
                          ? Text(
                              'CLOCK-IN',
                              style: TextStyles.buttonTextStyle2,
                            )
                          : Text(
                              'CLOCK-OUT',
                              style: TextStyles.buttonTextStyle2,
                            ),
                    ),
                  ),
                ),
              ),
              Container(height: 100, child: HomeDataView()),
            ],
          ),
        ),
      ),
    );
  }

// Future _getCurrentLocation() async {
//   Future.delayed(Duration(microseconds: 500));
//   Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
//       .then((Position position) {
//     setState(() {
//       _currentPosition = position;
//     });
//     _getAddressFromLatLng();
//   }).catchError((e) {
//     print(e);
//   });
// }
//
// Future _getAddressFromLatLng() async {
//   Future.delayed(Duration(seconds: 1));
//   try {
//     List<Placemark> p = await placemarkFromCoordinates(
//         _currentPosition.latitude, _currentPosition.longitude);
//     print("${_currentPosition.latitude} ${_currentPosition.longitude}");
//     Placemark place = p[0];
//     setState(() {
//       _currentAddress = "${place.subLocality}, ${place.locality},";
//     });
//   } catch (e) {
//     print(e);
//   }
// }
}
