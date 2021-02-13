import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:unplan/utils/text_styles.dart';
import 'package:unplan/utils/utils.dart';
import 'package:unplan/utils/view_color.dart';
import 'package:unplan/view_models/leave_form_view_model.dart';

class LeaveFormView extends StatefulWidget {
  @override
  _LeaveFormViewState createState() => _LeaveFormViewState();
}

class _LeaveFormViewState extends State<LeaveFormView> {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();
  DateTime selectStartDate = DateTime.now();
  DateTime selectEndDate = DateTime.now();

  final dateController = TextEditingController();
  final dateController1 = TextEditingController();
  final reasonController = TextEditingController();

  final List<String> type = ['Paid Leave', 'Sick Leave', 'Unpaid Leave'];
  String _currentType = 'Unpaid Leave';
  FocusNode reasonFocus;
  FocusNode submitFocus;
  FocusNode startFocus;
  FocusNode endFocus;
  FocusNode typeFocus;

  @override
  void initState() {
    super.initState();
    reasonFocus = FocusNode();
    submitFocus = FocusNode();
    startFocus = FocusNode();
    endFocus = FocusNode();
    typeFocus = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    reasonFocus.dispose();
    submitFocus.dispose();
    endFocus.dispose();
    typeFocus.dispose();
    startFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return ViewModelBuilder<LeaveFormViewModel>.reactive(
      viewModelBuilder: () => LeaveFormViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: ViewColor.background_white_color,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            child: SingleChildScrollView(
              key: _scaffoldState,
              reverse: true,
              physics: ScrollPhysics(),
              padding: EdgeInsets.only(bottom: bottom),
              child: Wrap(
                runSpacing: 10.0,
                children: [
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'From',
                                style: TextStyles.leaveText3,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 220,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: ViewColor.text_grey_color,
                                    ),
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        _selectStartDate(context);
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10.0),
                                            child: Text(
                                              "${selectStartDate.toLocal()}".split(' ')[0],
                                              style: TextStyles.leaveText4,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 15.0),
                                            child: Icon(
                                              Icons.calendar_today,
                                              size: 40,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'To',
                                style: TextStyles.leaveText3,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 220,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: ViewColor.text_grey_color,
                                    ),
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        _selectEndDate(context);
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10.0),
                                            child: Text(
                                              "${selectEndDate.toLocal()}".split(' ')[0],
                                              style: TextStyles.leaveText4,
                                            ),
                                          ),
                                          // SvgPicture.asset(
                                          //   'assets/calender.svg',
                                          //   height: 30,
                                          //   width: 30,
                                          //   color: ViewColor.text_black_color,
                                          // )
                                          Padding(
                                            padding: const EdgeInsets.only(right: 15.0),
                                            child: Icon(
                                              Icons.calendar_today,
                                              size: 40,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Type',
                                style: TextStyles.leaveText3,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 220,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: ViewColor.text_grey_color,
                                    ),
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          elevation: 16,
                                          items: type.map((type) {
                                            return DropdownMenuItem(
                                              child: Text(
                                                '$type',
                                                style: TextStyles.leaveText4,
                                              ),
                                              value: type,
                                            );
                                          }).toList(),
                                          onChanged: (String newValue) {
                                            setState(() {
                                              _currentType = newValue;
                                            });
                                          },
                                          value: _currentType,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Reason',
                                style: TextStyles.leaveText3,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 220,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: ViewColor.text_grey_color,
                                    ),
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: TextFormField(
                                        style: TextStyles.leaveText4,
                                        focusNode: reasonFocus,
                                        maxLines: 5,
                                        enabled: true,
                                        textInputAction: TextInputAction.next,
                                        // onFieldSubmitted: (term) {
                                        //   reasonFocus.unfocus();
                                        //   FocusScope.of(context).requestFocus();
                                        // },
                                        controller: reasonController,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return Utils.msgReason;
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            width: double.infinity,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              // focusNode: submitFocus,
                              child: Text(
                                "apply",
                                style: TextStyles.buttonTextStyle1,
                              ),
                              textColor: Colors.white,
                              padding: const EdgeInsets.fromLTRB(20.0, 14.0, 20.0, 14.0),
                              onPressed: () {
                                FocusManager.instance.primaryFocus.unfocus();
                                if (_formKey.currentState.validate()) {
                                  model.postLeave(_currentType.toString(), selectStartDate.toString(),
                                      selectEndDate.toString(), reasonController.text);
                                  reasonController.clear();
                                  Flushbar(
                                    messageText: Center(
                                      child: Text(
                                        "Your leave is Submitted",
                                        style: TextStyles.notificationTextStyle1,
                                      ),
                                    ),
                                    backgroundColor: ViewColor.notification_green_color,
                                    flushbarPosition: FlushbarPosition.TOP,
                                    flushbarStyle: FlushbarStyle.FLOATING,
                                    duration: Duration(seconds: 2),
                                  )..show(context);
                                } else {
                                  Flushbar(
                                    messageText: Center(
                                      child: Text(
                                        "Something went wrong",
                                        style: TextStyles.notificationTextStyle1,
                                      ),
                                    ),
                                    backgroundColor: ViewColor.text_black_color,
                                    flushbarPosition: FlushbarPosition.TOP,
                                    flushbarStyle: FlushbarStyle.FLOATING,
                                    duration: Duration(seconds: 2),
                                  )..show(context);
                                }
                              },
                              color: ViewColor.button_green_color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _selectStartDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      helpText: 'Select start date of leave',
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(), // This will change to light theme.
          child: child,
        );
      },
    );
    if (picked != null && picked != selectStartDate) {
      setState(() {
        selectStartDate = picked;
      });
    }
  }

  _selectEndDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      helpText: 'Select end date of leave',
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(), // This will change to light theme.
          child: child,
        );
      },
    );
    if (picked != null && picked != selectEndDate) {
      setState(() {
        selectEndDate = picked;
      });
    }
  }
}
