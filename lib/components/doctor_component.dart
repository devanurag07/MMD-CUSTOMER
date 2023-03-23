import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/global_variable.dart';

class DoctorComponent extends StatelessWidget {
  final url;
  final ranking;
  final time;
  final Category;
  final name;
  const DoctorComponent(
      {super.key, this.url, this.ranking, this.time, this.Category, this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity.w,
      height: 75.h,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: kElevationToShadow[2],
          borderRadius: BorderRadius.all(Radius.circular(10.r))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SvgPicture.asset(url.toString()),
                CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('assets/dummy_image.png'),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name.toString(),
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.lightTextColor),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset("assets/doctor_speciality.svg",
                            width: 12, color: Colors.grey),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          Category.toString(),
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(19, 96, 239, 1)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset("assets/icons/clock.svg"),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          time.toString(),
                          style: TextStyle(
                              fontSize: 10.sp, fontWeight: FontWeight.w500),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/star.svg",
                  width: 14,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  ranking.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.grey),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
