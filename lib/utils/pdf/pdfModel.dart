class PdfModel {
  final String patientName;
  final String number;
  final String email;

  final String Date;
  final String description;
  final String quantity;
  final String intake;
  final String doctorName;

  PdfModel(this.Date, this.description, this.quantity, this.intake,
      this.doctorName, this.email, this.number, this.patientName);
}
