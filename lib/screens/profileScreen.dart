import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mmdapp/controller/profileController.dart';
import 'package:mmdapp/screens/editProfileScreen.dart';
import 'package:mmdapp/screens/loginScreen.dart';
import 'package:mmdapp/services/auth/doctorService.dart';
import 'package:mmdapp/utils/storage.dart';
import 'package:mmdapp/utils/toast.dart';

import '../utils/global_variable.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = 'profile';

  // late String name;
  // late String number;
  // late String email;
  // late String gender;
  // late String dateOdBirth;
  // late String bloodGroup;
  // late String weight;

  const ProfileScreen({
    super.key,
    // required this.name,
    // required this.number,
    // required this.email,
    // required this.gender,
    // required this.dateOdBirth,
    // required this.bloodGroup,
    // required this.weight,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map profileData = {};
  FToast fToast = FToast();

  @override
  void initState() {
    super.initState();
    fToast.init(context);
    getProfileData().then((value) {
      if (value.containsKey('success')) {
        if (value['success'] == false) {
          fToast.showToast(
            child: errorToast(value['message']),
            gravity: ToastGravity.BOTTOM,
            toastDuration: const Duration(seconds: 2),
          );
        } else {
          setState(() {
            profileData = value['data'];
          });
        }
      }
    });
    // profileController.featchProfileDetails('1');
  }

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put((ProfileController()));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back,
              color: Color.fromRGBO(19, 96, 239, 1),
            )),
        title: const Text(
          "Profile",
          style: TextStyle(color: Color.fromRGBO(19, 96, 239, 1)),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
          future: profileController.featchProfileDetails(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return SafeArea(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: Image.asset("assets/dummy_image.png"),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Column(
                        children: [
                          Text(
                            (profileData.containsKey('first_name')
                                    ? profileData['first_name']
                                    : '') +
                                " " +
                                (profileData.containsKey('last_name')
                                    ? profileData['last_name']
                                    : ''),
                            style: const TextStyle(
                                color: AppColors.mainColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 15.w,
                          ),
                          Text(
                            profileData.containsKey('mobile')
                                ? '+91' + profileData['mobile'].toString()
                                : '',
                            style: const TextStyle(fontSize: 16),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Email Id",
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.darkTextColor),
                      ),
                      Text(
                        profileData.containsKey('email')
                            ? profileData['email']
                            : '',
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  const Divider(
                    thickness: 1,
                    height: 2,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Gender",
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.darkTextColor),
                      ),
                      Text(
                        profileData.containsKey('gender')
                            ? profileData['gender']
                            : "",
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  const Divider(
                    thickness: 1,
                    height: 2,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Date Of Birth",
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.darkTextColor),
                      ),
                      Text(
                        profileData.containsKey('date_of_birth')
                            ? profileData['date_of_birth'] ?? "[DOB]"
                            : "",
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  const Divider(
                    thickness: 1,
                    height: 2,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Blood Group",
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.darkTextColor),
                      ),
                      Text(
                        profileData.containsKey('blood_group')
                            ? profileData['blood_group']
                            : "",
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  const Divider(
                    thickness: 1,
                    height: 2,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Weight",
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.darkTextColor),
                      ),
                      Text(
                        profileData.containsKey('weight')
                            ? profileData['weight'].toString() ?? '[Weight]'
                            : "",
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  const Divider(
                    thickness: 1,
                    height: 2,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 25, 66, 247),
                        ),
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                        onPressed: () => {Get.to(EditProfile())},
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      print('object');
                      LocalStorage().clearAuthTokens();
                      Get.to(LoginScreen());
                    },
                    child: Row(children: [
                      SvgPicture.asset("assets/icons/logout.svg"),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        "LogOut",
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      )
                    ]),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                ],
              ),
            ));
          }),
    );
  }
}
