// import 'dart:convert' show json;
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:get/get.dart';
// import 'package:mmdapp_doctor/utils/pdf/pdfModel.dart';
// // import 'package:your_project_name/models/user.dart';

// class PdfController extends GetxController {
//    late PdfModel pdf;

//   @override
//   void onInit() {
//     super.onInit();
//     loadUser();
//   }

//   Future<void> loadUser() async {
//     final String jsonString = await rootBundle.loadString('assets/pdf.json');
//     final Map<String, dynamic> jsonData = json.decode(jsonString);
//     pdf = PdfModel(
//      name : jsonData['name'],
//     );
//     update(); // this updates the GetX controller's state
//   }
// }

import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

var featchedpdf = [
  {
    "id": 5,
    "customer": "5",
    "customer_name": "Aditya Paswan",
    "clinic_name": "My clinic",
    "queue": 8,
    "mobile": 8765467890,
    "created_by": 4,
    "created_at": "2023-03-08T01:30:4",
    "prescription_list": [
      {
        "id": 24,
        "name": "asdf",
        "drug_to_taken": 1,
        "note": "asdf",
        "deleted": false,
        "created_by": 4,
        "created_at": "2023-03-08T01:30:46.306241Z"
      }
    ],
    "doctor_name": "Aditya"
  },
  {
    "id": 5,
    "customer": "5",
    "customer_name": "Aditya Paswan",
    "clinic_name": "My clinic",
    "queue": 8,
    "mobile": 8765467890,
    "created_by": 4,
    "created_at": "2023-03-08T01:30:4",
    "prescription_list": [
      {
        "id": 24,
        "name": "asdf",
        "drug_to_taken": 1,
        "note": "asdf",
        "deleted": false,
        "created_by": 4,
        "created_at": "2023-03-08T01:30:46.306241Z"
      }
    ],
    "doctor_name": "Aditya"
  },
  {
    "id": 5,
    "customer": "5",
    "customer_name": "Aditya Paswan",
    "clinic_name": "My clinic",
    "queue": 8,
    "mobile": 8765467890,
    "created_by": 4,
    "created_at": "2023-03-08T01:30:4",
    "prescription_list": [
      {
        "id": 24,
        "name": "asdf",
        "drug_to_taken": 1,
        "note": "asdf",
        "deleted": false,
        "created_by": 4,
        "created_at": "2023-03-08T01:30:46.306241Z"
      }
    ],
    "doctor_name": "Aditya"
  }
];

class PdfController extends GetxController {
  var pdf = [].obs;
  getPdf() async {
    pdf.value = featchedpdf;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {}
}
