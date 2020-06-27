import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:registration/helpers/global.dart' as global;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:registration/pages/subFolder/EducationalInformation.dart';
import 'package:registration/pages/subFolder/dashboard_workspace.dart';
import 'package:toast/toast.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:loading_overlay/loading_overlay.dart';

class ContactInformation extends StatefulWidget {
  Function callback;
  ContactInformation(this.callback);

  @override
  _ContactInformationState createState() =>
      _ContactInformationState(this.callback);
}

class _ContactInformationState extends State<ContactInformation> {
  Function callback;
  _ContactInformationState(this.callback);

  @override
  void initState() {
    _educationalInformation = EducationalInformation(this.callback);
  }

  bool _isLoading = false;
  Future<File> imageFile;
  final _formKey = new GlobalKey<FormState>();

  EducationalInformation _educationalInformation;

  String _profileImage,
      _houseName,
      _postOffice,
      _panchayat,
      _district,
      _state,
      _pinCode,
      _fatherName,
      _fatherOccupation,
      _fatherPhoneNumber,
      _10thMark,
      _10thSchoolName,
      _annualIncome,
      _nationality,
      _religion,
      _caste;

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

  _choiceTextForm(String _inputFeild) => Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        color: Colors.transparent,
        width: double.infinity,
        child: Card(
            child: DropdownButton(
          isExpanded: true,
          value: _district,
          style: TextStyle(fontSize: 14, color: Colors.blueGrey),
          icon: Icon(Icons.keyboard_arrow_down),
          underline: Container(color: Colors.red),
          onChanged: (newValue) {
            print(newValue.toString() + "------------");
            setState(() {
              if (_inputFeild == "district") {
                _district = newValue;
              }
            });
          },
          items: listOfDistrict.map((category) {
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

  List<String> listOfDistrict = [
    "Alappuzha",
    "Ernakulam",
    "Idukki",
    "Kannur",
    "Kasargod",
    "Kollam",
    "Kottayam",
    "Kozhikode",
    "Malappuram",
    "Palakkad",
    "Pathanamthitta",
    "Thrissur",
    "Trivandrum",
    "Wayanad",
  ];

  _textFormViewer(String _inputFeild) => Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      child: TextFormField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.transparent, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.green),
              ),
              contentPadding: EdgeInsets.all(14.0),
              fillColor: Colors.grey[200]),
          validator: (val) => val.length >= 0 && _inputFeild == "caste"
              ? null
              : val.length >= 0 && _inputFeild == "religion"
                  ? null
                  : val.length == 0 ? "Enter the details... " : null,
          onSaved: (val) => {
                print(_inputFeild.toString() + "---input\n"),
                if (_inputFeild == "houseName")
                  {_houseName = val}
                else if (_inputFeild == "postOffice")
                  {_postOffice = val}
                else if (_inputFeild == "panchayat")
                  {_panchayat = val}
                else if (_inputFeild == "state")
                  {_state = val}
                else if (_inputFeild == "pinCode")
                  {_pinCode = val}
                else if (_inputFeild == "fatherName")
                  {_fatherName = val}
                else if (_inputFeild == "fatherOccupation")
                  {_fatherOccupation = val}
                else if (_inputFeild == "fatherPhoneNumber")
                  {_fatherPhoneNumber = val}
                else if (_inputFeild == "10thMark")
                  {_10thMark = val}
                else if (_inputFeild == "10thSchoolName")
                  {_10thSchoolName = val}
                else if (_inputFeild == "annualIncome")
                  {_annualIncome = val}
                else if (_inputFeild == "nationality")
                  {_nationality = val}
                else if (_inputFeild == "religion")
                  {_religion = val}
                else if (_inputFeild == "caste")
                  {_caste = val}
              }));

  validateForm() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        _isLoading = true;
      });
      Map<String, dynamic> contactDetails = {
        "houseName": _houseName,
        "postOffice": _postOffice,
        "panchayat": _panchayat,
        "district": _district,
        "state": _state,
        "pinCode": _pinCode.toString(),
        "fatherName": _fatherName,
        "fatherOccupation": _fatherOccupation,
        "fatherPhoneNumber": _fatherPhoneNumber.toString(),
        "10thMark": _10thMark.toString(),
        "10thSchoolName": _10thSchoolName,
        "annualIncome": _annualIncome.toString(),
        "nationality": _nationality,
        "religion": _religion,
        "caste": _caste
      };
      try {
        await Firestore.instance
            .collection("moreDetails")
            .document(global.currentUser)
            .updateData({"contactDetails": contactDetails}).then((value) => {
                  this
                      .widget
                      .callback(new EducationalInformation(this.callback))
                });
      } catch (error) {
        Toast.show(
            error + "Unable to update your data to server\n\nTry Again...",
            context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM);
      }
    } else {
      return ("Validation Error");
    }

    setState(() {
      _isLoading = true;
    });
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
                        Text("Contact Info",
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
                        _textView("House Name", "*"),
                        _textFormViewer("houseName"),
                        const SizedBox(height: 20.0),
                        _textView("Post Office", "*"),
                        _textFormViewer("postOffice"),
                        const SizedBox(height: 20.0),
                        _textView("Panchayat", "*"),
                        _textFormViewer("panchayat"),
                        const SizedBox(height: 20.0),
                        _textView("District", "*"),
                        _choiceTextForm("district"),
                        const SizedBox(height: 20.0),
                        _textView("State", "*"),
                        _textFormViewer("state"),
                        const SizedBox(height: 20.0),
                        _textView("Pin Code", "*"),
                        _textFormViewer("pinCode"),
                        const SizedBox(height: 20.0),
                        _textView("Parent / Guardian Name", "*"),
                        _textFormViewer("fatherName"),
                        const SizedBox(height: 20.0),
                        _textView("Parent / Guardian Occupation", "*"),
                        _textFormViewer("fatherOccupation"),
                        const SizedBox(height: 20.0),
                        _textView("Parent / Guardian Mobile Number", "*"),
                        _textFormViewer("fatherPhoneNumber"),
                        const SizedBox(height: 20.0),
                        _textView("10th Mark", "*"),
                        _textFormViewer("10thMark"),
                        const SizedBox(height: 20.0),
                        _textView("10th School Name", "*"),
                        _textFormViewer("10thSchoolName"),
                        const SizedBox(height: 20.0),
                        _textView("Annual Income", "*"),
                        _textFormViewer("annualIncome"),
                        const SizedBox(height: 20.0),
                        _textView("Nationality", "*"),
                        _textFormViewer("nationality"),
                        const SizedBox(height: 20.0),
                        _textView("Religion", ""),
                        _textFormViewer("religion"),
                        const SizedBox(height: 20.0),
                        _textView("Caste", ""),
                        _textFormViewer("caste"),
                        const SizedBox(height: 40.0),
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
