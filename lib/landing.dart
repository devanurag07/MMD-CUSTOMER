import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:mmdapp/screens/appoinmentsScreen.dart';
import 'package:mmdapp/screens/editProfileScreen.dart';
import 'package:mmdapp/screens/homePage.dart';
import 'package:mmdapp/screens/prescriptionsScreen.dart';
import 'package:mmdapp/screens/profileScreen.dart';
import 'package:get/get.dart';

class LandingScreen extends StatefulWidget {
  final String subRoute;
  static const String routeName = '/landing/';
  const LandingScreen({super.key, required this.subRoute});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  // final authController = Get.put((AuthController()));
  // final prevRoute = Get.previousRoute;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        if (widget.subRoute == HomePage.routeName) {
          return const HomePage();
        } else if (widget.subRoute == AppointmentsScreen.routeName) {
          return const AppointmentsScreen();
        } else if (widget.subRoute == PrescriptionScreen.routeName) {
          return const PrescriptionScreen();
        } else if (widget.subRoute == ProfileScreen.routeName) {
          return const ProfileScreen();
        } else {
          return const Center(child: Text('No page found!'));
        }
      }),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 221, 221, 221),
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: SvgPicture.asset(
                      "assets/icons/home.svg",
                    ),
                    onPressed: () {
                      //using material page route to navigate landing screen
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const LandingScreen(
                              subRoute: HomePage.routeName)));
                    },
                  ),
                  Text(
                    "Home",
                    style: TextStyle(fontSize: 12.sp),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      icon: SvgPicture.asset(
                        "assets/icons/appointment.svg",
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const LandingScreen(
                                subRoute: AppointmentsScreen.routeName)));
                      }),
                  Text(
                    "Appointment",
                    style: TextStyle(fontSize: 12.sp),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      icon: SvgPicture.asset(
                        "assets/icons/prescription.svg",
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const LandingScreen(
                                subRoute: PrescriptionScreen.routeName)));
                      }),
                  Text(
                    "Prescriptions",
                    style: TextStyle(fontSize: 12.sp),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      icon: SvgPicture.asset(
                        "assets/icons/profile.svg",
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const LandingScreen(
                                subRoute: ProfileScreen.routeName)));
                      }),
                  Text(
                    "Profile",
                    style: TextStyle(fontSize: 12.sp),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
