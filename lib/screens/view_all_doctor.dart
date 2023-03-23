import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmdapp/screens/doctor_profile.dart';

import '../components/doctor_component.dart';
import '../controller/homeController.dart';

class ViewAllDoctor extends StatelessWidget {
  const ViewAllDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    final doctorController = Get.put((DoctorController()));

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Color.fromRGBO(19, 96, 239, 1),
            )),
        title: const Text(
          "All Doctors",
          style: TextStyle(color: Color.fromRGBO(19, 96, 239, 1)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: doctorController.fetchDoctorsDetails(''),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    return ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      itemCount:
                          (doctorController.doctorDetails.value?.length) ?? 0,
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
                          url: doctorController.doctorDetails.value?[index].url,
                          ranking: doctorController
                              .doctorDetails.value?[index].ranking,
                          time: doctorController
                              .doctorDetails.value?[index].clinicStartTime,
                          Category: doctorController
                              .doctorDetails.value?[index].doctorSpeciality,
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
