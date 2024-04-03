part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final HomeModel booking;

  @override
  List<Object?> get props => [booking];

  HomeLoaded(this.booking);
}

class HomeError extends HomeState {
  final String error;

  @override
  List<Object?> get props => [error];

  HomeError(this.error);
}

class BookingLoading extends HomeState {}
class BookingLoaded extends HomeState {
  final List<BookingModel> vacxin;

  @override
  List<Object>? get props => [vacxin];

  BookingLoaded(this.vacxin);
}

class BookingError extends HomeState {
  final String error;

  @override
  Object? get props => error;

  BookingError(this.error);
}
