part of 'booking_bloc.dart';

@immutable
abstract class BookingEvent {
  BookingEvent();

  @override
  List<Object> get props => [];
}
class BookingStarted extends BookingEvent {
}