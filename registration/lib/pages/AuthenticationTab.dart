import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:registration/helpers/theme_helper.dart';
import 'package:registration/pages/SignIn.dart';
import 'package:registration/pages/SignUp.dart';
import 'package:velocity_x/velocity_x.dart';

class AuthenticationTab extends StatefulWidget {
  @override
  _AuthenticationTabState createState() => _AuthenticationTabState();
}

class _AuthenticationTabState extends State<AuthenticationTab> {
  String option;
  int _formsIndex;

  @override
  void initState() {
    super.initState();
    option = 'Login';
    _formsIndex = 1;
  }

  @override
  Widget build(BuildContext context) {
    bool isMobileView = context.isMobile;
    return Material(
        elevation: 10,
        child: Container(
          width: double.infinity,
          color: ThemeHelper.backgroundRed,
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("\nWelcome,\n",
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      fontSize: context.isMobile
                          ? ScreenUtil().setSp(25, allowFontScalingSelf: true)
                          : ScreenUtil().setSp(20, allowFontScalingSelf: true),
                      color: Colors.white)),
              Text("You have choosen to apply for 2020",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w200,
                      fontSize: context.isMobile
                          ? ScreenUtil().setSp(20, allowFontScalingSelf: true)
                          : ScreenUtil().setSp(15, allowFontScalingSelf: true),
                      color: Colors.white)),
              Text("  Kerala Engineering admission under Management Quota.",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w200,
                      fontSize: context.isMobile
                          ? ScreenUtil().setSp(20, allowFontScalingSelf: true)
                          : ScreenUtil().setSp(15, allowFontScalingSelf: true),
                      color: Colors.white)),
              Divider(color: Colors.transparent),
              /*-------------------------------------------------------------*/

              Material(
                elevation: 15,
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(50.0),
                shadowColor: Colors.black87,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      option == 'Login'
                          ? option = 'Register to Apply'
                          : option = 'Login';
                      _formsIndex == 2 ? _formsIndex = 1 : _formsIndex = 2;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: ScreenUtil().setWidth(150),
                    height: 25,
                    child: Text(
                      option,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17, color: Colors.yellow[200]),
                    ),
                  ),
                ),
              ),
              /*--------Animated contaner-----------*/
              Divider(color: Colors.transparent),
              Container(
                color: Colors.transparent,
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: _formsIndex == 1 ? SignUp() : SignIn(),
                ),
              ),

              /*------------------bottom scontent---*/
              Divider(color: Colors.black54),
              Text("For Admission correspondences, contact:",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w200,
                      fontSize: context.isMobile
                          ? ScreenUtil().setSp(10, allowFontScalingSelf: true)
                          : ScreenUtil().setSp(8, allowFontScalingSelf: true),
                      color: Colors.white)),
              Text("\tJiril Jose Kootungal,\nCEO | Signness, Cell: 12233141",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: context.isMobile
                          ? ScreenUtil().setSp(10, allowFontScalingSelf: true)
                          : ScreenUtil().setSp(8, allowFontScalingSelf: true),
                      color: Colors.black87)),
              Divider(color: Colors.transparent)
            ],
          )),
        ));
  }
}
