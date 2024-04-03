part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileStarted extends ProfileEvent {}
