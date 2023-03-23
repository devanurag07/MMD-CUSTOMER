import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mmdapp/common/widget/custom_button.dart';
import 'package:mmdapp/screens/time_slot.dart';
import 'package:mmdapp/services/auth/doctorService.dart';

import '../utils/global_variable.dart';

class DoctorProfile extends StatefulWidget {
  final num doctor_id;
  DoctorProfile({super.key, required this.doctor_id});

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  Map<String, dynamic> doctorData = {
    'full_name': '',
    'doctor_speciality': '',
    'ranking': '5',
  };

  @override
  void initState() {
    super.initState();
    getDoctor(widget.doctor_id).then((value) {
      print("Response");
      print(value);
      if (value.containsKey("data")) {
        Map data = value['data'];
        doctorData["full_name"] = data['full_name'];
        doctorData['doctor_speciality'] = data['doctor_speciality'];
        doctorData['id'] = data['id'].toString();
        setState(() {});
      }
      print(value);
    }).catchError(() => {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity.w,
            height: 250.h,
            //svg as background
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: Image.asset('assets/doctors-team.png').image,
                  fit: BoxFit.cover,
                ),
                color: Color.fromRGBO(19, 96, 239, 1)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Positioned(
                      top: 30,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back)),
                    ),
                    SizedBox(
                        height: 200.h,
                        child:
                            SvgPicture.asset("assets/icons/doctors_team.svg")),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 210),
            // top: 100,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.r),
                      topRight: Radius.circular(50.r))),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(19, 96, 239, 1),
                              image: DecorationImage(
                                image: Image.asset('assets/doctors-team.png')
                                    .image,
                                fit: BoxFit.cover,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: SvgPicture.asset(
                              "assets/icons/Dr. Arun Srinivas.svg"),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              doctorData['full_name']!,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.lightTextColor),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset("assets/doctor_speciality.svg",
                                    width: 12, color: Colors.grey),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  doctorData['doctor_speciality'] ?? '',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Color.fromRGBO(19, 96, 239, 1),
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                Text(
                                  // doctorData['clinicName']!,
                                  '- Clinic Name',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.lightTextColor),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  "assets/big_star.png",
                                  height: 20.h,
                                  width: 20.w,
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                Image.asset(
                                  "assets/big_star.png",
                                  height: 20.h,
                                  width: 20.w,
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                Image.asset(
                                  "assets/big_star.png",
                                  height: 20.h,
                                  width: 20.w,
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                Image.asset(
                                  "assets/big_star.png",
                                  height: 20.h,
                                  width: 20.w,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Image.asset(
                                  "assets/half_star.png",
                                  height: 20.h,
                                  width: 20.w,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "4.5",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                      width: double.infinity.w,
                      child: Text(
                        "Dr. Arun Srinivas is a Dentist in Kukatpally, Hyderabad and has an experience of 10 years in this field. Dr. Arun Srinivas practices at ASV Healthcare in Kukatpally, Hyderabad. He completed BDS from Dr. NTR University of Health Sciences Andhra Pradesh in 2010. He is a member of Indian Dental Association. Some of the services provided by the doctor are: Dental Implant Fixing,Impaction / Impacted Tooth Extraction,Complete/Partial Dentures Fixing,Scaling / Polishing and Cosmetic/ Aesthetic Dentistry etc.",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.lightTextColor),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    // Container(
                    //   width: double.infinity.w,
                    //   height: 70.h,
                    //   decoration: BoxDecoration(
                    //       color: AppColors.consultationColor,
                    //       borderRadius:
                    //           BorderRadius.all(Radius.circular(10.r))),
                    //   child: Row(
                    //     children: [
                    //       SizedBox(
                    //         width: 10.w,
                    //       ),
                    //       Container(
                    //         width: 50.w,
                    //         height: 50.h,
                    //         decoration: BoxDecoration(
                    //             color: AppColors.consultationColor2,
                    //             borderRadius:
                    //                 BorderRadius.all(Radius.circular(10))),
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.center,
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: [Text("11"), Text("jan")],
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         width: 15.w,
                    //       ),
                    //       Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Text(
                    //             "Consulatation",
                    //             style: TextStyle(
                    //                 fontSize: 17.sp,
                    //                 fontWeight: FontWeight.w500),
                    //           ),
                    //           SizedBox(
                    //             height: 7.h,
                    //           ),
                    //           Row(
                    //             children: [
                    //               Text("Tuesday"),
                    //               SizedBox(
                    //                 width: 7.h,
                    //               ),
                    //               Text("9:00AM"),
                    //               SizedBox(
                    //                 width: 7.h,
                    //               ),
                    //               Text("7:00PM"),
                    //             ],
                    //           )
                    //         ],
                    //       )
                    //     ],
                    //   ),
                    // ),

                    SizedBox(
                      height: 20.h,
                    ),
                    (doctorData.containsKey('id')
                        ? CustomButton(
                            onPressed: () {
                              doctorData['id'] =
                                  int.tryParse(doctorData['id'].toString()) ??
                                      -1;
                              if (doctorData['id'] == -1) {
                                return;
                              }
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        TimeSlot(doctorData: doctorData),
                                  ));
                            },
                            text: 'Book Appointment')
                        : SizedBox(height: 0))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
