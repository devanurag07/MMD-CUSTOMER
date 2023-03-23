import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mmdapp/common/widget/custom_button.dart';
import 'package:mmdapp/controller/homeController.dart';
import 'package:mmdapp/screens/booking_confirmation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mmdapp/services/auth/appointmentService.dart';
import 'package:mmdapp/utils/toast.dart';

class BookingSummary extends StatefulWidget {
  final Map timeslot;
  final Map doctorData;
  const BookingSummary(
      {super.key, required this.timeslot, required this.doctorData});

  @override
  State<BookingSummary> createState() => _BookingSummaryState();
}

class _BookingSummaryState extends State<BookingSummary> {
  FToast fToast = FToast();

  @override
  void initState() {
    super.initState();
    // if you want to use context from globally instead of content we need to pass navigatorKey.currentContext!
    fToast.init(context);
  }

  void submitHandler() {
    // print("hey");

    int doctorId = widget.doctorData['id'];
    int timeslotId = int.tryParse(widget.timeslot['id'].toString()) ?? -1;

    if (timeslotId == -1) {
      fToast.showToast(
        child: errorToast("Please Go Back and Try Again"),
        gravity: ToastGravity.BOTTOM,
        toastDuration: Duration(seconds: 2),
      );
      return;
    }

    createAppointment(doctorId, timeslotId).then((resp) {
      bool success = resp['success'];
      // Map data = resp['data'];
      print(resp);
      if (success) {
        fToast.showToast(
          child: successToast("Created Successfully"),
          gravity: ToastGravity.BOTTOM,
          toastDuration: Duration(seconds: 2),
        );

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookingConfirmation(
                bookingData: resp['data'],
              ),
            ));
      } else {
        fToast.showToast(
          child: errorToast("Something Went Wrong"),
          gravity: ToastGravity.BOTTOM,
          toastDuration: Duration(seconds: 2),
        );
      }
    });
    // fToast.showToast();
  }

  @override
  Widget build(BuildContext context) {
    final summaryController = Get.put((SummaryController()));

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
          "Booking Summary",
          style: TextStyle(color: Color.fromRGBO(19, 96, 239, 1)),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
            future: summaryController.fetchSummaryDetails('1'),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: double.infinity,
                    height: 500,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: kElevationToShadow[2],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/dummy_image.png',
                                height: 100,
                                width: 100,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.doctorData['full_name'].toString(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/doctor_speciality.svg',
                                        height: 15,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        widget.doctorData['doctor_speciality']
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color:
                                                Color.fromRGBO(19, 96, 239, 1),
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/big_star.png',
                                        height: 15,
                                        width: 15,
                                      ),
                                      Image.asset(
                                        'assets/big_star.png',
                                        height: 15,
                                        width: 15,
                                      ),
                                      Image.asset(
                                        'assets/big_star.png',
                                        height: 15,
                                        width: 15,
                                      ),
                                      Image.asset(
                                        'assets/big_star.png',
                                        height: 15,
                                        width: 15,
                                      ),
                                      Image.asset(
                                        'assets/half_star.png',
                                        height: 15,
                                        width: 15,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Text(
                                        "(35)",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset('assets/location.png'),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Text(
                                        "Durga Park , New Dehi",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Date",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                widget.timeslot['date'].toString(),
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Time",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                widget.timeslot['start_time'].toString(),
                                // 'hey',
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Consulting Fee",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                summaryController.summaryDetails.value!.fee1
                                    .toString(),
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Booking Fee",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                summaryController.summaryDetails.value!.fee2
                                    .toString(),
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "₹300",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromRGBO(19, 96, 239, 1),
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      onPressed: () {
                        submitHandler();
                      },
                      text: "Confirm & Pay")
                ],
              );
            }),
      )),
    );
  }
}
