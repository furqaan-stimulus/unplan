import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:unplan/utils/text_styles.dart';
import 'package:unplan/utils/view_color.dart';
import 'package:unplan/view_models/login_view_model.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _obscureText = false;

  final _formKey = GlobalKey<FormState>();

  void toggle() {
    setState(() {
      this._obscureText = !this._obscureText;
    });
  }

  FocusNode emailFocus;
  FocusNode pwd;
  FocusNode submitFocus;

  @override
  void initState() {
    super.initState();
    emailFocus = FocusNode();
    pwd = FocusNode();
    submitFocus = FocusNode();
  }

  @override
  void dispose() {
    emailFocus.dispose();
    pwd.dispose();
    submitFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      onModelReady: (model) {},
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        key: _scaffoldKey,
        backgroundColor: ViewColor.text_white_color,
        body: ListView(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          children: [
            GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 3.4,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 155.0),
                            child: Text(
                              'login',
                              style: TextStyles.loginTitle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 2.5,
                    color: ViewColor.background_white_color,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Form(
                          key: _formKey,
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 35.0, right: 35.0),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: ViewColor.text_grey_color,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20.0, 4.0, 10.0, 4.0),
                                      child: TextFormField(
                                        style: TextStyles.emailTextStyle,
                                        focusNode: emailFocus,
                                        enabled: true,
                                        textInputAction: TextInputAction.next,
                                        onFieldSubmitted: (term) {
                                          emailFocus.unfocus();
                                          FocusScope.of(context)
                                              .requestFocus(pwd);
                                        },
                                        controller: emailController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          hintText: 'you.stimulus@gmail.com',
                                          hintStyle: TextStyles.emailHintStyle,
                                          border: InputBorder.none,
                                        ),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Enter Email Id';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 35.0, right: 35.0),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: ViewColor.text_grey_color,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20.0, 4.0, 6.0, 4.0),
                                      child: TextFormField(
                                        style: TextStyles.passwordTextStyle,
                                        focusNode: pwd,
                                        enabled: true,
                                        textInputAction: TextInputAction.next,
                                        onFieldSubmitted: (term) {
                                          pwd.unfocus();
                                          FocusScope.of(context)
                                              .requestFocus(submitFocus);
                                        },
                                        controller: passwordController,
                                        obscureText: !this._obscureText,
                                        obscuringCharacter: "*",
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          hintText: 'password',
                                          hintStyle:
                                              TextStyles.passwordHintStyle,
                                          border: InputBorder.none,
                                        ),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Password is required';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 35.0, right: 35.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    width: double.infinity,
                                    child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      focusNode: submitFocus,
                                      child: Text(
                                        "employee login",
                                        style: TextStyles.buttonTextStyle1,
                                      ),
                                      textColor: Colors.white,
                                      padding: const EdgeInsets.fromLTRB(
                                          20.0, 14.0, 20.0, 14.0),
                                      onPressed: () {
                                        emailController.clear();
                                        passwordController.clear();
                                        model.navigateToHomeView();
                                        FocusScope.of(context).unfocus();
                                        // FocusManager.instance.primaryFocus.unfocus();
                                        // if (_formKey.currentState.validate()) {}
                                      },
                                      color: ViewColor.button_green_color,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 80.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 5.5,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RichText(
                                text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: 'un', style: TextStyles.loginTitle),
                              TextSpan(
                                  text: 'plan',
                                  style: TextStyles.loginFooterTitle1),
                            ])),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                "tracking businesses",
                                style: TextStyles.loginFooterSubTitle,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
