import 'package:equatable/equatable.dart';

class SensorData extends Equatable {
  final double valLow;
  final double valHigh;
  final DateTime startTime;
  final DateTime endTime;

  const SensorData(
      {required this.valLow,
      required this.valHigh,
      required this.startTime,
      required this.endTime});

  @override
  List<Object> get props => [valHigh, valLow, startTime];
}
