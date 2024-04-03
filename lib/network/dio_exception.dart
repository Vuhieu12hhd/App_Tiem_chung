import 'package:dio/dio.dart';

class DioExceptions implements Exception {
  static final String AUTHENT = "AUTHENT";
  static final String CANCEL = "CANCEL";
  static final String CONNECT_TIMEOUT = "CONNECT_TIMEOUT";
  static final String DEFAULT = "DEFAULT";
  static final String RECEIVE_TIMEOUT = "RECEIVE_TIMEOUT";
  static final String SEND_TIMEOUT = "SEND_TIMEOUT";
  static final String BAD_REQUEST = "BAD_REQUEST";
  static final String INTERNAL_SERVER = "INTERNAL_SERVER";
  static final String EXPIRED_SESSION = "EXPIRED_SESSION";
  static final String SOME_THING = "SOME_THING";
  static final String SUCCESS = "SUCCESS";
  static final String FAIL = "FAIL";
  static final String LOGOUT = "LOGOUT";

  static String messageError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        return CANCEL;
      case DioErrorType.connectionTimeout:
        return CONNECT_TIMEOUT;
      case DioErrorType.receiveTimeout:
        return RECEIVE_TIMEOUT;
      case DioErrorType.badResponse:
        return _handleError(dioError.response!.statusCode!, dioError.response!.data);
      case DioErrorType.sendTimeout:
        return SEND_TIMEOUT;
      default:
        return SOME_THING;
    }
  }

  static String _handleError(int statusCode, dynamic error) {
    switch (statusCode) {
      case 200:
        return SUCCESS;
      case 400:
        return BAD_REQUEST;
      case 401:
        return EXPIRED_SESSION;
      case 403:
        return AUTHENT;
      case 404:
        return error["message"];
      case 500:
        return INTERNAL_SERVER;
      default:
        return SOME_THING;
    }
  }
}
