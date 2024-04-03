import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:injection_schedule/network/dio_exception.dart';
import 'package:injection_schedule/network/dio_restfu.dart';
import 'package:meta/meta.dart';

import '../../../secure_storage.dart';
import '../models/history.dart';

part 'booking_event.dart';

part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingInitial()) {
    on<BookingStarted>(_onStarted);
  }

  Future<void> _onStarted(
      BookingStarted event, Emitter<BookingState> emit) async {
    emit(BookingLoading());
    String error = DioExceptions.DEFAULT;
    Response? response;
    String id =SercureStorageApp().GetValueData('id');
    print(id);
    try{
      response = await Dio(DioRestFull().baseOptions()).get(DioRestFull().history, queryParameters: {
        'idKh':int.parse(id)
      }).catchError((onError){
        error=DioExceptions.messageError(onError);
        emit(BookingError(error.toString()));
      });
    if(response!=null){
      List<History> bookingModel = List<History>.from(response.data.map((e)=>History.fromJson(e)));
      emit(BookingLoaded(bookingModel));
    }
    } catch (error) {
      emit(BookingError(error.toString()));
    }
  }
}
