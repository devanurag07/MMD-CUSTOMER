import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/prescriptionModel.dart';

class PrescriptionController extends GetxController {
  var prescriptionDetails = Rxn<PrescriptionModel>();
}
