class AppointmentModel {
  late String startTime;
  late String endTime;
  late int id;
  late String doctorName;
  late int status;
  late String appointmentDate;

  AppointmentModel({
    required this.startTime,
    required this.endTime,
    required this.id,
    required this.doctorName,
    required this.status,
    required this.appointmentDate,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      startTime: json['start_time'],
      endTime: json['end_time'],
      status: json['status'],
      appointmentDate: json['appointmentDate'],
      doctorName: json['doctor_name'],
      id: json['id'],
    );
  }
}
