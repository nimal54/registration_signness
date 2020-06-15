import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:registration/pages/subFolder/ContactInformation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class BasicInformation extends StatefulWidget {
  Function callback;
  BasicInformation(this.callback);
  @override
  _BasicInformationState createState() => _BasicInformationState();
}

class _BasicInformationState extends State<BasicInformation> {
  Future<File> imageFile;
  final _formKey = new GlobalKey<FormState>();
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

  /*-----------image selector-------*/

  validateForm() {
    if (_formKey.currentState.validate()) {
      print (_houseName.toString());
      print (_postOffice.toString());
      print (_panchayat.toString());
      print (_district.toString());
      print (_state.toString());
      print (_pinCode.toString());
      print (_fatherName.toString());
      print (_fatherOccupation.toString());
      print (_fatherPhoneNumber.toString());
      print (_10thMark.toString());
      print (_10thSchoolName.toString());
      print (_annualIncome.toString());
      print (_nationality.toString());
      print (_religion.toString());
      print (_caste.toString());
      _formKey.currentState.save();
    } else {
      return ("Validation Error");
    }
  }

  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Image.file(
            snapshot.data,
            width: 300,
            height: 300,
          );
        } else if (snapshot.error != null) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
/*-------------TextForm Widgets---------------------*/
    final txtFormFeild_houseName = Material(
        elevation: 10.0,
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
            validator: (val) =>
                val.length == 0 ? "Enter the details... " : null,
            onSaved: (val) => _houseName = val));
    final txtFormFeild_postOffice = Material(
        elevation: 10.0,
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
            validator: (val) =>
                val.length == 0 ? "Enter the details... " : null,
            onSaved: (val) => _postOffice = val));
    final txtFormFeild_panchayat = Material(
        elevation: 10.0,
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
            validator: (val) =>
                val.length == 0 ? "Enter the details... " : null,
            onSaved: (val) => _panchayat = val));
    final txtFormFeild_district = Material(
        elevation: 10.0,
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
            validator: (val) =>
                val.length == 0 ? "Enter the details... " : null,
            onSaved: (val) => _district = val));
    final txtFormFeild_state = Material(
        elevation: 10.0,
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
            validator: (val) =>
                val.length == 0 ? "Enter the details... " : null,
            onSaved: (val) => _state = val));
    final txtFormFeild_pinCode = Material(
        elevation: 10.0,
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
            validator: (val) =>
                val.length == 0 ? "Enter the details... " : null,
            onSaved: (val) => _pinCode = val));
    final txtFormFeild_fatherName = Material(
        elevation: 10.0,
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
            validator: (val) =>
                val.length == 0 ? "Enter the details... " : null,
            onSaved: (val) => _fatherName = val));
    final txtFormFeild_fatherOccupation = Material(
        elevation: 10.0,
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
            validator: (val) =>
                val.length == 0 ? "Enter the details... " : null,
            onSaved: (val) => _fatherOccupation = val));
    final txtFormFeild_fatherPhoneNumber = Material(
        elevation: 10.0,
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
            validator: (val) =>
                val.length == 0 ? "Enter the details... " : null,
            onSaved: (val) => _fatherPhoneNumber = val));
    final txtFormFeild_10thMark = Material(
        elevation: 10.0,
        borderRadius: BorderRadius.circular(10.0),
        child: TextFormField(
            keyboardType: TextInputType.number,
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
            validator: (val) =>
                val.length == 0 ? "Enter the details... " : null,
            onSaved: (val) => _10thMark = val));
    final txtFormFeild_10thSchoolName = Material(
        elevation: 10.0,
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
            validator: (val) =>
                val.length == 0 ? "Enter the details... " : null,
            onSaved: (val) => _10thSchoolName = val));
    final txtFormFeild_annualIncome = Material(
        elevation: 10.0,
        borderRadius: BorderRadius.circular(10.0),
        child: TextFormField(
            keyboardType: TextInputType.number,
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
            validator: (val) =>
                val.length == 0 ? "Enter the details... " : null,
            onSaved: (val) => _annualIncome = val));
    final txtFormFeild_nationality = Material(
        elevation: 10.0,
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
            validator: (val) =>
                val.length == 0 ? "Enter the details... " : null,
            onSaved: (val) => _nationality = val));
    final txtFormFeild_religion = Material(
        elevation: 10.0,
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
            validator: (val) =>
                val.length == 0 ? "Enter the details... " : null,
            onSaved: (val) => _religion = val));
    final txtFormFeild_caste = Material(
        elevation: 10.0,
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
            validator: (val) =>
                val.length == 0 ? "Enter the details... " : null,
            onSaved: (val) => _caste = val));

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
          width: double.infinity,
          margin: context.isMobile
              ? EdgeInsets.fromLTRB(30, 0, 30, 0)
              : EdgeInsets.fromLTRB(50, 0, 50, 0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Center(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(15.0),
              children: <Widget>[
                /*
                showImage(),
                RaisedButton(
              child: Text("Select Image from Gallery"),
              onPressed: () {
                pickImageFromGallery(ImageSource.gallery);
                  },
                ),*/
                Divider(color: Colors.black38),
                Text("Personal Info",
                    style: GoogleFonts.lato(
                        fontWeight: FontWeight.w800,
                        color: Colors.black54,
                        fontSize: context.isMobile
                            ? ScreenUtil()
                                .setSp(10, allowFontScalingSelf: false)
                            : ScreenUtil()
                                .setSp(14, allowFontScalingSelf: false))),
                Divider(color: Colors.black38),
                Divider(color: Colors.transparent),
                Text("House Name*"),
                txtFormFeild_houseName,
                const SizedBox(height: 20.0),
                Text("Post Office*"),
                txtFormFeild_postOffice,
                const SizedBox(height: 20.0),
                Text("Panchayat*"),
                txtFormFeild_panchayat,
                const SizedBox(height: 20.0),
                Text("Dictrict*"),
                txtFormFeild_district,
                const SizedBox(height: 20.0),
                Text("State*"),
                txtFormFeild_state,
                const SizedBox(height: 20.0),
                Text("Pin Code*"),
                txtFormFeild_pinCode,
                const SizedBox(height: 20.0),
                Text("Parent / Guardian Name*"),
                txtFormFeild_fatherName,
                const SizedBox(height: 20.0),
                Text("Parent / Guardian Occupation*"),
                txtFormFeild_fatherOccupation,
                const SizedBox(height: 20.0),
                Text("Parent / Guardian Mobile Number*"),
                txtFormFeild_fatherPhoneNumber,
                const SizedBox(height: 20.0),
                Text("10th Mark*"),
                txtFormFeild_10thMark,
                const SizedBox(height: 20.0),
                Text("10th School Name*"),
                txtFormFeild_10thSchoolName,
                const SizedBox(height: 20.0),
                Text("Annual Income*"),
                txtFormFeild_annualIncome,
                const SizedBox(height: 20.0),
                Text("Nationality*"),
                txtFormFeild_nationality,
                const SizedBox(height: 20.0),
                Text("Religion"),
                txtFormFeild_religion,
                const SizedBox(height: 20.0),
                Text("Caste*"),
                txtFormFeild_caste,
                const SizedBox(height: 20.0),
                const SizedBox(height: 40.0),
                RaisedButton(
                  color: Colors.orange[200],
                  child: Text(" Save and continue "),
                  onPressed: () {
                    validateForm();
                  },
                )
              ],
            ),
          )),
    );
  }
}
