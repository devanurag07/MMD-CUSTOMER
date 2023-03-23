import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mmdapp/controller/appointmentController.dart';
import 'package:mmdapp/components/appointmentComponents.dart';
import 'package:mmdapp/utils/global_variable.dart';
import 'package:mmdapp/utils/pdf/utils.dart';
// import 'package:mmdapp_customer/components/appointmentsComponents.dart';
// import 'package:mmdapp_doctor/controllers/appoinmentsController.dart';

class AppointmentsScreen extends StatefulWidget {
  static const String routeName = 'appoinments';
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen>
    with SingleTickerProviderStateMixin {
  final appController = Get.put(AppointmentController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: FutureBuilder(
          future: appController.fetchAppointmentDetails(),
          builder: (context, snapshot) {
            return Scaffold(
              appBar: AppBar(
                toolbarHeight: 80,
                leading: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_back,
                      color: Color.fromRGBO(19, 96, 239, 1),
                    )),
                title: Text(
                  "Appointments",
                  style: TextStyle(color: Color.fromRGBO(19, 96, 239, 1)),
                ),
                bottom: TabBar(
                    unselectedLabelColor: Colors.black,
                    labelColor: AppColors.mainColorbutton,
                    indicatorColor: AppColors.mainColorbutton,
                    indicatorSize: TabBarIndicatorSize.label,
                    onTap: (int t) => setState(() {}),
                    tabs: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 15.h),
                        child: Text(
                          "Upcoming",
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 15.h),
                        child: Text(
                          "Past",
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ]),
                backgroundColor: Colors.white,
                elevation: 1,
              ),
              body: TabBarView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: (appController.upcomingAppointments.value?.isEmpty ??
                            true)
                        ? Center(
                            child: Text("No Upcoming's Appointments"),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: (context, index) => Appointment(
                                date: appController.upcomingAppointments
                                        .value?[index].appointmentDate ??
                                    '[Date]',
                                time:'@'+convertTime(appController.upcomingAppointments
                                        .value?[index].startTime??'00:00') ??
                                    '[StartTime]',
                                status: appController.upcomingAppointments
                                        .value?[index].status
                                        .toString() ??
                                    '0',
                                id: appController.upcomingAppointments.value?[index].id ??
                                    -1,
                                name: appController.upcomingAppointments.value?[index].doctorName ?? '[Pat. Name]'),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 10.h,
                                ),
                            itemCount: appController.upcomingAppointments.value?.length ?? 0),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: (appController.pastAppointments.value?.isEmpty ??
                            false)
                        ? Center(
                            child: Text("No Past's Appointments"),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: (context, index) => PastAppointment(
                                invoice: '#8677',
                                date: appController.pastAppointments
                                        .value?[index].appointmentDate ??
                                    '[Date]',
                                name: appController.pastAppointments
                                        .value?[index].doctorName ??
                                    ''),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 10.h,
                                ),
                            itemCount:
                                appController.pastAppointments.value?.length ??
                                    0),
                  )
                ],
              ),
            );
          },
        ));
  }
}
