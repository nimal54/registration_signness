import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey = new GlobalKey<FormState>();
  String inputApplicationNumber, inputDateOfBirth;

  validateForm() async {
    print("inside");
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      print(inputDateOfBirth + "--" + inputApplicationNumber);
    } else {
      print("esle");
      return ("Validation Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    /*------------------------Input widgets--------------------*/
    final applicationField = Material(
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
                val.length == 0 ? "Enter Application No:" : "null",
            onSaved: (val) => inputApplicationNumber = val));

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
          inputDateOfBirth == null ? '' : inputDateOfBirth.toString(),
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 20, color: Colors.grey),
        ),
      ),
    );

    final loginButton = Material(
      elevation: 10.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.green[200],
      child: MaterialButton(
        onPressed: () {
          // validateForm();
          Navigator.pushReplacementNamed(context, "/dashboard");
        },
        child: Text(
          'Login',
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
                  Text("Application Id9"),
                  applicationField,
                  const SizedBox(height: 20.0),
                  Text("Date Of Birth"),
                  dOBField,
                  const SizedBox(height: 30.0),
                  loginButton
                ])));
  }
}
