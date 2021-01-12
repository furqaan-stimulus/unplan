import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:unplan/utils/text_styles.dart';
import 'package:unplan/utils/view_color.dart';
import 'package:unplan/view_models/bottom_sheet_view_model.dart';

//
// class BottomSheetView extends StatefulWidget {
//   @override
//   _BottomSheetViewState createState() => _BottomSheetViewState();
// }

class BottomSheetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => BottomSheetViewModel(),
      builder: (context, model, child) => Scaffold(
        body: bottomSheetView(context),
      ),
    );
  }

  bottomSheetView(context) {
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
            Text(
              'You are',
              style: TextStyles.buttonTextStyle2,
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              'Working From Home',
              style: TextStyles.bottomTextStyle,
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              'Naranpura Ahmedabad',
              style: TextStyles.bottomTextStyle2,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'ON TIME',
              style: TextStyles.bottomTextStyle3,
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                width: double.infinity,
                child: FlatButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    "CONFIRM",
                    style: TextStyles.bottomButtonText,
                  ),
                  textColor: Colors.white,
                  padding: EdgeInsets.all(16),
                  onPressed: () {},
                  color: ViewColor.background_purple_color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
