import 'package:control_panel/data_structures/data_value.dart';
import 'package:equatable/equatable.dart';

class Sensor extends Equatable {
  final ModelType model;
  final String location;
  final String name;
  final List<DataValue> dataValues;

  const Sensor(
      {required this.model,
      required this.location,
      required this.name,
      required this.dataValues});

  @override
  List<Object?> get props => [name];
}

enum ModelType { pico, lpstk, thingy }
