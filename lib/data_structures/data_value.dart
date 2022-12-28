import 'package:equatable/equatable.dart';

class DataValue extends Equatable {
  final TypeOfData typeOfData;
  final DateTime time;
  final double value;

  const DataValue(
      {required this.typeOfData, required this.time, required this.value});
  @override
  List<Object?> get props => [typeOfData, time, value];
}

enum TypeOfData {
  temp,
  humidity,
  dht11Temp,
  dht11Humidity,
  dht22Temp,
  dht22Humidity,
  picoTemp
}
