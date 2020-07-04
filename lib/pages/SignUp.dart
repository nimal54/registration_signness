import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:registration/helpers/customAlert.dart';
import 'package:toast/toast.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:registration/helpers/global.dart' as global;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  String inputFullName,
      inputDateOfBirth,
      inputGender,
      inputEmail,
      inputPhoneNumber,
      inputCourse,
      inputQuota,
      errorMessage;
  int temp_id;

  _termsAndCondition(
      BuildContext context, AlertDialogType type, String contentData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          type: type,
          title: "Terms And Conditions",
          content: contentData,
        );
      },
    );
  }

  _popupAndSaveBasicDetailsToFirestore(
      BuildContext context, AlertDialogType type) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          type: type,
          title: "SuccessFully registered",
          content: "Information to your user describing the situation.",
        );
      },
    );
  }

  validateForm() async {
    if (formKey.currentState.validate() &&
        inputGender != null &&
        inputCourse != null &&
        inputQuota != null) {
      formKey.currentState.save();
      Toast.show("Please Wait...", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      setState(() {
        _isLoading = true;
      });
      try {
        await Firestore.instance
            .collection("id_Increment")
            .document("id")
            .get()
            .then((value) => {
                  temp_id = int.parse(value.data['user_id'].toString()),
                  temp_id = temp_id + 1,
                  Firestore.instance
                      .collection('Students')
                      .document(temp_id.toString())
                      .setData({
                    "applicationId": temp_id.toString(),
                    "dob&pass": inputDateOfBirth,
                    "name": inputFullName,
                    "email": inputEmail,
                    "course": inputCourse,
                    "phone": inputPhoneNumber,
                    "gender": inputGender,                    
                    "quota": inputQuota,
                    "profileStatus": "start"
                  }),
                  Firestore.instance
                      .collection("id_Increment")
                      .document("id")
                      .updateData({'user_id': temp_id}).then((value) => {
                            _popupAndSaveBasicDetailsToFirestore(
                                context, AlertDialogType.SUCCESS),
                            Navigator.pushReplacementNamed(context, "/home")
                          })
                });
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      Toast.show("Please fill up the details.", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      return ("Validation Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    /*------------------------Input widgets--------------------*/
    final fullName = Material(
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
              fillColor: Colors.grey[200],
            ),
            validator: (val) => val.length == 0 ? "Enter Full Name" : null,
            onSaved: (val) => inputFullName = val));
    final gender = Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          color: Colors.transparent,
          width: double.infinity,
          child: Card(
              child: DropdownButton(
            isExpanded: true,
            value: inputGender,
            style: TextStyle(fontSize: 14, color: Colors.blueGrey),
            icon: Icon(Icons.keyboard_arrow_down),
            underline: Container(color: Colors.red),
            onChanged: (newValue) {
              setState(() {
                inputGender = newValue.toString();
              });
            },
            items: <String>["Male", "Female"].map((category) {
              return DropdownMenuItem(
                child: Container(
                    margin: EdgeInsets.only(left: 4, right: 4),
                    child: Text(category,
                        style:
                            TextStyle(fontSize: 14, color: Colors.blueGrey))),
                value: category,
              );
            }).toList(),
          )),
        ));

    final email = Material(
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
            validator: (val) => val.length == 0 ? "Enter Email" : null,
            onSaved: (val) => inputEmail = val));
    final mobile = Material(
        elevation: 10.0,
        borderRadius: BorderRadius.circular(10.0),
        child: TextFormField(
            keyboardType: TextInputType.phone,
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
            validator: (val) => val.length == 0 ? "Enter Mobile" : null,
            onSaved: (val) => inputPhoneNumber = val));
    final dOBField = Material(
      elevation: 10.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.grey[200],
      child: MaterialButton(
        onPressed: () {
          showDatePicker(
                  context: context,
                  initialDate: inputDateOfBirth == null
                      ? DateTime.now()
                      : inputDateOfBirth,
                  firstDate: DateTime(1998),
                  lastDate: DateTime(2021))
              .then((date) {
            setState(() {
              inputDateOfBirth = date.day.toString() +
                  "/" +
                  date.month.toString() +
                  "/" +
                  date.year.toString();
            });
          });
        },
        child: Text(
          inputDateOfBirth == null ? "" : inputDateOfBirth.toString(),
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 20, color: Colors.grey),
        ),
      ),
    );
    final course = Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          color: Colors.transparent,
          width: double.infinity,
          child: Card(
              child: DropdownButton(
            isExpanded: true,
            value: inputCourse,
            style: TextStyle(fontSize: 14, color: Colors.blueGrey),
            icon: Icon(Icons.keyboard_arrow_down),
            underline: Container(color: Colors.red),
            onChanged: (newValue) {
              setState(() {
                inputCourse = newValue.toString();
              });
            },
            items: <String>["B.Tech", "M.Tech"].map((category) {
              return DropdownMenuItem(
                child: Container(
                    margin: EdgeInsets.only(left: 4, right: 4),
                    child: Text(category,
                        style:
                            TextStyle(fontSize: 14, color: Colors.blueGrey))),
                value: category,
              );
            }).toList(),
          )),
        ));

    final quota = Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          color: Colors.transparent,
          width: double.infinity,
          child: Card(
              child: DropdownButton(
            isExpanded: true,
            value: inputQuota,
            style: TextStyle(fontSize: 14, color: Colors.blueGrey),
            icon: Icon(Icons.keyboard_arrow_down),
            underline: Container(color: Colors.red),
            onChanged: (newValue) {
              setState(() {
                inputQuota = newValue.toString();
              });
            },
            items: <String>["Management"].map((category) {
              return DropdownMenuItem(
                child: Container(
                    margin: EdgeInsets.only(left: 4, right: 4),
                    child: Text(category,
                        style:
                            TextStyle(fontSize: 14, color: Colors.blueGrey))),
                value: category,
              );
            }).toList(),
          )),
        ));

    final registerButton = Material(
      elevation: 10.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.greenAccent[200],
      child: MaterialButton(
        onPressed: () {
          validateForm();
        },
        child: Text(
          'Register',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
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
        key: formKey,
        child: Container(
            width: screenTemp,
            margin: context.isMobile
                ? EdgeInsets.fromLTRB(30, 0, 30, 0)
                : EdgeInsets.fromLTRB(50, 0, 50, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
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
                            Text("\tName"),
                            fullName,
                            const SizedBox(height: 20.0),
                            Text("\tGender"),
                            gender,
                            const SizedBox(height: 20.0),
                            Text("\tEmail"),
                            email,
                            const SizedBox(height: 20.0),
                            Text("\tMobile"),
                            mobile,
                            const SizedBox(height: 20.0),
                            Text("\tDate Of Birth"),
                            Container(child: dOBField, width: double.infinity),
                            const SizedBox(height: 30.0),
                            Text("\tCourse"),
                            course,
                            const SizedBox(height: 20.0),
                            Text("\tQuota"),
                            quota,
                            const SizedBox(height: 30.0),
                            Center(child: registerButton),
                            const SizedBox(height: 30.0),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("I accept the  "),
                                  GestureDetector(
                                      child: Text("Terms & Conditions",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              decoration:
                                                  TextDecoration.underline,
                                              color: Colors.blue)),
                                      onTap: () {
                                        String data = "\t1. The privacy policy governs the use of this website.\n" +
                                            "\t2. We are committed to protect your privacy and work towards offering you a useful, safe online experience.\n" +
                                            "\t3. Your information, whether public or private, will not be sold, exchanged, transferred, or given by the college, to any other institution for any reason whatsoever, without your consent.\n" +
                                            "\t4. We reserves the right, in its discretion, to change or modify all or any part of this Agreement at any time, effective immediately upon notice published on the site. Your continued use of " +
                                            "the website constitutes your binding acceptance of these terms and conditions, including any changes or modifications made by the us as permitted above.\n"
                                                "\t5. We treats your personal information or your use of the service as private and confidential and does not check, edit or reveal it to any third parties except " +
                                            "where it believes in good faith, such action is necessary to comply with the applicable legal and regulatory processes or to protect and defend the rights of other " +
                                            "users or to enforce the terms of service which are binding on all the users of the site.\n" +
                                            "\t6.We also has right to send both SMS and Mail which may include promotions etc.";
                                        _termsAndCondition(context,
                                            AlertDialogType.INFO, data);
                                      })
                                ]),
                          ]))),
            )));
  }
}
