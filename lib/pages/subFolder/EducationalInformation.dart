import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:registration/helpers/global.dart' as global;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:registration/pages/subFolder/CoursePreference.dart';
import 'package:toast/toast.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:loading_overlay/loading_overlay.dart';

class EducationalInformation extends StatefulWidget {
  Function callback;
  EducationalInformation(this.callback);

  @override
  _EducationalInformationState createState() =>
      _EducationalInformationState(this.callback);
}

class _EducationalInformationState extends State<EducationalInformation> {
  Function callback;
  _EducationalInformationState(this.callback);
  bool _isLoading = false;
  final _formKey = new GlobalKey<FormState>();
  String _12thStream,
      _12PassingYear,
      _12registerNumber,
      _12institutionName,
      _12markObtained,
      _12maxMark,
      _12percentage,
      _mathsSub,
      _mathsSubMark,
      _mathsSubMaxMark,
      _physicsSub,
      _physicsSubMark,
      _physicsSubMaxMark,
      _chemistrySub,
      _chemistrySubMark,
      _chemistrySubMaxMark,
      _entrance,
      _entranceYear,
      _entranceRank,
      _entranceApplicationNumber;

  _textFormViewer(String _inputFeild, bool _readOnly, String _hintContent) =>
      Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(10.0),
          child: TextFormField(
              readOnly: _readOnly,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide:
                        BorderSide(color: Colors.transparent, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  contentPadding: EdgeInsets.all(14.0),
                  hintText: _inputFeild != "_12percentage"
                      ? _hintContent.toString()
                      : _12percentage == "" ? "%" : _12percentage.toString(),
                  fillColor: _readOnly ? Colors.black12 : Colors.grey[100]),
              validator: (val) => val.length >= 0 && _inputFeild == "_12maxMark"
                  ? null
                  : val.length >= 0 && _inputFeild == "_mathsSub"
                      ? null
                      : val.length >= 0 && _inputFeild == "_mathsSubMaxMark"
                          ? null
                          : val.length >= 0 && _inputFeild == "_physicsSub"
                              ? null
                              : val.length >= 0 && _inputFeild == "_physicsSubMaxMark"
                                  ? null
                                  : val.length >= 0 && _inputFeild == "_chemistrySub"
                                      ? null
                                      : val.length >= 0 && _inputFeild == "_chemistrySubMaxMark"
                                          ? null
                                          : val.length >= 0 &&
                                                  _inputFeild == "_entrance"
                                              ? null
                                              : val.length >= 0 && _inputFeild == "_12percentage"
                                                  ? null
                                                  : val.length >= 0 && _inputFeild == "_entranceYear"
                                                      ? null
                                                      : val.length >= 0 && _inputFeild == "_entranceRank"
                                                          ? null
                                                          : val.length >= 0 &&
                                                                  _inputFeild ==
                                                                      "_entranceApplicationNumber"
                                                              ? null
                                                              : val.length == 0
                                                                  ? "Enter the details... "
                                                                  : null,
              onChanged: (res) => {
                    if (_inputFeild == "_12markObtained")
                      {
                        _12markObtained = res,
                        setState(() {
                          var myInt = int.parse(_12markObtained);
                          print("iiinin");
                          var myDou = ((myInt / 1200) * 100).toDouble();
                          _12percentage = myDou.toString();
                        })
                      }
                  },
              onSaved: (val) => {
                    if (_inputFeild == "_12thStream")
                      {_12thStream = val}
                    else if (_inputFeild == "_12PassingYear")
                      {_12PassingYear = val}
                    else if (_inputFeild == "_12registerNumber")
                      {_12registerNumber = val}
                    else if (_inputFeild == "_12institutionName")
                      {_12institutionName = val}
                    else if (_inputFeild == "_12markObtained")
                      {_12markObtained = val}
                    else if (_inputFeild == "_12percentage")
                      {_12percentage = val}
                    else if (_inputFeild == "_mathsSubMark")
                      {_mathsSubMark = val}
                    else if (_inputFeild == "_physicsSubMark")
                      {_physicsSubMark = val}
                    else if (_inputFeild == "_chemistrySubMark")
                      {_chemistrySubMark = val}
                    else if (_inputFeild == "_entranceYear")
                      {_entranceYear = val}
                    else if (_inputFeild == "_entranceRank")
                      {_entranceRank = val}
                    else if (_inputFeild == "_entranceApplicationNumber")
                      {_entranceApplicationNumber = val}
                  }));

  validateForm() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        _isLoading = true;
      });
      Map<String, dynamic> contactDetails = {
        "_12thStream": _12thStream,
        "_12PassingYear": _12PassingYear,
        "_12registerNumber": _12registerNumber,
        "_12institutionName": _12institutionName,
        "_12markObtained": _12markObtained,
        "_12percentage": _12percentage,
        "_mathsSubMark": _mathsSubMark,
        "_physicsSubMark": _physicsSubMark,
        "_chemistrySubMark": _chemistrySubMark,
        "_entrance": _entrance.toString(),
        "_entranceYear": _entranceYear.toString(),
        "_entranceRank": _entranceRank.toString(),
        "_entranceApplicationNumbe": _entranceApplicationNumber.toString(),
      };
      try {
        await Firestore.instance
            .collection("moreDetails")
            .document(global.currentUser)
            .updateData({"educationDetails": contactDetails}).then((value) =>
                {this.widget.callback(new CoursePreference(this.callback))});
      } catch (error) {
        Toast.show(
            error + "Unable to update your data to server\n\nTry Again...",
            context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM);
      }
      setState(() {
        _isLoading = false;
      });
    } else {
      return ("Validation Error");
    }
  }

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
                        Text("Qualification Info",
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
                        _textView("12th Standard Examination", "*"),
                        _textFormViewer(
                            "_12thStream", false, "HSE/ VHSE/ CBSE/ ICSE"),
                        const SizedBox(height: 20.0),

                        _textView("12th Year of passing", "*"),
                        _textFormViewer("_12PassingYear", false, ""),
                        const SizedBox(height: 20.0),

                        _textView("Register Number", "*"),
                        _textFormViewer("_12registerNumber", false, ""),
                        const SizedBox(height: 20.0),

                        _textView("Institution Name", "*"),
                        _textFormViewer("_12institutionName", false, ""),
                        const SizedBox(height: 20.0),

                        _textView("Mark Obtained", "*"),
                        _textFormViewer("_12markObtained", false, ""),
                        const SizedBox(height: 20.0),

                        _textView("Maximum Marks", " "),
                        _textFormViewer("_12maxMark", true, "1200"),
                        const SizedBox(height: 20.0),

                        _textView("%", " "),
                        _textFormViewer("_12percentage", true, "%"),
                        const SizedBox(height: 20.0),

                        SizedBox(width: 40, height: 40),
                        Text("Details of Qualifying Examination(12th only)"),
                        Divider(color: Colors.black26),
                        SizedBox(width: 15, height: 15),

                        _textView("Subject", "*"), //maths
                        _textFormViewer("_mathsSub", true, "Mathematics"),
                        const SizedBox(height: 20.0),

                        _textView("Mark Obtained", "*"), //maths
                        _textFormViewer("_mathsSubMark", false, " "),
                        const SizedBox(height: 20.0),

                        _textView("Maximum Mark", "*"), //maths
                        _textFormViewer("_mathsSubMaxMark", true, "100"),
                        const SizedBox(height: 20.0),

                        _textView("Subject", "*"), //phy
                        _textFormViewer("_physicsSub", true, "Physics"),
                        const SizedBox(height: 20.0),

                        _textView("Mark Obtained", "*"), //phy
                        _textFormViewer("_physicsSubMark", false, " "),
                        const SizedBox(height: 20.0),

                        _textView("Maximum Mark", "*"), //phy
                        _textFormViewer("_physicsSubMaxMark", true, "120"),
                        const SizedBox(height: 20.0),

                        _textView("Subject", "*"), //che
                        _textFormViewer("_chemistrySub", true, "Chemistry"),
                        const SizedBox(height: 20.0),

                        _textView("Mark Obtained", "*"), //che
                        _textFormViewer("_chemistrySubMark", false, " "),
                        const SizedBox(height: 20.0),

                        _textView("Maximum Mark", "*"), //che
                        _textFormViewer("_chemistrySubMaxMark", true, "120"),
                        const SizedBox(height: 20.0),

                        SizedBox(width: 40, height: 40),
                        Text("Entrance Details"),
                        Divider(color: Colors.black26),
                        SizedBox(width: 15, height: 15),

                        _textView("Entrance Examnation", " "),
                        _textFormViewer("_entrance", true,
                            "KEAM (KERALA GOVERNMENT ENTRANCE EXAMINATION)"),
                        const SizedBox(height: 20.0),

                        _textView("Year", " "),
                        _textFormViewer("_entranceYear", false, ""),
                        const SizedBox(height: 20.0),

                        _textView("Rank", " "),
                        _textFormViewer("_entranceRank", false, ""),
                        const SizedBox(height: 20.0),

                        _textView("Entrance Application No", " "),
                        _textFormViewer(
                            "_entranceApplicationNumber", false, ""),
                        const SizedBox(height: 20.0),

                        Center(
                            child: RaisedButton(
                          color: Colors.orange[200],
                          child: Text(" Save and continue "),
                          onPressed: () {
                            validateForm();
                          },
                        ))
                      ],
                    ))),
          )),
    );
  }
}
