import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// ignore: unnecessary_import
import 'package:get/get_core/src/get_main.dart';
import 'package:mmdapp/model/prescriptionModel.dart';
import 'package:mmdapp/utils/pdf/pdfController.dart';
import 'package:mmdapp/utils/pdf/pdfapi.dart';
import './pdfapi.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class PdfInvoiceApi {
  final pdfController = Get.put((PdfController()));

  static Future<File> generate(PrescriptionModel pdfData) async {
    var theme = ThemeData.withFont(
      base:
          Font.ttf(await rootBundle.load("assets/fonts/OpenSans-Regular.ttf")),
      bold: Font.ttf(await rootBundle.load("assets/fonts/OpenSans-Bold.ttf")),
    );
    final pdf = Document(theme: theme);

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text("PATIENT DETAILS",
                                style: pw.TextStyle(
                                    fontSize: 17,
                                    fontWeight: pw.FontWeight.bold)),
                            pw.SizedBox(height: 20),
                            pw.Text(pdfData.customerName ?? '',
                                style: const pw.TextStyle(
                                  fontSize: 14,
                                )),
                            pw.SizedBox(height: 5),
                            pw.Text(pdfData.mobile.toString() ?? '',
                                style: const pw.TextStyle(
                                  fontSize: 17,
                                )),
                          ]),
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            pw.Text(pdfData.clinicName ?? '[Clinic Name]',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: pw.FontWeight.bold)),
                            pw.SizedBox(height: 5),
                            pw.Text(pdfData.doctorName ?? '[Doctor Name]',
                                style: const TextStyle(fontSize: 14)),
                            pw.SizedBox(height: 20),
                            pw.Text("[Doctor Email]",
                                style: const TextStyle(fontSize: 14)),
                            pw.SizedBox(height: 5),
                            pw.Text("[Doctor Phone]",
                                style: const TextStyle(fontSize: 14)),
                            pw.SizedBox(height: 20),
                            pw.Text("PRESCRIPTION",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: pw.FontWeight.bold)),
                            pw.SizedBox(height: 10),
                            pw.Text("Date",
                                style: const TextStyle(fontSize: 14)),
                            pw.SizedBox(height: 10),
                            pw.Text(pdfData.createdAt?.split("T")[0] ?? '',
                                style: const TextStyle(fontSize: 14)),
                          ])
                    ]),
                pw.SizedBox(height: 40),
                pw.Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Column(children: [
                        pw.Text("Description",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.blue)),
                      ]),
                      pw.Column(children: [
                        pw.Text("Quantity",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.blue)),
                      ]),
                      pw.Column(children: [
                        pw.Text("Direction of intake",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.blue)),
                      ]),
                    ]),
                pw.Container(
                    child: pw.ListView.builder(
                  itemBuilder: (context, index) => pw.Column(
                    children: [
                      pw.SizedBox(height: 10),
                      pw.Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  pw.Text(
                                      pdfData.prescriptionList?[index].name ??
                                          '',
                                      textAlign: TextAlign.center)
                                ]),
                            pw.Column(children: [pw.Text("1")]),
                            pw.Column(children: [
                              pw.Text(
                                  pdfData.prescriptionList?[index].note ?? '')
                            ]),
                          ]),
                      pw.SizedBox(height: 10),
                    ],
                  ),
                  itemCount: pdfData.prescriptionList?.length ?? 0,
                )),
                pw.SizedBox(height: 40),
                pw.Text("OTHER INFORMATION",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.black)),
                pw.SizedBox(height: 10),
                pw.Text(
                    "We are pleased to provide you with the following information about your health condition and treatment options. Please read this information carefully and discuss any questions you may have with your doctor."),
                pw.SizedBox(height: 40),
                pw.Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Thank You for Trusting Us",
                          style: pw.TextStyle(
                              fontSize: 17, fontWeight: pw.FontWeight.normal)),
                      pw.Text(pdfData.doctorName ?? '[Doctor Name]',
                          style: pw.TextStyle(
                              fontSize: 17, fontWeight: pw.FontWeight.normal))
                    ])
              ]);
        }));

    return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }

  static Widget buildHeader(Map invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 50,
                width: 50,
                child: BarcodeWidget(barcode: Barcode.qrCode(), data: 'hey'),
              ),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [],
          ),
        ],
      );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}
