import 'package:flutter/material.dart';
import 'package:unplan/model/leave_list_log.dart';
import 'package:unplan/utils/date_time_format.dart';
import 'package:unplan/utils/text_styles.dart';

class LeaveListItem extends StatefulWidget {
  final LeaveListLog log;

  const LeaveListItem({Key key, this.log}) : super(key: key);

  @override
  _LeaveListItemState createState() => _LeaveListItemState();
}

class _LeaveListItemState extends State<LeaveListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Center(
            child: Text(
              DateTimeFormat.leaveDate("${widget.log.dateTime}"),
              style: TextStyles.leaveListText,
            ),
          ),
          Center(
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: DateTimeFormat.leaveDate1("${widget.log.from.toString()}"),
                      style: TextStyles.leaveListText),
                  TextSpan(text: " - ", style: TextStyles.leaveListText),
                  TextSpan(
                      text: DateTimeFormat.leaveDate1("${widget.log.to.toString()}"), style: TextStyles.leaveListText),
                ],
              ),
            ),
          ),
          Text(
            widget.log.leaveType == "paidleave" || widget.log.leaveType == "Paid Leave"
                ? "PL"
                : widget.log.leaveType == "Sick Leave"
                    ? "SL"
                    : "UL",
            style: TextStyles.leaveListText,
          ),
          (widget.log.status == "approved")
              ? Padding(
                  padding: const EdgeInsets.only(right: 22.0),
                  child: Text(
                    widget.log.status == "approved" ? "Approved" : "",
                    style: TextStyles.leaveListText1,
                  ),
                )
              : Center(
                  child: Text(
                    widget.log.status == "notapproved" ? "Not Approved" : "",
                    style: TextStyles.leaveListText2,
                  ),
                ),
        ],
      ),
    );
  }
}
