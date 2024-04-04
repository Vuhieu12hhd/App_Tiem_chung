class VaccineBooking {
  InjectorInfo? injectorInfo;
  List<HealthSurveyAnswers>? healthSurveyAnswers;
  int? id;
  String? date;
  int? vaccineId;
  int? userId;
  String? address;
  String? healthSurveyStatus;
  bool? isCanceled;
  String? createdAt;
  String? updatedAt;
  Vaccine? vaccine;

  VaccineBooking(
      {this.injectorInfo,
      this.healthSurveyAnswers,
      this.id,
      this.date,
      this.vaccineId,
      this.userId,
      this.address,
      this.healthSurveyStatus,
      this.isCanceled,
      this.createdAt,
      this.updatedAt,
      this.vaccine});

  VaccineBooking.fromJson(Map<String, dynamic> json) {
    injectorInfo = json['injectorInfo'] != null
        ? new InjectorInfo.fromJson(json['injectorInfo'])
        : null;
    if (json['healthSurveyAnswers'] != null) {
      healthSurveyAnswers = <HealthSurveyAnswers>[];
      json['healthSurveyAnswers'].forEach((v) {
        healthSurveyAnswers!.add(new HealthSurveyAnswers.fromJson(v));
      });
    }
    id = json['id'];
    date = json['date'];
    vaccineId = json['vaccineId'];
    userId = json['userId'];
    address = json['address'];
    healthSurveyStatus = json['healthSurveyStatus'];
    isCanceled = json['isCanceled'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    vaccine =
        json['vaccine'] != null ? new Vaccine.fromJson(json['vaccine']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.injectorInfo != null) {
      data['injectorInfo'] = this.injectorInfo!.toJson();
    }
    if (this.healthSurveyAnswers != null) {
      data['healthSurveyAnswers'] =
          this.healthSurveyAnswers!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['date'] = this.date;
    data['vaccineId'] = this.vaccineId;
    data['userId'] = this.userId;
    data['address'] = this.address;
    data['healthSurveyStatus'] = this.healthSurveyStatus;
    data['isCanceled'] = this.isCanceled;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.vaccine != null) {
      data['vaccine'] = this.vaccine!.toJson();
    }
    return data;
  }
}

class InjectorInfo {
  String? name;
  String? dob;
  String? gender;

  InjectorInfo({this.name, this.dob, this.gender});

  InjectorInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dob = json['dob'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    return data;
  }
}

class HealthSurveyAnswers {
  int? healthSurveyTemplateId;
  int? choice;

  HealthSurveyAnswers({this.healthSurveyTemplateId, this.choice});

  HealthSurveyAnswers.fromJson(Map<String, dynamic> json) {
    healthSurveyTemplateId = json['healthSurveyTemplateId'];
    choice = json['choice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['healthSurveyTemplateId'] = this.healthSurveyTemplateId;
    data['choice'] = this.choice;
    return data;
  }
}

class Vaccine {
  int? id;
  String? name;
  int? price;
  String? standard;
  String? lotNumber;

  Vaccine({this.id, this.name, this.price, this.standard, this.lotNumber});

  Vaccine.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    standard = json['standard'];
    lotNumber = json['lotNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['standard'] = this.standard;
    data['lotNumber'] = this.lotNumber;
    return data;
  }
}
