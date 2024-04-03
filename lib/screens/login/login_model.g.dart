// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) => LoginModel(
      id: json['id'] as int?,
      ten: json['ten'] as String?,
      diachi: json['diachi'] as String?,
      soDt: json['soDt'] as int?,
      email: json['email'] as String?,
      ngaySinh: json['ngaySinh'] as String?,
      gioiTinh: json['gioiTinh'] as String?,
      cccd: json['cccd'] as String?,
      matKhau: json['matKhau'] as String?,
    );

Map<String, dynamic> _$LoginModelToJson(LoginModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ten': instance.ten,
      'diachi': instance.diachi,
      'soDt': instance.soDt,
      'email': instance.email,
      'ngaySinh': instance.ngaySinh,
      'gioiTinh': instance.gioiTinh,
      'cccd': instance.cccd,
      'matKhau': instance.matKhau,
    };
