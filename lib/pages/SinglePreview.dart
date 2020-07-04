import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:registration/helpers/global.dart' as global;


class SinglePreview extends StatefulWidget {
  @override
  _SinglePreviewState createState() => _SinglePreviewState();
}

class _SinglePreviewState extends State<SinglePreview> {

  


textFormViewer( String _hintText,String _hintContent) =>
      Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.lightGreen[100],
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text("\t"+_hintText,
            style: GoogleFonts.lato(
                    fontWeight: FontWeight.w600, color: Colors.black54)
            ),

             
           TextFormField(
            readOnly: true,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.transparent, width: 1.5),
                ),
                contentPadding: EdgeInsets.all(14.0),
                hintText: _hintContent,
                fillColor: Colors.white54 ),
          )
          ],)
         
          );
var contact, education,course;
void initState() {
    if(global.currentUserId != null && global.dataPreview != null){
     contact =  global.dataPreview['contactDetails'];
     education =  global.dataPreview['educationDetails'];
     course =  global.dataPreview['coursePref'];
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: context.isMobile?
        EdgeInsets.all(20):EdgeInsets.all(50),
        child:Column(children: [
          const SizedBox(height: 30.0),
          textFormViewer( "Application Id",global.dataPreview['applicationId'].toString()),
          const SizedBox(height: 20.0),
          textFormViewer( "Name",global.dataPreview['name'].toString()),
          const SizedBox(height: 20.0),
          textFormViewer( "Email",global.dataPreview['email'].toString()),
          const SizedBox(height: 20.0),
          textFormViewer( "Phone",global.dataPreview['phone'].toString()),
          const SizedBox(height: 20.0),
          textFormViewer( "Date Of Birth",global.dataPreview['dob&pass'].toString()),
          const SizedBox(height: 20.0),
          textFormViewer( "Gender",global.dataPreview['gender'].toString()),
          const SizedBox(height: 20.0),
          textFormViewer( "Course",global.dataPreview['course'].toString()),
          const SizedBox(height: 20.0),
          textFormViewer( "Quota",global.dataPreview['quota'].toString()),
          const SizedBox(height: 20.0),

          textFormViewer( "House Name",contact["houseName"].toString()),
          const SizedBox(height: 20.0),
          textFormViewer( "Post Office ",contact["postOffice"].toString()),
          const SizedBox(height: 20.0),
          textFormViewer( "Panchayat",contact["panchayat"].toString()),
          const SizedBox(height: 20.0),
          textFormViewer( "District",contact["district"].toString()),
          const SizedBox(height: 20.0),
          textFormViewer( "State",contact["state"].toString()),
          const SizedBox(height: 20.0),
          textFormViewer( "Pincode",contact["pinCode"].toString()),
          const SizedBox(height: 20.0),
          textFormViewer( "Father Name",contact["fatherName"].toString()),
          const SizedBox(height: 20.0),
          textFormViewer( "Father Occupation",contact["fatherOccupation"].toString()),
          const SizedBox(height: 20.0),
          textFormViewer( "Father PhoneNumber",contact["fatherPhoneNumber"].toString()),
          const SizedBox(height: 20.0),
          textFormViewer( "10th Mark",contact["10thMark"].toString()),
          const SizedBox(height: 20.0),
          textFormViewer( "10th School Name",contact["10thSchoolName"].toString()),
          const SizedBox(height: 20.0),
          textFormViewer( "Annual Income",contact["annualIncome"].toString()),
          const SizedBox(height: 20.0),
          textFormViewer( "Nationality",contact["nationality"].toString()),
          const SizedBox(height: 20.0),
          textFormViewer( "Religion",contact["religion"].toString()),
          const SizedBox(height: 20.0),
          textFormViewer( "Caste",contact["caste"].toString()),
          const SizedBox(height: 50.0),

          textFormViewer( "12th Stream",education["_12thStream"].toString()),
          const SizedBox(height: 20.0),
          textFormViewer( "12th Passig Year",education["_12PassingYear"].toString()),
          const SizedBox(height: 20.0),
          textFormViewer( "12th Register Number",education["_12registerNumber"].toString()),
          const SizedBox(height: 20.0),
          textFormViewer( "12th Institution Name",education["_12institutionName"].toString()),
          const SizedBox(height: 20.0),
          textFormViewer( "12th Score",education["_12markObtained"].toString()),
          const SizedBox(height: 20.0),
          textFormViewer( "12th Percentage",education["_12percentage"].toString()),
          const SizedBox(height: 20.0),
          textFormViewer( "Maths Score",education["_mathsSubMark"].toString()),
          const SizedBox(height: 20.0),
          textFormViewer( "Physics Score",education["_physicsSubMark"].toString()),
          const SizedBox(height: 20.0),
          textFormViewer( "Chemistry Score",education["_chemistrySubMark"].toString()),
          const SizedBox(height: 20.0),
          textFormViewer( "Entrance",education["_entrance"].toString()),
          const SizedBox(height: 20.0),
          textFormViewer( "Entrance Year",education["_entranceYear"].toString()),
          const SizedBox(height: 20.0),
          textFormViewer( "Entrance Rank",education["_entranceRank"].toString()),
          const SizedBox(height: 20.0),
          textFormViewer( "Entrance Application Number",education["_entranceApplicationNumbe"].toString()),
          const SizedBox(height: 50.0),

          textFormViewer( "Preference 1",course["p1"].toString()),
          const SizedBox(height: 20.0),
          textFormViewer( "Preference 2",course["p2"].toString()),
          const SizedBox(height: 20.0),
          textFormViewer( "Preference 3",course["p3"].toString()),
          const SizedBox(height: 50.0),

          
          
          


          

        ],)
      )
    );
  }
}



