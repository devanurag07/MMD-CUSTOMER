import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mmdapp/components/category_component.dart';
import 'package:mmdapp/controller/homeController.dart';
import 'package:mmdapp/controller/profileController.dart';
import 'package:mmdapp/screens/doctor_profile.dart';
import 'package:mmdapp/screens/view_all_doctor.dart';

import '../components/doctor_component.dart';
import '../utils/global_variable.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final doctorController = Get.put((DoctorController()));
  final categoryController = Get.put((CategoryController()));
  final profileController = Get.put((ProfileController()));

  String category = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              future: profileController.featchProfileDetails(),
              builder: (context, snapshot) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          profileController
                                  .profileDetails.value!['first_name'] ??
                              'No Name',
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        const Text(
                          " " + '',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textColor),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Image.asset("assets/dropdown_blue.png")
                      ],
                    ),
                    SvgPicture.asset("assets/icons/notification.svg")
                  ],
                );
              },
            ),
            // search
            SizedBox(height: 20.h),
            const CupertinoSearchTextField(),

            // Top Doctors

            SizedBox(
              height: 20.h,
            ),

            const Text(
              "Categories",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.lightTextColor),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: 150.h,
              child: FutureBuilder(
                  future: categoryController.fetchCategoryDetails('1'),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => SizedBox(
                        width: 25.w,
                      ),
                      itemCount: 3,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            category = categoryController
                                .categoryDetails.value!.category[index];
                          });
                        },
                        child: CategoryComponent(
                          selected: category ==
                              categoryController
                                  .categoryDetails.value!.category[index],
                          title: categoryController
                              .categoryDetails.value!.title[index],
                          url: categoryController
                              .categoryDetails.value!.url[index],
                          color: categoryController
                              .categoryDetails.value!.color[index],
                        ),
                      ),
                    );
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Top Doctors",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.lightTextColor),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ViewAllDoctor(),
                        ));
                  },
                  child: Text(
                    "View All",
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(19, 96, 239, 1)),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),

            Expanded(
              child: FutureBuilder(
                  future: doctorController.fetchDoctorsDetails(category),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return ListView.separated(
                          separatorBuilder: (context, index) => SizedBox(
                            height: 10.h,
                          ),
                          itemCount: (doctorController.doctorDetails.value) ==
                                  null
                              ? 0
                              : doctorController.doctorDetails.value!.length,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DoctorProfile(
                                            doctor_id: doctorController
                                                .doctorDetails.value![index].id,
                                          )));
                            },
                            child: DoctorComponent(
                              name: doctorController
                                  .doctorDetails.value?[index].fullName,
                              url: doctorController
                                  .doctorDetails.value?[index].url,
                              ranking: doctorController
                                  .doctorDetails.value?[index].ranking,
                              time: doctorController
                                  .doctorDetails.value?[index].clinicStartTime,
                              Category: doctorController
                                  .doctorDetails.value?[index].doctorSpeciality,
                            ),
                          ),
                        );
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
          ],
        ),
      )),
    );
  }
}
