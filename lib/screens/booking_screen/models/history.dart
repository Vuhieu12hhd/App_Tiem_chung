class History{
  int? id;
  int? idKh;
  String? diaDiemTiem;
  String? ngayTiem;
  int? trangThai;
  String? status;

  History(
      {this.id,
        this.idKh,
        this.diaDiemTiem,
        this.ngayTiem,
        this.trangThai,
        this.status});

  History.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idKh = json['idKh'];
    diaDiemTiem = json['diaDiemTiem'];
    ngayTiem = json['ngayTiem'];
    trangThai = json['trangThai'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idKh'] = this.idKh;
    data['diaDiemTiem'] = this.diaDiemTiem;
    data['ngayTiem'] = this.ngayTiem;
    data['trangThai'] = this.trangThai;
    data['status'] = this.status;
    return data;
  }
}