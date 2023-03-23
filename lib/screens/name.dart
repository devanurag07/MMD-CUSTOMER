import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mmdapp/common/widget/custom_textfield.dart';

import '../utils/global_variable.dart';
import '../controller/authController.dart';

class NamePage extends StatelessWidget {
  const NamePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put((AuthController()));

    return Scaffold(
      backgroundColor: Color.fromARGB(246, 240, 240, 240),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your Name",
                style: TextStyle(
                    color: AppColors.mainColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomTextField(
                  controller: authController.nameController,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Enter your Full Name.';
                    }
                    return null;
                  },
                  hintText: 'Enter Full Name',
                  keyboardType: TextInputType.name),
            ],
          ),
        ),
      ),
    );
  }
}
