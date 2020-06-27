import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:registration/helpers/theme_helper.dart';
import 'package:registration/pages/AboutTab.dart';
import 'package:registration/pages/AuthenticationTab.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  int _formIndex = 1;

  Widget button(String _text, IconData _icon, int _formValue) {
    return Material(
        elevation: 10.0,
        borderRadius: BorderRadius.circular(30.0),
        color: ThemeHelper.backgroundRed,
        child: MaterialButton(
            height: 25,
            onPressed: () {
              setState(() {
                _formIndex = _formValue;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(_icon, color: ThemeHelper.secondaryColorDark),
                Text(
                  _text,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    dynamic mobileView = context.isMobile ? true : false;
    mobileView
        ? {
            ScreenUtil.init(context,
                width: 375, height: 812, allowFontScaling: true),
            print("moble view")
          }
        : {
            ScreenUtil.init(context,
                width: 720, height: 1280, allowFontScaling: true),
            print("web view")
          };
    int _flex1, _flex2;
    context.isMobile ? _flex1 = 0 : _flex1 = 0;
    context.isMobile ? _flex2 = 2 : _flex2 = 1;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeHelper.backgroundRed,
          title: Container(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: ScreenUtil().setWidth(60),
                    // height: ,
                  ),
                ],
              )),
        ),
        backgroundColor: ThemeHelper.backgroundRed,
        body: SingleChildScrollView(
            child: Container(
          color: ThemeHelper.backgroundRed,
          margin: context.isMobile
              ? EdgeInsets.fromLTRB(8, 10, 8, 20)
              : EdgeInsets.fromLTRB(100, 20, 100, 100),
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Material(
                  elevation: 10,
                  child: Container(
                    width: double.infinity,
                    // height: 310,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/4330.gif"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: SingleChildScrollView(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            margin: context.isMobile
                                ? EdgeInsets.fromLTRB(8, 10, 8, 10)
                                : EdgeInsets.fromLTRB(100, 80, 100, 80),
                            child: Text(
                              "Signness Engineering Management Admission Portal- 2020",
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 5.0,
                                      color: Colors.black87,
                                      offset: Offset(5.0, 5.0),
                                    ),
                                  ],
                                  fontSize: context.isMobile
                                      ? ScreenUtil().setSp(30,
                                          allowFontScalingSelf: false)
                                      : ScreenUtil().setSp(24,
                                          allowFontScalingSelf: false)),
                            )),
                        Container(
                            alignment: Alignment.bottomRight,
                            child: Wrap(
                              direction: Axis.horizontal,
                              children: [
                                Material(
                                  elevation: 10.0,
                                  color: ThemeHelper.backgroundRed,
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: InkWell(
                                      onTap: () => {},
                                      child: Container(
                                        color: ThemeHelper.backgroundRed,
                                        width: 105,
                                        height: 30,
                                        child: button("Home", Icons.home, 1),
                                      )),
                                ),
                                SizedBox(width: 15, height: 15),
                                Material(
                                  elevation: 10.0,
                                  color: ThemeHelper.backgroundRed,
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: InkWell(
                                      onTap: () => {},
                                      child: Container(
                                        color: ThemeHelper.backgroundRed,
                                        width: 105,
                                        height: 30,
                                        child:
                                            button("About", Icons.art_track, 2),
                                      )),
                                ),
                                SizedBox(width: 25, height: 15),
                              ],
                            )),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    )),
                  )),
              Expanded(
                  flex: _flex2,
                  child: Container(
                      color: Colors.transparent,
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        child:
                            _formIndex == 1 ? AuthenticationTab() : AboutPage(),
                      ))),
            ],
          ),
        )));
  }
}
