import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:injection_schedule/network/dio_exception.dart';
import 'package:injection_schedule/network/dio_restfu.dart';
import 'package:injection_schedule/screens/home_screen/models/Booking_model.dart';
import 'package:injection_schedule/screens/home_screen/models/home_model.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeVacxin>(_onVacxin);
  }
}

Future<void> _onVacxin(HomeVacxin event, Emitter<HomeState> emit) async {
  const _delay = Duration(milliseconds: 800);
  const result = ['VX 1', 'VX 2', 'VX 3'];
  emit(HomeLoading());
  Response? response;
  String error = DioExceptions.DEFAULT;
  try {
    response = await DioRestFull.instance.dio
        .get(DioRestFull().bookingList)
        .catchError((onError) {
      error = DioExceptions.messageError(onError);
    });
    print('aaaa${response.data}');
  } catch (error) {
    emit(HomeError(error.toString()));
  }
  if (response != null) {
    print('aaaa${response.data}');
    List<BookingModel> vacxinList = List<BookingModel>.from(
        response.data.map((e) => BookingModel.fromJson(e)));
    emit(BookingLoaded(vacxinList));
  } else {
    emit(BookingError(error));
  }
}
