
class Profile {
  int? id;
  String? ten;
  String? diaChi;
  int? soDt;
  String? email;
  String? ngaySinh;
  String? gioiTinh;
  String? cccd;
  String? matKhau;

  Profile(
      {this.id,
        this.ten,
        this.diaChi,
        this.soDt,
        this.email,
        this.ngaySinh,
        this.gioiTinh,
        this.cccd,
        this.matKhau});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ten = json['ten'];
    diaChi = json['diaChi'];
    soDt = json['soDt'];
    email = json['email'];
    ngaySinh = json['ngaySinh'];
    gioiTinh = json['gioiTinh'];
    cccd = json['cccd'];
    matKhau = json['matKhau'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ten'] = this.ten;
    data['diaChi'] = this.diaChi;
    data['soDt'] = this.soDt;
    data['email'] = this.email;
    data['ngaySinh'] = this.ngaySinh;
    data['gioiTinh'] = this.gioiTinh;
    data['cccd'] = this.cccd;
    data['matKhau'] = this.matKhau;
    return data;
  }
}