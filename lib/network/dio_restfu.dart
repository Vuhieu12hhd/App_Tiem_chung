import 'package:dio/dio.dart';

class DioRestFull {
  DioRestFull._privateConstructor();

  static final DioRestFull _dioRestFull = DioRestFull._privateConstructor();

  factory DioRestFull() {
    return _dioRestFull;
  }

  BaseOptions baseOptions() {
    BaseOptions baseOptions = BaseOptions(
      headers: {
        "Content-Type": "application/json;charset=utf-8",
        "Accept": "*/*",
        'Server': 'Kestrel'
      },
      baseUrl: 'https://localhost:44300/',
      connectTimeout: const Duration(milliseconds: 15000),
      receiveTimeout: const Duration(milliseconds: 15000),
    );
    return baseOptions;
  }

  String getProfile = "/DatLich/XemThongTinCaNhan";
  String login = "/Login/dangnhap";
  String signIn = "/Login/dangky";
  String bookingList = '/DatLich/vacxin';
  String profile = '/Profile/xemthongtincanhan';
  String PostBooking = '/DatLich/datlich';
  String history = '/Profile/xemlichsu';
}
