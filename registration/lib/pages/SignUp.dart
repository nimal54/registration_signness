import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:registration/helpers/customAlert.dart';
import 'package:toast/toast.dart';
import 'package:velocity_x/velocity_x.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = new GlobalKey<FormState>();
  String inputFullName,
      inputDateOfBirth,
      inputGender,
      inputEmail,
      inputPhoneNumber,
      inputCourse,
      inputQuota,
      errorMessage;

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
    print("inside");
    if (formKey.currentState.validate() &&
        inputCourse != null &&
        inputQuota != null) {
      formKey.currentState.save();
      Toast.show("Please Wait...", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      try {
        print("inininside");
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: inputEmail, password: inputDateOfBirth)
            .then((result) async {
          print(result.user.uid.toString() + "--user uid");
          await Firestore.instance
              .collection('Students')
              .document(result.user.uid)
              .setData({
            "name": inputFullName,
            "dob&pass": inputDateOfBirth,
            "applicationId": result.user.uid,
            "phone": inputPhoneNumber,
            "gender": inputGender,
            "course": inputCourse,
            "quota": inputQuota,
            "email": inputEmail
          });
          _popupAndSaveBasicDetailsToFirestore(
              context, AlertDialogType.SUCCESS);
        Navigator.pushReplacementNamed(context,"/home");
        });
      } catch (error) {
        switch (error.code) {
          case "ERROR_INVALID_EMAIL":
            errorMessage =
                "Your email address appears to be malformed or remove whitespace from end";
            print(errorMessage);
            Toast.show(errorMessage, context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
            break;
          case "ERROR_WRONG_PASSWORD":
            errorMessage = "Your password is wrong.";
            print(errorMessage);
            Toast.show(errorMessage, context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
            break;
          case "ERROR_USER_NOT_FOUND":
            errorMessage = "User with this email doesn't exist.";
            print(errorMessage);
            Toast.show(errorMessage, context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
            break;
          case "ERROR_OPERATION_NOT_ALLOWED":
            errorMessage = "Signing in with Email and Password is not enabled.";
            print(errorMessage);
            Toast.show(errorMessage, context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
            break;
          default:
            errorMessage = "An undefined Error happened.";
            print(errorMessage);
            Toast.show(errorMessage, context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        }
      }
    } else {
      print("esle");
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
        elevation: 10.0,
        borderRadius: BorderRadius.circular(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(inputGender == null ? "Choose One" : inputGender),
            DropdownButton(
                items: <String>["Male", "Female", "Other"].map((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
                onChanged: (result) {
                  setState(() {
                    inputGender = result.toString();
                  });
                })
          ],
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
        elevation: 10.0,
        borderRadius: BorderRadius.circular(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(inputCourse == null ? "Choose One" : inputCourse),
            DropdownButton(
                items: <String>["B.Tech", "M.Tech"].map((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
                onChanged: (result) {
                  setState(() {
                    inputCourse = result.toString();
                  });
                })
          ],
        ));

    final quota = Material(
        elevation: 10.0,
        borderRadius: BorderRadius.circular(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(inputQuota == null ? "Choose One" : inputQuota),
            DropdownButton(
                items: <String>["Management"].map((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
                onChanged: (result) {
                  setState(() {
                    inputQuota = result.toString();
                  });
                })
          ],
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
            child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(16.0),
                children: <Widget>[
                  Text("Name"),
                  fullName,
                  const SizedBox(height: 20.0),
                  Text("Gender"),
                  gender,
                  const SizedBox(height: 20.0),
                  Text("Email"),
                  email,
                  const SizedBox(height: 20.0),
                  Text("Mobile"),
                  mobile,
                  const SizedBox(height: 20.0),
                  Text("Date Of Birth"),
                  dOBField,
                  const SizedBox(height: 30.0),
                  Text("Course"),
                  course,
                  const SizedBox(height: 20.0),
                  Text("Quota"),
                  quota,
                  const SizedBox(height: 30.0),
                  registerButton,
                  const SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("I accept the  "),
                      GestureDetector(
                          child: Text("Terms & Conditions",
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue)),
                          onTap: () {
                            String data = "1. The privacy policy governs the use of this website.\n" +
                                "2. We are committed to protect your privacy and work towards offering you a useful, safe online experience.\n" +
                                "3. Your information, whether public or private, will not be sold, exchanged, transferred, or given by the college, to any other institution for any reason whatsoever, without your consent.\n" +
                                "4. We reserves the right, in its discretion, to change or modify all or any part of this Agreement at any time, effective immediately upon notice published on the site. Your continued use of " +
                                "the website constitutes your binding acceptance of these terms and conditions, including any changes or modifications made by the us as permitted above.";
                            _termsAndCondition(
                                context, AlertDialogType.INFO, data);
                          })
                    ],
                  )
                ])));
  }
}
