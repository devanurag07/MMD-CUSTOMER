import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:mmdapp/model/homeModel.dart';
import 'package:mmdapp/services/auth/doctorService.dart';

class DoctorController extends GetxController {
  var doctorDetails = Rxn<List<DoctorModel2>>();

  fetchDoctorsDetails(String doctorTag) async {
    var doctors = await getDoctors(doctorTag);
    List<DoctorModel2> doctorsList = [];

    for (int i = 0; i < doctors.length; i++) {
      DoctorModel2 doctorData = DoctorModel2.fromJson(doctors[i]);
      doctorsList.add(doctorData);
    }
    doctorDetails.value = doctorsList;
  }
}

class CategoryController extends GetxController {
  var categoryDetails = Rxn<CategoryModel>();

  fetchCategoryDetails(String id) {
    categoryDetails.value = CategoryModel(title: [
      "General Physicians",
      "Cardio Surgeons",
      "Eye Specialist"
    ], url: [
      "assets/icons/noun-stethoscope-50094.svg",
      "assets/icons/heart.svg",
      "assets/icons/eye.svg"
    ], color: [
      Color.fromRGBO(19, 96, 239, 1),
      Colors.yellow,
      Colors.red
    ], category: [
      "general_physicians",
      "cardio_surgeons",
      "eye_specialist"
    ]);
  }
}

class SummaryController extends GetxController {
  var summaryDetails = Rxn<SummaryModel>();
  DateTime now = DateTime.now();
  fetchSummaryDetails(String id) {
    summaryDetails.value = SummaryModel(
      date: DateFormat('dd MMM yyyy').format(now),
      time: DateFormat("hh:mm").format(now),
      fee1: '250',
      fee2: "50",
    );
  }
}
