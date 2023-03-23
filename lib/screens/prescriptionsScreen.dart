import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mmdapp/model/prescriptionModel.dart';
import 'package:mmdapp/services/auth/appointmentService.dart';
import 'package:mmdapp/utils/global_variable.dart';
import 'package:mmdapp/utils/toast.dart';
import '../components/prescriptionComponent.dart';

class PrescriptionScreen extends StatefulWidget {
  static const String routeName = 'prescription';
  const PrescriptionScreen({super.key});

  @override
  State<PrescriptionScreen> createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {
  List<PrescriptionModel> prescriptions = [];
  FToast fToast = FToast();

  @override
  void initState() {
    super.initState();
    fToast.init(context);
    getPrescriptions().then((prescs) {
      prescriptions = prescs;
      setState(() {});
    });
  }

  Future<List<PrescriptionModel>> getPrescriptions() async {
    var resp = await listPrescriptions();
    if (resp.containsKey('success')) {
      bool success = resp['success'];
      print(resp);
      if (success) {
        var data = resp['data'];
        List<PrescriptionModel> prescs = [];

        for (var i = 0; i < data.length; i++) {
          var prescription = data[i];
          PrescriptionModel presc = PrescriptionModel.fromJson(prescription);
          prescs.add(presc);
        }
        return prescs;
      } else {
        if (resp.containsKey('message')) {
          fToast.showToast(child: errorToast(resp['message']));
          return [];
        }
      }
    } else {
      fToast.showToast(child: errorToast("Something Went Wrong"));
      return [];
    }

    fToast.showToast(child: errorToast('Something Went Wrong'));
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back,
              color: Color.fromRGBO(19, 96, 239, 1),
            )),
        title: const Text(
          "Prescriptions",
          style: TextStyle(color: Color.fromRGBO(19, 96, 239, 1)),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: ListView.separated(
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) => Prescription(
                    date: prescriptions[index].createdAt?.split("T")[0] ?? '',
                    name: prescriptions[index].doctorName ?? '',
                    presc: prescriptions[index],
                  ),
              separatorBuilder: (context, index) => SizedBox(
                    height: 10.h,
                  ),
              itemCount: prescriptions.length),
        ),
      ]),
    );
  }
}
