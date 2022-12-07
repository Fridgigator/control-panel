class Hub {
  String uuid;
  int lastConnected;
  Hub({required this.uuid, required this.lastConnected});
  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Hub && uuid == other.uuid;

  @override
  int get hashCode => uuid.hashCode;
}

class Sensor {
  String location;
  String key;
  String uuid;
  String model;
  String name;
  int typeOfData;
  int time;
  double value;
  Sensor({
    required this.location,
    required this.key,
    required this.uuid,
    required this.model,
    required this.name,
    required this.value,
    required this.time,
    required this.typeOfData,
  });
  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Sensor && key == other.key;

  @override
  int get hashCode => key.hashCode;

  static String modelFromNumber(int model) {
    switch (model) {
      case 0:
        return "TI";

      case 1:
        return "Nordic";
      case 3:
        return "Custom";
    }
    return "";
  }
}

class Fridge {
  String name;
  String uuid;
  List<Sensor> sensors;
  Fridge({required this.name, required this.uuid, required this.sensors});
  @override
  bool operator ==(Object other) {
    return other is Fridge && uuid == other.uuid;
  }

  @override
  int get hashCode => uuid.hashCode;
}

class PhoneData {
  String num;
  VerifiedState state;
  PhoneData({required this.num, required this.state});
}

enum VerifiedState {
  verified,
  expired,
  notVerified,
}
