import 'package:equatable/equatable.dart';

class Hub extends Equatable {
  final DateTime lastSeen;
  final List<DateTime> pings;
  final String id;

  const Hub({required this.lastSeen, required this.id, required this.pings});
  @override
  List<Object?> get props => [id, lastSeen, pings];
}
