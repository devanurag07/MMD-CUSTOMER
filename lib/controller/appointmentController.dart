import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mmdapp/model/appointmentModel.dart';
import 'package:mmdapp/services/auth/appointmentService.dart';

class AppointmentController extends GetxController {
  var todayAppointments = Rxn<List<AppointmentModel>>();
  var pastAppointments = Rxn<List<AppointmentModel>>();
  var upcomingAppointments = Rxn<List<AppointmentModel>>();

  fetchAppointmentDetails() async {
    Map<dynamic, dynamic> data = await getAppointments();
    print("fetching");

    var today_data = data['today_appointments'];
    var past_data = data['past_appointments'];
    var upcoming_data = data['upcoming_appointments'];
    List<AppointmentModel> todayData = [];
    List<AppointmentModel> pastData = [];
    List<AppointmentModel> upcomingData = [];

    for (int i = 0; i < today_data.length; i++) {
      AppointmentModel doctorData = AppointmentModel.fromJson(today_data[i]);
      todayData.add(doctorData);
    }

    for (int i = 0; i < past_data.length; i++) {
      AppointmentModel doctorData = AppointmentModel.fromJson(past_data[i]);
      pastData.add(doctorData);
    }

    for (int i = 0; i < upcoming_data.length; i++) {
      AppointmentModel doctorData = AppointmentModel.fromJson(upcoming_data[i]);
      upcomingData.add(doctorData);
    }

    todayAppointments.value = todayData;
    pastAppointments.value = pastData;
    upcomingAppointments.value = upcomingData;
  }
}
