import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:registration/helpers/theme_helper.dart';
import 'package:registration/pages/AboutTab.dart';
import 'package:registration/pages/subFolder/EducationalInformation.dart';
import 'package:registration/pages/subFolder/dashboard_workspace.dart';
import 'package:toast/toast.dart';
import 'package:velocity_x/velocity_x.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  int _tabIndex = 1;

  Widget button(
      String _text, IconData _icon, int _tabValue, String toastMessage) {
    return Material(
        elevation: 10.0,
        borderRadius: BorderRadius.circular(10.0),
        color: _tabValue == 1
            ? Colors.greenAccent[100]
            : _tabValue == 2
                ? Colors.yellowAccent[100]
                : _tabValue == 3 ? Colors.redAccent[100] : null,
        child: MaterialButton(
            height: 25,
            onPressed: () {
              Toast.show(toastMessage, context,
                  duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
              // setState(() {
              //   _tabIndex = _tabValue;
              // });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(_icon, color: Colors.black54),
                Text(
                  _text,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.black54),
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
                  ),
                ],
              )),
        ),
        backgroundColor: ThemeHelper.backgroundRed,
        body: SingleChildScrollView(
            child: Container(
          color: Colors.white,
          margin: context.isMobile
              ? EdgeInsets.fromLTRB(8, 10, 8, 10)
              : EdgeInsets.fromLTRB(100, 20, 100, 20),
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(width: 15, height: 15),
              Container(
                  alignment: AlignmentDirectional.center,
                  color: Colors.white10,
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: [
                      Container(
                        width: context.isMobile ? 70 : 305,
                        height: 30,
                        child: context.isMobile
                            ? button("", Icons.border_color, 1,
                                "Details already filled in signup")
                            : button("Basic Information", Icons.border_color, 1,
                                "Details already filled in signup"),
                      ),
                      SizedBox(width: 15, height: 45),
                      Container(
                        width: context.isMobile ? 70 : 305,
                        height: 30,
                        child: context.isMobile
                            ? button("", Icons.contact_mail, 2,
                                "Please fill up the contact details..")
                            : button("Contact Information", Icons.contact_mail,
                                2, "Please fill up the contact details.."),
                      ),
                      SizedBox(width: 15, height: 45),
                      Container(
                        width: context.isMobile ? 70 : 305,
                        height: 30,
                        child: context.isMobile
                            ? button(" ", Icons.school, 3,
                                "Please choose the branch preference..")
                            : button("Educational Information", Icons.school, 3,
                                "Please choose the branch preference.."),
                      ),
                      SizedBox(width: 25, height: 45),
                    ],
                  )),
              Expanded(
                  child: Container(width: double.infinity, child: RootPage()
                      /*AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          child: _tabIndex == 1
                              ? ContactInformation()
                              : _tabIndex == 2
                                  ? ContactInformation()
                                  : _tabIndex == 3
                                      ? EducationalInformation()
                                      : null)*/
                      )),
            ],
          ),
        )));
  }
}
