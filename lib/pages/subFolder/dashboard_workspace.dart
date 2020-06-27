import 'package:flutter/material.dart';
import 'package:registration/pages/subFolder/ContactInformation.dart';
import 'package:registration/pages/subFolder/CoursePreference.dart';
import 'package:registration/pages/subFolder/EducationalInformation.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => new _RootPageState();
}

class _RootPageState extends State<RootPage> {
  ContactInformation _contactInformation;
  EducationalInformation _educationalInformation;
  CoursePreference _coursePreference;

  Widget currentPage;

  @override
  void initState() {
    super.initState();
    _contactInformation = ContactInformation(this.callback);
    currentPage = _contactInformation;
  }

  void callback(Widget nextPage) {
    setState(() {
      this.currentPage = nextPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(body: currentPage);
  }
}
