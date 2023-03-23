import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mmdapp/screens/homePage.dart';
import 'package:mmdapp/screens/otp.dart';
import 'package:mmdapp/services/auth/authService.dart';
import 'package:mmdapp/utils/api_utils.dart';
import 'package:mmdapp/utils/storage.dart';
import 'package:mmdapp/utils/toast.dart';
import 'package:open_file/open_file.dart';

import '../common/widget/custom_button.dart';
import '../utils/global_variable.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginController = TextEditingController();
  FToast fToast = FToast();

  @override
  void initState() {
    super.initState();
    fToast.init(context);
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    bool authenticated = await isUserAuthenticated();
    if (authenticated) {
      Navigator.pushReplacementNamed(context, '/landing/${HomePage.routeName}');
    }
  }

  void submitHandler(context) async {
    var number = int.tryParse(loginController.value.text) ?? 0;

    Map resp = await loginSendOtp(number);
    if (resp['success'] == false) {
      // show toast error
    } else {
      if (resp.containsKey('message')) {
        fToast.showToast(child: successToast(resp['message']));
      }

      var number = int.tryParse(loginController.value.text) ?? 0;
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Otp(mobile: number)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 235, 235),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40.h,
                      ),
                      Text(
                        "Enter Your Mobile Number",
                        style: TextStyle(
                            fontSize: 20.sp, color: AppColors.mainColor),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10.r)),
                        ),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 7.w,
                              ),
                              Text(
                                "+91",
                                style: TextStyle(fontSize: 20.sp),
                              ),
                              SizedBox(
                                width: 7.w,
                              ),
                              Image.asset("assets/dropdown.png"),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  controller: loginController,
                                  onChanged: ((value) =>
                                      {print(loginController.value.text)}),
                                  decoration: const InputDecoration(
                                    hintText: "Moblie Number",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ]),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Text(
                        "By continuing , you agree to our",
                        style:
                            TextStyle(color: Colors.black54, fontSize: 15.sp),
                      ),
                      GestureDetector(
                        onTap: () async =>
                            await OpenFile.open("assets/terms.docx"),
                        child: Text(
                          "Terms & Conditions",
                          style: TextStyle(
                              color: Color.fromARGB(255, 1, 95, 173),
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const Spacer(),
                      const Spacer(),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Spacer(),
                      CustomButton(
                        onPressed: () async => submitHandler(context),
                        text: "Continue",
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
