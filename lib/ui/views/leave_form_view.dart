import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:unplan/utils/date_time_format.dart';
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
  DateTime selectStartDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2);
  DateTime selectEndDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2);

  final dateController = TextEditingController();
  final dateController1 = TextEditingController();
  final reasonController = TextEditingController();

  final List<String> type = ['Paid Leave', 'Sick Leave', 'Unpaid Leave'];
  String _currentType = 'Unpaid Leave';
  FocusNode reasonFocus;
  FocusNode submitFocus;
  FocusNode typeFocus;

  bool showFailMessage = false;
  bool showSuccessMessage = false;
  bool cutOffMessage = false;
  bool beforeErrorMessage = false;
  bool typeErrorMessage = false;
  bool typeErrorMessage1 = false;
  bool wordErrorMessage = false;

  @override
  void initState() {
    super.initState();
    reasonFocus = FocusNode();
    submitFocus = FocusNode();
    typeFocus = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    reasonFocus.dispose();
    submitFocus.dispose();
    typeFocus.dispose();
  }

  int wordsNum = 0;

  void countWords(value) {
    var regExp = new RegExp(r"\w+('\w+)?");
    int wordsCount = regExp.allMatches(reasonController.text).length;
    setState(() {
      wordsNum = wordsCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return ViewModelBuilder<LeaveFormViewModel>.reactive(
      viewModelBuilder: () => LeaveFormViewModel(),
      onModelReady: (model) {
        model.isInternet();
        model.initialise();
      },
      builder: (context, model, child) => Scaffold(
        backgroundColor: ViewColor.background_white_color,
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus.unfocus();
            FocusScope.of(context).unfocus();
            showSuccessMessage = false;
            showFailMessage = false;
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
                                  GestureDetector(
                                    child: Container(
                                      width: 220,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: ViewColor.text_grey_color,
                                      ),
                                      alignment: Alignment.centerRight,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10.0),
                                            child: Text(
                                              DateTimeFormat.pickerDateFormat("${selectStartDate.toLocal()}"),
                                              style: TextStyles.leaveText4,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 10.0),
                                            child: Image.asset(
                                              'assets/calendar.png',
                                              height: 40,
                                              width: 40,
                                              color: ViewColor.text_black_color,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      _selectStartDate(context);
                                    },
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
                                  GestureDetector(
                                    child: Container(
                                      width: 220,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: ViewColor.text_grey_color,
                                      ),
                                      alignment: Alignment.centerRight,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10.0),
                                            child: Text(
                                              DateTimeFormat.pickerDateFormat("${selectEndDate.toLocal()}"),
                                              style: TextStyles.leaveText4,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 10.0),
                                            child: Image.asset(
                                              'assets/calendar.png',
                                              height: 40,
                                              width: 40,
                                              color: ViewColor.text_black_color,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      _selectEndDate(context);
                                    },
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
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: ViewColor.text_grey_color,
                                    ),
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: Center(
                                        child: Theme(
                                          data: ThemeData(
                                            canvasColor: ViewColor.text_grey_color,
                                          ),
                                          child: DropdownButtonFormField<String>(
                                            iconEnabledColor: ViewColor.text_grey_color,
                                            iconDisabledColor: ViewColor.text_grey_color,
                                            isExpanded: true,
                                            elevation: 16,
                                            focusNode: typeFocus,
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
                                            validator: (value) {
                                              if (model.getEmpInfo.length == 0) {
                                                return null;
                                              } else if (model.getEmpInfo.first.paidLeave == 0 &&
                                                  _currentType == "Paid Leave") {
                                                return "you can\'t use paid leave(s)";
                                              } else if (model.getEmpInfo.first.sickLeave == 0 &&
                                                  _currentType == "Sick Leave") {
                                                return "you can\'t use sick leave(s)";
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              errorStyle: TextStyles.leaveMessages,
                                              enabledBorder: InputBorder.none,
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              errorBorder: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                            ),
                                          ),
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
                                        textCapitalization: TextCapitalization.sentences,
                                        focusNode: reasonFocus,
                                        maxLines: 5,
                                        enabled: true,
                                        keyboardType: TextInputType.text,
                                        controller: reasonController,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          errorStyle: TextStyles.leaveMessages,
                                        ),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            Future.delayed(const Duration(seconds: 3), () {
                                              return Utils.msgReason;
                                            });
                                          }
                                          return null;
                                        },
                                        onChanged: countWords,
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
                          Visibility(
                            visible: showSuccessMessage,
                            child: Container(
                              child: Text(
                                'Application Submitted Successfully!',
                                style: TextStyles.leaveMessages,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: showFailMessage,
                            child: Container(
                              child: Text(
                                'Application Submission Failed!',
                                style: TextStyles.leaveMessages,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: cutOffMessage,
                            child: Container(
                              child: Text(
                                'You are applying past cut-off time!',
                                style: TextStyles.leaveMessages,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: beforeErrorMessage,
                            child: Container(
                              child: Text(
                                'You can\'t enter end date before the start date',
                                style: TextStyles.leaveMessages,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: typeErrorMessage,
                            child: Container(
                              child: Text(
                                'You don\'t have enough paid leaves!',
                                style: TextStyles.leaveMessages,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: typeErrorMessage1,
                            child: Container(
                              child: Text(
                                'You don\'t have enough sick leaves!',
                                style: TextStyles.leaveMessages,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: wordErrorMessage,
                            child: Container(
                              child: Text(
                                'Enter up to 10 words to explain your reason',
                                style: TextStyles.leaveMessages,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
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
                                var diff = selectEndDate.difference(selectStartDate).inDays;
                                var totalDays = diff + 1;
                                var probDuration;
                                String joinDate;
                                int joinYr, joinMonth, joinDay;
                                var lastProbationDay;
                                if (selectEndDate.isBefore(selectStartDate)) {
                                  beforeErrorMessage = true;
                                  Future.delayed(const Duration(seconds: 2), () {
                                    setState(() {
                                      beforeErrorMessage = false;
                                    });
                                  });
                                } else if (reasonController.text.isEmpty) {
                                  FocusManager.instance.primaryFocus.unfocus();
                                  reasonController.clear();
                                  showFailMessage = true;
                                  Future.delayed(const Duration(seconds: 2), () {
                                    setState(() {
                                      showFailMessage = false;
                                    });
                                  });
                                } else {
                                  if (model.getEmpInfo.length == 0) {
                                  } else {
                                    probDuration = model.getEmpInfo.first.probetion;
                                    joinDate = "${model.getEmpInfo.first.joiningDate}";
                                    DateTime nDate = DateTime.parse(joinDate);
                                    joinYr = nDate.year;
                                    joinMonth = nDate.month;
                                    joinDay = nDate.day;
                                    lastProbationDay = DateTime(joinYr, joinMonth + probDuration, joinDay - 1);
                                    if (selectStartDate.isAfter(model.getEmpInfo.first.joiningDate) &&
                                            selectStartDate.isBefore(lastProbationDay) ||
                                        selectEndDate.isBefore(lastProbationDay) &&
                                            selectEndDate.isAfter(model.getEmpInfo.first.joiningDate)) {
                                      if (_currentType == "Paid Leave") {
                                        typeErrorMessage = true;
                                        Future.delayed(const Duration(seconds: 2), () {
                                          setState(() {
                                            typeErrorMessage = false;
                                          });
                                        });
                                      } else if (_currentType == "Sick Leave") {
                                        typeErrorMessage1 = true;
                                        Future.delayed(const Duration(seconds: 2), () {
                                          setState(() {
                                            typeErrorMessage1 = false;
                                          });
                                        });
                                      } else {
                                        if (selectEndDate.isBefore(selectStartDate)) {
                                          beforeErrorMessage = true;
                                          Future.delayed(const Duration(seconds: 2), () {
                                            setState(() {
                                              beforeErrorMessage = false;
                                            });
                                          });
                                        } else {
                                          if (reasonController.text.isEmpty) {
                                            FocusManager.instance.primaryFocus.unfocus();
                                            reasonController.clear();
                                            showFailMessage = true;
                                            Future.delayed(const Duration(seconds: 2), () {
                                              setState(() {
                                                showFailMessage = false;
                                              });
                                            });
                                          } else {
                                            if (model.getEmpInfo.first.paidLeave == 0 && _currentType == "Paid Leave") {
                                              typeErrorMessage = true;
                                              Future.delayed(const Duration(seconds: 2), () {
                                                setState(() {
                                                  typeErrorMessage = false;
                                                });
                                              });
                                            } else if (model.getEmpInfo.first.sickLeave == 0 &&
                                                _currentType == "Sick Leave") {
                                              typeErrorMessage1 = true;
                                              Future.delayed(const Duration(seconds: 2), () {
                                                setState(() {
                                                  typeErrorMessage1 = false;
                                                });
                                              });
                                            } else {
                                              if (wordsNum >= 10) {
                                                if (_formKey.currentState.validate()) {
                                                  FocusManager.instance.primaryFocus.unfocus();
                                                  int pl = 0, sl = 0, ul = 0, remainPaid, remainSick;
                                                  if (model.getEmpInfo.first.paidLeave == 0 &&
                                                          _currentType == "Paid Leave" ||
                                                      model.getEmpInfo.first.sickLeave == 0 &&
                                                          _currentType == "Sick Leave" ||
                                                      _currentType == "Unpaid Leave") {
                                                    pl = remainPaid = 0;
                                                    sl = remainSick = 0;
                                                    ul = totalDays;
                                                    remainPaid = model.getEmpInfo.first.paidLeave;
                                                    remainSick = model.getEmpInfo.first.sickLeave;
                                                    print(
                                                        "7: pl: $pl | sl: $sl | ul: $ul | remainPaid: $remainPaid | remainSick: $remainSick");
                                                  } else if (model.getEmpInfo.first.paidLeave == totalDays &&
                                                      _currentType == "Paid Leave") {
                                                    pl = totalDays;
                                                    sl = 0;
                                                    ul = 0;
                                                    remainSick = model.getEmpInfo.first.sickLeave;
                                                    remainPaid = model.getEmpInfo.first.paidLeave - totalDays;
                                                    print(
                                                        "7: pl: $pl | sl: $sl | ul: $ul | remainPaid: $remainPaid | remainSick: $remainSick");
                                                  } else if (model.getEmpInfo.first.sickLeave == totalDays &&
                                                      _currentType == "Sick Leave") {
                                                    pl = 0;
                                                    sl = totalDays;
                                                    ul = 0;
                                                    remainPaid = model.getEmpInfo.first.paidLeave;
                                                    remainSick = model.getEmpInfo.first.sickLeave - totalDays;
                                                    print(
                                                        "7: pl: $pl | sl: $sl | ul: $ul | remainPaid: $remainPaid | remainSick: $remainSick");
                                                  } else if (model.getEmpInfo.first.paidLeave > totalDays &&
                                                      _currentType == "Paid Leave") {
                                                    pl = totalDays;
                                                    sl = 0;
                                                    ul = 0;
                                                    remainSick = model.getEmpInfo.first.sickLeave;
                                                    remainPaid = model.getEmpInfo.first.paidLeave - totalDays;
                                                    print(
                                                        "7: pl: $pl | sl: $sl | ul: $ul | remainPaid: $remainPaid | remainSick: $remainSick");
                                                  } else if (model.getEmpInfo.first.sickLeave > totalDays &&
                                                      _currentType == "Sick Leave") {
                                                    pl = 0;
                                                    sl = totalDays;
                                                    ul = 0;
                                                    remainSick = model.getEmpInfo.first.sickLeave - totalDays;
                                                    remainPaid = model.getEmpInfo.first.paidLeave;
                                                    print(
                                                        "7: pl: $pl | sl: $sl | ul: $ul | remainPaid: $remainPaid | remainSick: $remainSick");
                                                  } else if (model.getEmpInfo.first.paidLeave < totalDays &&
                                                      _currentType == "Paid Leave") {
                                                    pl = model.getEmpInfo.first.paidLeave;
                                                    ul = totalDays - model.getEmpInfo.first.paidLeave;
                                                    sl = 0;
                                                    remainSick = model.getEmpInfo.first.sickLeave;
                                                    remainPaid = model.getEmpInfo.first.paidLeave -
                                                        model.getEmpInfo.first.paidLeave;
                                                    print(
                                                        "7: pl: $pl | sl: $sl | ul: $ul | remainPaid: $remainPaid | remainSick: $remainSick");
                                                  } else if (model.getEmpInfo.first.sickLeave < totalDays &&
                                                      _currentType == "Sick Leave") {
                                                    pl = 0;
                                                    sl = model.getEmpInfo.first.sickLeave;
                                                    ul = totalDays - model.getEmpInfo.first.sickLeave;
                                                    remainPaid = model.getEmpInfo.first.paidLeave;
                                                    remainSick = model.getEmpInfo.first.sickLeave -
                                                        model.getEmpInfo.first.sickLeave;
                                                    print(
                                                        "7: pl: $pl | sl: $sl | ul: $ul | remainPaid: $remainPaid | remainSick: $remainSick");
                                                  }
                                                  model.postLeave(
                                                    _currentType.toString(),
                                                    selectStartDate.toString(),
                                                    selectEndDate.toString(),
                                                    reasonController.text,
                                                    totalDays,
                                                    pl,
                                                    sl,
                                                    ul,
                                                    remainPaid,
                                                    remainSick,
                                                  );
                                                  reasonController.clear();
                                                  showSuccessMessage = true;
                                                  Future.delayed(const Duration(seconds: 2), () {
                                                    setState(() {
                                                      showSuccessMessage = false;
                                                    });
                                                  });
                                                } else {
                                                  showFailMessage = true;
                                                  Future.delayed(const Duration(seconds: 2), () {
                                                    setState(() {
                                                      showFailMessage = false;
                                                    });
                                                  });
                                                }
                                              } else {
                                                print("word: $wordsNum");
                                                wordErrorMessage = true;
                                                Future.delayed(const Duration(seconds: 2), () {
                                                  setState(() {
                                                    wordErrorMessage = false;
                                                  });
                                                });
                                              }
                                            }
                                          }
                                        }
                                      }
                                    } else {
                                      if (wordsNum >= 10) {
                                        if (_formKey.currentState.validate()) {
                                          FocusManager.instance.primaryFocus.unfocus();
                                          int pl = 0, sl = 0, ul = 0, remainPaid, remainSick;
                                          if (model.getEmpInfo.first.paidLeave == 0 && _currentType == "Paid Leave" ||
                                              model.getEmpInfo.first.sickLeave == 0 && _currentType == "Sick Leave" ||
                                              _currentType == "Unpaid Leave") {
                                            pl = remainPaid = 0;
                                            sl = remainSick = 0;
                                            ul = totalDays;
                                            remainPaid = model.getEmpInfo.first.paidLeave;
                                            remainSick = model.getEmpInfo.first.sickLeave;
                                            print(
                                                "1: pl: $pl | sl: $sl | ul: $ul | remainPaid: $remainPaid | remainSick: $remainSick");
                                          } else if (model.getEmpInfo.first.paidLeave == totalDays &&
                                              _currentType == "Paid Leave") {
                                            pl = totalDays;
                                            sl = 0;
                                            ul = 0;
                                            remainSick = model.getEmpInfo.first.sickLeave;
                                            remainPaid = model.getEmpInfo.first.paidLeave - totalDays;
                                            print(
                                                "2: pl: $pl | sl: $sl | ul: $ul | remainPaid: $remainPaid | remainSick: $remainSick");
                                          } else if (model.getEmpInfo.first.sickLeave == totalDays &&
                                              _currentType == "Sick Leave") {
                                            pl = 0;
                                            sl = totalDays;
                                            ul = 0;
                                            remainPaid = model.getEmpInfo.first.paidLeave;
                                            remainSick = model.getEmpInfo.first.sickLeave - totalDays;
                                            print(
                                                "3: pl: $pl | sl: $sl | ul: $ul | remainPaid: $remainPaid | remainSick: $remainSick");
                                          } else if (model.getEmpInfo.first.paidLeave > totalDays &&
                                              _currentType == "Paid Leave") {
                                            pl = totalDays;
                                            sl = 0;
                                            ul = 0;
                                            remainSick = model.getEmpInfo.first.sickLeave;
                                            remainPaid = model.getEmpInfo.first.paidLeave - totalDays;
                                            print(
                                                "4: pl: $pl | sl: $sl | ul: $ul | remainPaid: $remainPaid | remainSick: $remainSick");
                                          } else if (model.getEmpInfo.first.sickLeave > totalDays &&
                                              _currentType == "Sick Leave") {
                                            pl = 0;
                                            sl = totalDays;
                                            ul = 0;
                                            remainSick = model.getEmpInfo.first.sickLeave - totalDays;
                                            remainPaid = model.getEmpInfo.first.paidLeave;
                                            print(
                                                "5: pl: $pl | sl: $sl | ul: $ul | remainPaid: $remainPaid | remainSick: $remainSick");
                                          } else if (model.getEmpInfo.first.paidLeave < totalDays &&
                                              _currentType == "Paid Leave") {
                                            pl = model.getEmpInfo.first.paidLeave;
                                            ul = totalDays - model.getEmpInfo.first.paidLeave;
                                            sl = 0;
                                            remainSick = model.getEmpInfo.first.sickLeave;
                                            remainPaid =
                                                model.getEmpInfo.first.paidLeave - model.getEmpInfo.first.paidLeave;
                                            print(
                                                "6: pl: $pl | sl: $sl | ul: $ul | remainPaid: $remainPaid | remainSick: $remainSick");
                                          } else if (model.getEmpInfo.first.sickLeave < totalDays &&
                                              _currentType == "Sick Leave") {
                                            pl = 0;
                                            sl = model.getEmpInfo.first.sickLeave;
                                            ul = totalDays - model.getEmpInfo.first.sickLeave;
                                            remainPaid = model.getEmpInfo.first.paidLeave;
                                            remainSick =
                                                model.getEmpInfo.first.sickLeave - model.getEmpInfo.first.sickLeave;
                                            print(
                                                "7: pl: $pl | sl: $sl | ul: $ul | remainPaid: $remainPaid | remainSick: $remainSick");
                                          }
                                          model.postLeave(
                                            _currentType.toString(),
                                            selectStartDate.toString(),
                                            selectEndDate.toString(),
                                            reasonController.text,
                                            totalDays,
                                            pl,
                                            sl,
                                            ul,
                                            remainPaid,
                                            remainSick,
                                          );
                                          reasonController.clear();
                                          showSuccessMessage = true;
                                          Future.delayed(const Duration(seconds: 2), () {
                                            setState(() {
                                              showSuccessMessage = false;
                                            });
                                          });
                                        } else {
                                          showFailMessage = true;
                                          Future.delayed(const Duration(seconds: 2), () {
                                            setState(() {
                                              showFailMessage = false;
                                            });
                                          });
                                        }
                                      } else {
                                        print("word: $wordsNum");
                                        wordErrorMessage = true;
                                        Future.delayed(const Duration(seconds: 2), () {
                                          setState(() {
                                            wordErrorMessage = false;
                                          });
                                        });
                                      }
                                    }
                                  }
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
    var now = DateTime.now();
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year, now.month, now.day + 2),
      firstDate: DateTime(now.year, now.month, now.day + 2),
      lastDate: DateTime(2100),
      selectableDayPredicate: (DateTime val) => (val.weekday == DateTime.sunday) ? false : true,
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
    var now = DateTime.now();
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectStartDate,
      firstDate: selectStartDate,
      lastDate: DateTime(2100),
      selectableDayPredicate: (DateTime val) => (val.weekday == DateTime.sunday) ? false : true,
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
    var totalDays = selectEndDate.difference(selectStartDate).inDays;
    var twoDays = selectStartDate.difference(now).inDays;

    if (selectEndDate.isBefore(selectStartDate)) {
      beforeErrorMessage = true;
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          beforeErrorMessage = false;
        });
      });
    } else {
      if (totalDays == 0 && twoDays >= 1) {
        print('if case 1');
      } else if (totalDays == 1 && twoDays >= 9 || totalDays <= 4 && twoDays >= 9) {
        print('if case 2');
      } else if (totalDays >= 5 && twoDays >= 29) {
        print('if case 3');
      } else {
        cutOffMessage = true;
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            cutOffMessage = false;
          });
        });
      }
    }
  }
}
