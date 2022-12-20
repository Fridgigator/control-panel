import 'package:equatable/equatable.dart';

class Fridge extends Equatable {
  final double medianTemp;
  final double lowTemp;
  final double highTemp;

  final double lowHumidity;
  final double highHumidity;

  final String name;
  final String id;

  const Fridge(
      {required this.medianTemp,
      required this.lowTemp,
      required this.highTemp,
      required this.lowHumidity,
      required this.name,
      required this.id,
      required this.highHumidity});
  @override
  List<Object?> get props =>
      [medianTemp, lowTemp, highTemp, lowHumidity, highHumidity, name, id];
}
