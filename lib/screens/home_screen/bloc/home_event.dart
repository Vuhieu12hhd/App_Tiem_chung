part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {
  @override
  List<Object> get props => [];
}

class HomeStarted extends HomeEvent {}

class HomeVacxin extends HomeEvent{}
