class DoctorModel2 {
  late String fullName;
  late String ranking;
  late String clinicEndTime;
  late String clinicStartTime;
  late String doctorSpeciality;
  late String url;
  late num id;

  DoctorModel2({
    required this.fullName,
    required this.ranking,
    required this.clinicEndTime,
    required this.clinicStartTime,
    required this.doctorSpeciality,
    required this.url,
    required this.id,
  });

  factory DoctorModel2.fromJson(Map<String, dynamic> json) {
    return DoctorModel2(
      fullName: json['full_name'],
      doctorSpeciality: json['doctor_speciality'] ?? '',
      clinicStartTime: json['clinic_start_time'] ?? '',
      clinicEndTime: json['clinic_end_time'] ?? '',
      ranking: '5',
      url: json['url'],
      id: json['id'],
    );
  }
}

class DoctorModel {
  late List name;
  late List ranking;
  late List time;
  late List category;
  late List url;

  DoctorModel({
    required this.name,
    required this.ranking,
    required this.time,
    required this.category,
    required this.url,
  });
}

class CategoryModel {
  late List title;
  late List url;
  late List color;
  late List category;

  CategoryModel({
    required this.title,
    required this.url,
    required this.color,
    required this.category,
  });
}

class SummaryModel {
  late String date;
  late String time;
  late String fee1;
  late String fee2;

  SummaryModel({
    required this.date,
    required this.time,
    required this.fee1,
    required this.fee2,
  });
}
