import 'package:flutter/material.dart';
import 'package:unplan/utils/text_styles.dart';
import 'package:unplan/utils/utils.dart';
import 'package:unplan/utils/view_color.dart';

class ClockInButton extends StatefulWidget {
  final String type;
  final String pressed;

  final Function() onPressed;

  const ClockInButton({Key key, this.type, this.pressed, this.onPressed}) : super(key: key);

  @override
  _ClockInButtonState createState() => _ClockInButtonState();
}

class _ClockInButtonState extends State<ClockInButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      width: double.infinity,
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        color: (widget.type == null)
            ? ViewColor.button_grey_color
            : (widget.type == Utils.CLOCKOUT || widget.type == Utils.TIMEOUT)
                ? ViewColor.button_green_color
                : ViewColor.button_grey_color,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: widget.type == null
              ? Text(
                  Utils.buttonIn,
                  style: TextStyles.buttonTextStyle2,
                )
              : (widget.type == Utils.CLOCKOUT || widget.type == Utils.TIMEOUT)
                  ? Text(
                      Utils.buttonOut,
                      style: TextStyles.buttonTextStyle2,
                    )
                  : Text(
                      Utils.buttonIn,
                      style: TextStyles.buttonTextStyle2,
                    ),
        ),
        onPressed: widget.pressed == null
            ? () {
                widget.onPressed();
              }
            : () {
                widget.onPressed();
              },
      ),
    );
  }
}
