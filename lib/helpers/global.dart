library my_prj.globals;

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

var currentUserId = "aaaa";

var fromFirestoreDB;

List<Map<String, dynamic>> listOfAllUsers = [];
Map<String, dynamic> dataPreview ;



void fetchingData() async {
  print("feching data from firestore in global class");
  fromFirestoreDB = await Firestore.instance
      .collection("Students")
      .document(currentUserId)
      .get();
}

