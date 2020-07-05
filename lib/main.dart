import 'package:flutter/material.dart';
import 'package:registration/pages/AllUsersPreview.dart';
import 'package:registration/pages/HomePage.dart';
import 'package:registration/pages/PreviewPage.dart';
import 'package:registration/pages/subFolder/dashboard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/home",
      title: 'Registration',
      debugShowCheckedModeBanner: false,
      routes: {
        "/dashboard": (context) => Dashboard(),
        "/home": (context) => HomePage(),
        "/nimal_admin_page": (context) => AllUsersPreview(),
        "/individualPreview": (context) => PreviewPage()
      },
    );
  }
}

// http://localhost:49926/#/home
// http://localhost:49926/#/individualPreview

// http://localhost:49926/#/nimal_admin_page
