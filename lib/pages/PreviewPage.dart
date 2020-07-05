import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:registration/helpers/theme_helper.dart';
import 'package:registration/pages/AllUsersPreview.dart';
import 'package:registration/pages/SinglePreview.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:registration/helpers/global.dart' as global;

class PreviewPage extends StatefulWidget {
  @override
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  var fromFirestoreForPreview;

  void initState() {
    print("enter");
    fromFirestoreForPreview = getPosts();
    // global.dataPreview = fromFirestoreForPreview;
    print(fromFirestoreForPreview);
    print("init_fromFirestoreForPreview");
  }

  Future getPosts() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection("Students")
        .where("profileStatus", isEqualTo: "complete")
        .where("applicationId", isEqualTo: global.currentUserId)
        .getDocuments();
    return qn.documents;
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
    int _flex1, _flex2;
    context.isMobile ? _flex1 = 0 : _flex1 = 0;
    context.isMobile ? _flex2 = 2 : _flex2 = 1;
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
                color: Colors.white10, //ThemeHelper.backgroundRed,
                margin: context.isMobile
                    ? EdgeInsets.fromLTRB(8, 10, 8, 20)
                    : EdgeInsets.fromLTRB(100, 20, 100, 100),
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                child: FutureBuilder<dynamic>(
                    future: fromFirestoreForPreview,
                    builder: (_, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                            width: 150,
                            height: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(),
                                Text("\nPlease wait..")
                              ],
                            ));
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        DocumentSnapshot ds;
                        Map<String, dynamic> map;
                        print("clearing..");
                        global.dataPreview = null;
                        print(snapshot.data);
                        ds = snapshot.data[0];
                        print(ds);
                        map = ds.data;
                        global.dataPreview = map;

                        print(global.dataPreview);
                        print("_______________*___________\n\n");
                        return SinglePreview();
                      }
                    }))));
  }
}
