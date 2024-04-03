import 'package:equatable/equatable.dart';

class Item extends Equatable {
  Item(this.id, this.name);

  final int id;
  final String name;

  @override
  List<Object> get props => [id, name];
}
