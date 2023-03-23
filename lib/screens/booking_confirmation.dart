import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mmdapp/common/widget/custom_button.dart';
//import get
import 'package:get/get.dart';
import 'package:mmdapp/landing.dart';
import 'package:mmdapp/screens/appoinmentsScreen.dart';

class BookingConfirmation extends StatelessWidget {
  final Map bookingData;
  const BookingConfirmation({super.key, required this.bookingData});

  @override
  Widget build(BuildContext context) {
    print("Booking Success");
    String doctorName = bookingData['doctor_name'].toString();
    String appointmentDate = bookingData['appointmentDate'].toString();
    String startTime = bookingData['start_time'].toString();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Color.fromRGBO(19, 96, 239, 1),
            )),
        title: const Text(
          "Booking Confirmation",
          style: TextStyle(color: Color.fromRGBO(19, 96, 239, 1)),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            SvgPicture.asset(
              "assets/icons/successfull.svg",
              height: 200.h,
              width: 200.w,
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              width: 200.w,
              child: Text(
                "Appointment booked Successfully!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.sp),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            SizedBox(
              width: 150.w,
              child: Text(
                "Appointment booked with ${doctorName} on ${appointmentDate}@${startTime}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.sp),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            CustomButton(
                onPressed: () {
                  Get.to(const LandingScreen(
                    subRoute: AppointmentsScreen.routeName,
                  ));
                },
                text: 'View My Appointments')
          ],
        ),
      )),
    );
  }
}
