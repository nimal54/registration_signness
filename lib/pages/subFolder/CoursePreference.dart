import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:registration/helpers/global.dart' as global;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:registration/pages/subFolder/EducationalInformation.dart';
import 'package:toast/toast.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:loading_overlay/loading_overlay.dart';

class CoursePreference extends StatefulWidget {
  Function callback;
  CoursePreference(this.callback);

  @override
  _CoursePreferenceState createState() => _CoursePreferenceState(this.callback);
}

class _CoursePreferenceState extends State<CoursePreference> {
  Function callback;
  _CoursePreferenceState(this.callback);

  bool _isLoading = false;
  final _formKey = new GlobalKey<FormState>();

  String _pCourse1, _pCourse2, _pCourse3;

  _textView(String str1, String str2) => RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
                text: str1.toString(),
                style: GoogleFonts.lato(
                    fontWeight: FontWeight.w500, color: Colors.black54)),
            TextSpan(
                text: str2.toString(),
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: Colors.red)),
          ],
        ),
      );
  _choiceTextForm(String _inputFeild, String courseOption) => Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        color: Colors.transparent,
        width: double.infinity,
        child: Card(
            child: DropdownButton(
          isExpanded: true,
          value: courseOption == "_pCourse1"
              ? _pCourse1
              : courseOption == "_pCourse2"
                  ? _pCourse2
                  : courseOption == "_pCourse3" ? _pCourse3 : null,
          style: TextStyle(fontSize: 14, color: Colors.blueGrey),
          icon: Icon(Icons.keyboard_arrow_down),
          underline: Container(color: Colors.red),
          onChanged: (newValue) {
            print(newValue.toString() + "------------");
            setState(() {
              if (courseOption == "_pCourse1") {
                _pCourse1 = newValue;
              }
              if (courseOption == "_pCourse2") {
                _pCourse2 = newValue;
              }
              if (courseOption == "_pCourse3") {
                _pCourse3 = newValue;
              }
            });
          },
          items: listOfCategory.map((category) {
            return DropdownMenuItem(
              child: Container(
                  margin: EdgeInsets.only(left: 4, right: 4),
                  child: Text(category,
                      style: TextStyle(fontSize: 14, color: Colors.blueGrey))),
              value: category,
            );
          }).toList(),
        )),
      ));

  List<String> listOfCategory = [
    'Computer Science and Engineering',
    'Electrical and Electronics',
    'Electronics and Communication',
    'Mechanical Engineering',
    'Naval Architecture and Ship Building',
    'Civil Engineering'
  ];

  validateForm() {
    if (_pCourse1 != null && _pCourse2 != null && _pCourse3 != null) {
      setState(() {
        _isLoading = true;
      });
      Map<String, dynamic> p_course = {
        "p1": _pCourse1.toString(),
        "p2": _pCourse2.toString(),
        "p3": _pCourse3.toString(),
      };
      try {
        Firestore.instance
            .collection("Students")
            .document(global.currentUserId)
            .updateData({
          "coursePref": p_course,
          "profileStatus": "complete"
        }).then((value) => {
                  Navigator.pushReplacementNamed(context, "/individualPreview")
                });
        setState(() {
          _isLoading = false;
        });
        Toast.show(
            "Signness Administration team will contact you. \n Thank You !!!",
            context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.CENTER);
        setState(() {});
      } catch (error) {
        Toast.show(
            error + "Unable to update your data to server\n\nTry Again...",
            context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM);
      }
    } else {
      Toast.show(
          "Please choose the course \n \nBased on your preference", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      return ("Choose options..");
    }
  }

  @override
  Widget build(BuildContext context) {
    /*------------Main Widget----*/
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
    dynamic screenTemp;
    context.isMobile
        ? screenTemp = double.infinity
        : screenTemp = ScreenUtil().setWidth(350);
    return Form(
      key: _formKey,
      child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          margin: context.isMobile
              ? EdgeInsets.fromLTRB(30, 0, 30, 20)
              : EdgeInsets.fromLTRB(50, 0, 50, 50),
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: context.isMobile
                ? EdgeInsets.fromLTRB(20, 0, 20, 30)
                : EdgeInsets.fromLTRB(60, 0, 60, 30),
            child: LoadingOverlay(
                isLoading: _isLoading,
                opacity: 0.5,
                progressIndicator: CircularProgressIndicator(),
                child: SingleChildScrollView(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Divider(color: Colors.black38),
                        Text("Course Preference",
                            style: GoogleFonts.lato(
                                fontWeight: FontWeight.w800,
                                color: Colors.black54,
                                fontSize: context.isMobile
                                    ? ScreenUtil()
                                        .setSp(10, allowFontScalingSelf: false)
                                    : ScreenUtil().setSp(14,
                                        allowFontScalingSelf: false))),
                        Divider(color: Colors.black38),
                        Divider(color: Colors.transparent),
                        _textView("Preference 1", " *"),
                        _choiceTextForm("houseName", "_pCourse1"),
                        const SizedBox(height: 20.0),
                        _textView("Preference 2", " *"),
                        _choiceTextForm("houseName", "_pCourse2"),
                        const SizedBox(height: 20.0),
                        _textView("Preference 3", " *"),
                        _choiceTextForm("houseName", "_pCourse3"),
                        const SizedBox(height: 20.0),
                        Center(
                            child: RaisedButton(
                          color: Colors.green,
                          child: Text(" Submit "),
                          onPressed: () {
                            validateForm();
                            // mailSendToUser();
                          },
                        ))
                      ],
                    ))),
          )),
    );
  }
}
