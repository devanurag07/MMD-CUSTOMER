import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class AuthController extends GetxController {
  var phoneController = TextEditingController();
  var nameController = TextEditingController();

  var otpController = TextEditingController();
  final otpBoxControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  var enteredOtp = ''.obs;
  var showOtp = false.obs;
  var otp = ''.obs;

  onGetLoginOtp(formkey) async {
    if (formkey != null) {
      final isValid = formkey.currentState!.validate();
      if (!isValid) {
        return;
      }
    }

    // final isNoError =
    //     await AuthServices().featchLoginOtp(phoneController.text, otp);
    // showOtp.value = isNoError;
  }

  onGetSignUpOtp(formkey) async {
    if (formkey != null) {
      final isValid = formkey.currentState!.validate();
      if (!isValid) {
        return;
      }
    }

    // final isNoError = await AuthServices().featchSignUpOtp(phoneController.text,
    //     firstNameController.text, lastNameController.text, otp);
    // showOtp.value = isNoError;
  }

  onVerifyOtp(formkey, context) async {
    final isValid = formkey.currentState!.validate();
    if (!isValid) {
      return;
    }

    // final isNoError =
    //     await AuthServices().verifyOtp(phoneController.text, enteredOtp.value);

    // for (TextEditingController otpController in otpBoxControllers) {
    //   otpController.text = '';
    // }
    // enteredOtp.value = '';
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {}
}
