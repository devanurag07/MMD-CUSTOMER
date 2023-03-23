import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mmdapp/services/auth/doctorService.dart';

import '../model/prescriptionModel.dart';
import '../model/profileModel.dart';

class ProfileController extends GetxController {
  var profileDetails = Rxn<Map>({});

  featchProfileDetails() {
    getProfileData().then((value) {
      if (value.containsKey('success')) {
        if (value['success']) {
          profileDetails.value = value['data'];
        }
      }
    });
  }
}
