import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mmdapp/model/prescriptionModel.dart';
import 'package:mmdapp/utils/global_variable.dart';
import 'package:mmdapp/utils/pdf/pdfapi.dart';
import 'package:mmdapp/utils/pdf/pdfgenerateapi.dart';
import 'package:mmdapp/utils/toast.dart';

class Prescription extends StatefulWidget {
  // final String prescription;
  // final String category;
  final String name;
  final String date;
  final PrescriptionModel presc;

  const Prescription(
      {super.key,
      // required this.prescription,
      // required this.category,
      required this.name,
      required this.date,
      required this.presc});

  @override
  State<Prescription> createState() => _PrescriptionState();
}

class _PrescriptionState extends State<Prescription> {
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
              style: TextStyle(color: AppColors.darkTextColor, fontSize: 11.sp),
            ),
            Text(
              widget.date,
              style: TextStyle(color: AppColors.darkTextColor, fontSize: 11.sp),
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
              "${widget.name}",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600),
            ),
            GestureDetector(
              child: Wrap(
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
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              onTap: () async {
                final pdfFile = await PdfInvoiceApi.generate(widget.presc);
                PdfApi.openFile(pdfFile);
              },
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
