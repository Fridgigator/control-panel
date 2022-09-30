class Hub {
  String uuid;
  bool isConnected;
  Hub({required this.uuid, required this.isConnected});
  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Hub && uuid == other.uuid;

  @override
  int get hashCode => uuid.hashCode;
}

class Sensor {
  String name;
  String uuid;
  String model;
  Map<String, double> value;
  Sensor(
      {required this.name,
      required this.uuid,
      required this.model,
      required this.value});
  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Sensor && uuid == other.uuid;

  @override
  int get hashCode => uuid.hashCode;
}

class Data {
  int typeOfData;
  int valOfData;
  Data({required this.typeOfData, required this.valOfData});
}

class Fridge {
  String name;
  String uuid;
  List<Sensor> sensors;
  Fridge({required this.name, required this.uuid, required this.sensors});
  @override
  bool operator ==(Object other) {
    print("other=${(other as Fridge).uuid}, this=${this.uuid}");
    return other is Fridge && uuid == other.uuid;
  }

  @override
  int get hashCode => uuid.hashCode;
}
