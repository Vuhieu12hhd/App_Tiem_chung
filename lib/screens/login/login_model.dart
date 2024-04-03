import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel{
  int? id;
  String? ten;
  String? diachi;
  int? soDt;
  String? email;
  String? ngaySinh;
  String? gioiTinh;
  String? cccd;
  String? matKhau;

  LoginModel({this.id, this.ten, this.diachi, this.soDt, this.email,
    this.ngaySinh, this.gioiTinh, this.cccd, this.matKhau});

  factory LoginModel.fromJson(Map<String, dynamic> json) => _$LoginModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}