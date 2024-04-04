import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injection_schedule/utils/local_storage.dart';

class DioRestFull {
  late final LocalStorage localStorage;
  late final Dio dio = Dio(baseOptions());

  static final DioRestFull instance = DioRestFull._privateConstructor();

  DioRestFull._privateConstructor() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        final token = localStorage.token;
        print(options.baseUrl);
        if (token.isNotEmpty) {
          options.headers['authorization'] = "Bearer $token";
        }
        log('${options.data}');

        log("${options.headers}");
        handler.next(options);
      },
    ));
  }

  factory DioRestFull() {
    return instance;
  }

  BaseOptions baseOptions() {
    BaseOptions baseOptions = BaseOptions(
      headers: {
        "Content-Type": "application/json;charset=utf-8",
        "Accept": "*/*",
        'Server': 'Kestrel'
      },
      baseUrl: BASE_URL,
      connectTimeout: const Duration(milliseconds: 15000),
      receiveTimeout: const Duration(milliseconds: 15000),
    );
    return baseOptions;
  }

  String getProfile = "/DatLich/XemThongTinCaNhan";
  String login = "/login";
  String signIn = "/register";
  String bookingList = '/DatLich/vacxin';
  String profile = '/Profile/xemthongtincanhan';
  String PostBooking = '/DatLich/datlich';
  String myInfo = '/user/my_info';
  String history = '/Profile/xemlichsu';
  String vaccinationSchedule = '/vaccinationSchedules';
  String getVaccineQrCode(int id) => '$BASE_URL/vaccinationSchedules/$id';
  String vaccines = '/vaccines';
}

const BASE_URL = 'http://192.168.1.22:3000/api/v1';
