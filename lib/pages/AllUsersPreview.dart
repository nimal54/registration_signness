import 'package:registration/helpers/global.dart' as global;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:registration/helpers/theme_helper.dart';
import 'package:velocity_x/velocity_x.dart';

class AllUsersPreview extends StatefulWidget {
  @override
  _AllUsersPreviewState createState() => _AllUsersPreviewState();
}

class _AllUsersPreviewState extends State<AllUsersPreview> {
  var fromFirestore;
  void initState() {
    fromFirestore = getPosts();
    print(fromFirestore);
    print("init_AllUserPreview");
  }

  Future getPosts() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection("Students")
        .where("profileStatus", isEqualTo: "complete")
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
                    // height: ,
                  ),
                ],
              )),
        ),
        backgroundColor: ThemeHelper.backgroundRed,
        body: SingleChildScrollView(
            child: Container(
                color: Colors.white,
                margin: context.isMobile
                    ? EdgeInsets.fromLTRB(8, 10, 8, 20)
                    : EdgeInsets.fromLTRB(100, 20, 100, 100),
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                child: FutureBuilder<dynamic>(
                    future: fromFirestore,
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
                        int cc = snapshot.data.length;
                        DocumentSnapshot ds;
                        Map<String, dynamic> map;
                        global.listOfAllUsers.clear();
                        for (int i = 0; i < cc; i++) {
                          ds = snapshot.data[i];
                          map = ds.data;
                          global.listOfAllUsers.add(map);
                        }
                        print(global.listOfAllUsers);
                        print("__________________________\n\n");
                        return AlldataFetch();
                      }
                    }))));
  }
}

class AlldataFetch extends StatefulWidget {
  @override
  _AlldataFetchState createState() => _AlldataFetchState();
}

class _AlldataFetchState extends State<AlldataFetch> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 100,
              dividerThickness: 5,
              dataRowHeight: 50,
              showCheckboxColumn: true,
              columns: [
                DataColumn(label: Text('Application Id')),
                DataColumn(label: Text('profileStatus')),
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Email')),
                DataColumn(label: Text('Phone')),
                DataColumn(label: Text('DOB')),
                DataColumn(label: Text('Cousre')),
                DataColumn(label: Text('Gender')),
                DataColumn(label: Text('Quota')),
                DataColumn(label: Text('House Name')),
                DataColumn(label: Text('PostOffice')),
                DataColumn(label: Text('Panchayat')),
                DataColumn(label: Text('District')),
                DataColumn(label: Text('State')),
                DataColumn(label: Text('Pincode')),
                DataColumn(label: Text('Father Name')),
                DataColumn(label: Text('Father Occupation')),
                DataColumn(label: Text('Father Phone Number')),
                DataColumn(label: Text('10th Mark')),
                DataColumn(label: Text('10th School Name')),
                DataColumn(label: Text('Annual Income')),
                DataColumn(label: Text('Nationality')),
                DataColumn(label: Text('Religion')),
                DataColumn(label: Text('Caste')),
                DataColumn(label: Text('12th Stream')),
                DataColumn(label: Text('12th Passing Year')),
                DataColumn(label: Text('12th Register Number')),
                DataColumn(label: Text('12th Instituion Name')),
                DataColumn(label: Text('12th Mark')),
                DataColumn(label: Text('12th Percentage')),
                DataColumn(label: Text('Maths Score')),
                DataColumn(label: Text('Physics Score')),
                DataColumn(label: Text('Chemistry Score')),
                DataColumn(label: Text('Entrance')),
                DataColumn(label: Text('Entrance Year')),
                DataColumn(label: Text('Entrance Rank')),
                DataColumn(label: Text('Entrance Application NUmber')),
                DataColumn(label: Text('Preference 1')),
                DataColumn(label: Text('Preference 2')),
                DataColumn(label: Text('Preference 3'))
              ],
              rows: global.listOfAllUsers
                  .map(
                    ((element) => DataRow(
                          cells: <DataCell>[
                            DataCell(Text(element["applicationId"].toString())),
                            DataCell(Text(element["profileStatus"].toString())),
                            DataCell(Text(element["name"].toString())),
                            DataCell(Text(element["email"].toString())),
                            DataCell(Text(element["phone"].toString())),
                            DataCell(Text(element["dob&pass"].toString())),
                            DataCell(Text(element["course"].toString())),
                            DataCell(Text(element["gender"].toString())),
                            DataCell(Text(element["quota"].toString())),
                            DataCell(Text(element["contactDetails"]["houseName"]
                                .toString())),
                            DataCell(Text(element["contactDetails"]
                                    ["postOffice"]
                                .toString())),
                            DataCell(Text(element["contactDetails"]["panchayat"]
                                .toString())),
                            DataCell(Text(element["contactDetails"]["district"]
                                .toString())),
                            DataCell(Text(
                                element["contactDetails"]["state"].toString())),
                            DataCell(Text(element["contactDetails"]["pinCode"]
                                .toString())),
                            DataCell(Text(element["contactDetails"]
                                    ["fatherName"]
                                .toString())),
                            DataCell(Text(element["contactDetails"]
                                    ["fatherOccupation"]
                                .toString())),
                            DataCell(Text(element["contactDetails"]
                                    ["fatherPhoneNumber"]
                                .toString())),
                            DataCell(Text(element["contactDetails"]["10thMark"]
                                .toString())),
                            DataCell(Text(element["contactDetails"]
                                    ["10thSchoolName"]
                                .toString())),
                            DataCell(Text(element["contactDetails"]
                                    ["annualIncome"]
                                .toString())),
                            DataCell(Text(element["contactDetails"]
                                    ["nationality"]
                                .toString())),
                            DataCell(Text(element["contactDetails"]["religion"]
                                .toString())),
                            DataCell(Text(
                                element["contactDetails"]["caste"].toString())),
                            DataCell(Text(element["educationDetails"]
                                    ["_12thStream"]
                                .toString())),
                            DataCell(Text(element["educationDetails"]
                                    ["_12PassingYear"]
                                .toString())),
                            DataCell(Text(element["educationDetails"]
                                    ["_12registerNumber"]
                                .toString())),
                            DataCell(Text(element["educationDetails"]
                                    ["_12institutionName"]
                                .toString())),
                            DataCell(Text(element["educationDetails"]
                                    ["_12markObtained"]
                                .toString())),
                            DataCell(Text(element["educationDetails"]
                                    ["_12percentage"]
                                .toString())),
                            DataCell(Text(element["educationDetails"]
                                    ["_mathsSubMark"]
                                .toString())),
                            DataCell(Text(element["educationDetails"]
                                    ["_physicsSubMark"]
                                .toString())),
                            DataCell(Text(element["educationDetails"]
                                    ["_chemistrySubMark"]
                                .toString())),
                            DataCell(Text(element["educationDetails"]
                                    ["_entrance"]
                                .toString())),
                            DataCell(Text(element["educationDetails"]
                                    ["_entranceYear"]
                                .toString())),
                            DataCell(Text(element["educationDetails"]
                                    ["_entranceRank"]
                                .toString())),
                            DataCell(Text(element["educationDetails"]
                                    ["_entranceApplicationNumbe"]
                                .toString())),
                            DataCell(
                                Text(element["coursePref"]["p1"].toString())),
                            DataCell(
                                Text(element["coursePref"]["p2"].toString())),
                            DataCell(
                                Text(element["coursePref"]["p3"].toString())),
                          ],
                        )),
                  )
                  .toList(),
            )));
  }
}
