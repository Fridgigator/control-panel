class Hub {
  String uuid;
  bool isConnected;
  Hub({required this.uuid, required this.isConnected});
}

class Sensor {
  String name;
  String uuid;
  String model;
  Map<String, int> value;
  Sensor(
      {required this.name,
      required this.uuid,
      required this.model,
      required this.value});
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
}
