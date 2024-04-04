class Vaccine {
  int? id;
  String? name;
  String? description;
  int? vaccineProviderId;
  int? quantity;
  int? injectedQuantity;
  int? expiredQuantity;
  int? errorQuantity;
  int? price;
  String? standard;
  String? lotNumber;
  String? expiredAt;
  String? createdAt;
  String? updatedAt;
  VaccineProvider? vaccineProvider;

  Vaccine(
      {this.id,
      this.name,
      this.description,
      this.vaccineProviderId,
      this.quantity,
      this.injectedQuantity,
      this.expiredQuantity,
      this.errorQuantity,
      this.price,
      this.standard,
      this.lotNumber,
      this.expiredAt,
      this.createdAt,
      this.updatedAt,
      this.vaccineProvider});

  Vaccine.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    vaccineProviderId = json['vaccineProviderId'];
    quantity = json['quantity'];
    injectedQuantity = json['injectedQuantity'];
    expiredQuantity = json['expiredQuantity'];
    errorQuantity = json['errorQuantity'];
    price = json['price'];
    standard = json['standard'];
    lotNumber = json['lotNumber'];
    expiredAt = json['expiredAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    vaccineProvider = json['vaccineProvider'] != null
        ? new VaccineProvider.fromJson(json['vaccineProvider'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['vaccineProviderId'] = this.vaccineProviderId;
    data['quantity'] = this.quantity;
    data['injectedQuantity'] = this.injectedQuantity;
    data['expiredQuantity'] = this.expiredQuantity;
    data['errorQuantity'] = this.errorQuantity;
    data['price'] = this.price;
    data['standard'] = this.standard;
    data['lotNumber'] = this.lotNumber;
    data['expiredAt'] = this.expiredAt;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.vaccineProvider != null) {
      data['vaccineProvider'] = this.vaccineProvider!.toJson();
    }
    return data;
  }
}

class VaccineProvider {
  int? id;
  String? name;

  VaccineProvider({this.id, this.name});

  VaccineProvider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
