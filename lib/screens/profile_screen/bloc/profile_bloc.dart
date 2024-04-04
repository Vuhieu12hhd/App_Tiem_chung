import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:injection_schedule/network/dio_restfu.dart';
import 'package:injection_schedule/screens/profile_screen/models/Infor_model.dart';
import 'package:meta/meta.dart';

import '../../../secure_storage.dart';
import '../../../network/dio_exception.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileStarted>(_onStarted);
  }

  Future<void> _onStarted(
      ProfileStarted event, Emitter<ProfileState> emit) async {
    Response? response;
    String error = DioExceptions.DEFAULT;
    emit(ProfileLoading());
    String id = await SercureStorageApp().GetValueData('id');
    print('id$id');
    try {
      response = await DioRestFull.instance.dio.get(DioRestFull().profile,
          queryParameters: {'idKh': int.parse(id)}).catchError((onError) {
        error = DioExceptions.messageError(onError);
      });
      if (response != null) {
        final a = Profile.fromJson(response.data);
        emit(ProfileLoaded(a));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
