class PrescriptionList {
  int? id;
  String? name;
  String? drugToTaken;
  String? note;
  bool? deleted;
  int? createdBy;
  String? createdAt;

  PrescriptionList(
      {this.id,
      this.name,
      this.drugToTaken,
      this.note,
      this.deleted,
      this.createdBy,
      this.createdAt});

  PrescriptionList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    drugToTaken = json['drug_to_taken'];
    note = json['note'];
    deleted = json['deleted'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['drug_to_taken'] = this.drugToTaken;
    data['note'] = this.note;
    data['deleted'] = this.deleted;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class PrescriptionModel {
  int? id;
  int? customer;
  String? customerName;
  String? clinicName;
  int? queue;
  int? mobile;
  List<int>? prescription;
  String? note;
  String? prescriptionName;
  bool? deleted;
  int? createdBy;
  String? createdAt;
  List<PrescriptionList>? prescriptionList;
  String? purposeOfVisit;
  String? symptoms;
  String? doctorName;
  List<String>? doctorTags;

  PrescriptionModel(
      {this.id,
      this.customer,
      this.customerName,
      this.clinicName,
      this.queue,
      this.mobile,
      this.prescription,
      this.note,
      this.prescriptionName,
      this.deleted,
      this.createdBy,
      this.createdAt,
      this.prescriptionList,
      this.purposeOfVisit,
      this.symptoms,
      this.doctorName,
      this.doctorTags});

  PrescriptionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customer = json['customer'];
    customerName = json['customer_name'];
    clinicName = json['clinic_name'];
    queue = json['queue'];
    mobile = json['mobile'];
    prescription = json['prescription'].cast<int>();
    note = json['note'];
    prescriptionName = json['prescription_name'];
    deleted = json['deleted'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    if (json['prescription_list'] != null) {
      prescriptionList = <PrescriptionList>[];
      json['prescription_list'].forEach((v) {
        prescriptionList!.add(new PrescriptionList.fromJson(v));
      });
    }
    purposeOfVisit = json['purpose_of_visit'];
    symptoms = json['symptoms'];
    doctorName = json['doctor_name'];
    if (json['doctor_tags'] != null) {
      doctorTags = <String>[];
      json['doctor_tags'].forEach((v) {
        doctorTags!.add(v.toString());
      });
    }
  }
}
