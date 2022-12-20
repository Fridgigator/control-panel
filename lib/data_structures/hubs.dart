import 'package:equatable/equatable.dart';

class Hubs extends Equatable {
  final DateTime lastSeen;

  final String id;

  const Hubs({required this.lastSeen, required this.id});
  @override
  List<Object?> get props => [id, lastSeen];
}
