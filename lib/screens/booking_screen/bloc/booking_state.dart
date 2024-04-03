part of 'booking_bloc.dart';

@immutable
abstract class BookingState {}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingLoaded extends BookingState {
  final List<History> history;

  @override
  List<Object>? get props => history;

  BookingLoaded(this.history);
}

class BookingError extends BookingState {
  final String error;

  @override
  List<Object>? get props => [error];

  BookingError(this.error);
}
