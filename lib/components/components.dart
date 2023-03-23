import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../utils/global_variable.dart';

class UpcomingComponent extends StatelessWidget {
  final String date;
  final String category;
  final String name;
  final String time;

  const UpcomingComponent({
    super.key,
    this.time = '',
    required this.date,
    required this.category,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              date,
              style: TextStyle(color: AppColors.darkTextColor, fontSize: 14.sp),
            ),
            Text(
              time,
              style: TextStyle(color: AppColors.darkTextColor, fontSize: 14.sp),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          "${category} - ${name}",
          style: TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 10.h,
        ),
        Divider(
          thickness: 1,
          height: 2.h,
        )
      ],
    );
  }
}

class PastBooking extends StatelessWidget {
  final String invoice;
  final String category;
  final String name;
  final String amount;
  const PastBooking(
      {super.key,
      required this.invoice,
      required this.category,
      required this.name,
      required this.amount});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Invoice No: #${invoice}",
              style: TextStyle(color: AppColors.darkTextColor, fontSize: 14.sp),
            ),
            Text(
              amount,
              style: TextStyle(color: AppColors.darkTextColor, fontSize: 14.sp),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${category} - ${name}",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600),
            ),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/download.svg",
                  color: AppColors.iconDarkColor,
                ),
                SizedBox(
                  width: 7.w,
                ),
                Text(
                  "Invoice",
                  style: TextStyle(
                      color: AppColors.iconDarkColor,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500),
                )
              ],
            )
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Divider(
          thickness: 1,
          height: 2.h,
        )
      ],
    );
  }
}

class Prescription extends StatelessWidget {
  // final String prescription;
  final String category;
  final String name;
  final String date;
  const Prescription(
      {super.key,
      // required this.prescription,
      required this.category,
      required this.name,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Prescription No 1",
              style: TextStyle(color: AppColors.darkTextColor, fontSize: 14.sp),
            ),
            Text(
              date,
              style: TextStyle(color: AppColors.darkTextColor, fontSize: 14.sp),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${category} - ${name}",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600),
            ),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/download.svg",
                  color: AppColors.iconDarkColor,
                ),
                SizedBox(
                  width: 7.w,
                ),
                Text(
                  "Download",
                  style: TextStyle(
                      color: AppColors.iconDarkColor,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500),
                )
              ],
            )
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Divider(
          thickness: 1,
          height: 2.h,
        )
      ],
    );
  }
}
