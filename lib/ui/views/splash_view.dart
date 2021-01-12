import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:unplan/utils/text_styles.dart';
import 'package:unplan/utils/view_color.dart';
import 'package:unplan/view_models/splash_view_model.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      viewModelBuilder: () => SplashViewModel(),
      onModelReady: (model) {
        Future.delayed(
          Duration(seconds: 1),
          () {
            model.navigateToLoginView();
          },
        );
      },
      builder: (context, model, child) => Scaffold(
        backgroundColor: ViewColor.background_purple_color,
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 1.9,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 125.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(text: 'un', style: TextStyles.splashTitle1),
                            TextSpan(text: 'plan', style: TextStyles.splashTitle2),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text(
                          "tracking businesses",
                          style: TextStyles.splashSubTitle,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2.2,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/new.png'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
