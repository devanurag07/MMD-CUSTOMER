import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mmdapp/common/widget/custom_button.dart';
import 'package:mmdapp/components/calender.dart';
import 'package:mmdapp/screens/booking_summary.dart';
import 'package:mmdapp/services/auth/appointmentService.dart';

class TimeSlot extends StatefulWidget {
  final Map doctorData;
  const TimeSlot({super.key, required this.doctorData});

  @override
  State<TimeSlot> createState() => _TimeSlotState();
}

class _TimeSlotState extends State<TimeSlot> {
  var datesList = [];
  var selectedDate = "";
  var dateTimeslots = [];
  num selectedTimeslot = -1;
  Map selectedTimeslotData = {};

  @override
  void initState() {
    super.initState();
    print("Sent");

    getTimeslots(widget.doctorData['id']).then((value) {
      bool success = value['success'];
      print("Sent");
      if (success) {
        print(value);
        print('dates');
        print(value['dates']);
        // datesList = value['dates'];
        datesList = value['dates'];
        setState(() {
          // datesList.addAll(value['dates']);
        });
      }
    });
  }

  void fetchTimeSlots(String date) {
    int doctorId = widget.doctorData['id'];
    getDateTimeslots(doctorId, date).then((value) {
      bool success = value['success'];
      if (success) {
        // datesList = value['dates'];
        dateTimeslots = value['timeslots'];
        selectedDate = date;
        setState(() {
          // datesList.addAll(value['dates']);
        });
      }
    });
  }

  void setTimeslot(num timeslot_id) {
    selectedTimeslot = timeslot_id;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
          "Select a Time Slot",
          style: TextStyle(color: Color.fromRGBO(19, 96, 239, 1)),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: (!datesList.isEmpty)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 75,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: kElevationToShadow[2],
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                AssetImage('assets/dummy_image.png'),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.doctorData['full_name'].toString(),
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                      "assets/doctor_speciality.svg",
                                      width: 12,
                                      color: Colors.grey),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    widget.doctorData['doctor_speciality']
                                        .toString(),
                                    style: const TextStyle(
                                        color: Color.fromRGBO(19, 96, 239, 1),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Januray",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "February",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "March",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 15,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: datesList.length,
                      itemBuilder: (BuildContext context, index) =>
                          GestureDetector(
                        child: Calender(
                            activate:
                                datesList[index][0].toString() == selectedDate,
                            date: datesList[index][0].toString().split("-")[2],
                            day: datesList[index][1]),
                        onTap: () => fetchTimeSlots(datesList[index][0]),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Available Slots",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GridView.builder(
                    itemCount: dateTimeslots.length,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 20,
                            mainAxisExtent: 40,
                            mainAxisSpacing: 20),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        child: Container(
                          width: 100,
                          height: 20,
                          decoration: BoxDecoration(
                            color: (dateTimeslots[index]['id'].toString() ==
                                    selectedTimeslot.toString())
                                ? const Color.fromRGBO(19, 96, 239, 1)
                                : Colors.white,
                            border: Border.all(
                                color: const Color.fromRGBO(19, 96, 239, 1),
                                width: 1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                                dateTimeslots[index]['start_time']
                                    .toString()
                                    .split(':')
                                    .sublist(0, 2)
                                    .join(":"),
                                style: TextStyle(
                                  color: (dateTimeslots[index]['id']
                                              .toString() ==
                                          selectedTimeslot.toString())
                                      ? Colors.white
                                      : const Color.fromRGBO(19, 96, 239, 1),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                )),
                          ),
                        ),
                        onTap: () {
                          int timeslot_id = int.tryParse(
                                  dateTimeslots[index]['id'].toString()) ??
                              -1;

                          // print(dateTimeslots[index]['id']);
                          if (timeslot_id == -1) {
                            return;
                          }

                          setTimeslot(timeslot_id);
                          selectedTimeslotData = dateTimeslots[index];
                          setState(() {});
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 150,
                  ),
                  CustomButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingSummary(
                                doctorData: widget.doctorData,
                                timeslot: selectedTimeslotData,
                              ),
                            ));
                      },
                      text: 'Proceed')
                ],
              )
            : Center(
                child: Text(
                  'Doctor Not Available'.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ),
              ),
      ),
    );
  }
}
