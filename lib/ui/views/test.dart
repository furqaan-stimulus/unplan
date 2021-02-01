import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // child: Center(
      //   child: FutureBuilder<List<EmployeeDetail>>(
      //     future: listLog,
      //     builder: (context, snapShot) {
      //       if (snapShot.hasData) {
      //         var p = DateTime.parse(snapShot.data.elementAt(snapShot.data.length - 1).time.toString());
      //         var format = DateFormat('HH:mm a, d MMM');
      //         var s = format.format(p);
      //         return RichText(
      //           text: TextSpan(
      //             children: <TextSpan>[
      //               TextSpan(text: 'Last ', style: TextStyles.homeText),
      //               (snapShot.data.elementAt(snapShot.data.length - 1).type == 'clock-out' ||
      //                   snapShot.data.elementAt(snapShot.data.length - 1).type == 'break')
      //                   ? TextSpan(text: 'Clock-Out : ', style: TextStyles.homeText)
      //                   : TextSpan(text: 'Clock-In : ', style: TextStyles.homeText),
      //               (snapShot.data.elementAt(snapShot.data.length - 1).type == 'clock-out' ||
      //                   snapShot.data.elementAt(snapShot.data.length - 1).type == 'break')
      //                   ? TextSpan(text: '$s', style: TextStyles.homeText)
      //                   : TextSpan(text: '$s', style: TextStyles.homeText),
      //             ],
      //           ),
      //         );
      //       } else {
      //         return Text('');
      //       }
      //     },
      //   ),
      // ),
    );
  }
}
