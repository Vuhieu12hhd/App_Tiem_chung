import 'package:equatable/equatable.dart';
import 'package:injection_schedule/screens/home_screen/models/items.dart';

class HomeModel extends Equatable {
  const HomeModel({required this.itemNames});

  final List<String> itemNames;

  Item getById(int id) => Item(id, itemNames[id % itemNames.length]);

  Item getByPosition(int position) => getById(position);

  @override
  List<Object> get props => [itemNames];
}