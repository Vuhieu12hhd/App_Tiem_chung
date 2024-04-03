
class BookingModel {
  int? id;
  String? ten;
  String? nccid;
  String? tieuChuan;
  String? soLo;

  BookingModel({this.id, this.ten, this.nccid, this.tieuChuan, this.soLo});

  BookingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ten = json['ten'];
    nccid = json['nccid'];
    tieuChuan = json['tieuChuan'];
    soLo = json['soLo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ten'] = this.ten;
    data['nccid'] = this.nccid;
    data['tieuChuan'] = this.tieuChuan;
    data['soLo'] = this.soLo;
    return data;
  }
}
