import 'dart:typed_data';

import 'package:control_panel/structures/constants.dart';
import 'package:control_panel/structures/protobuf/packet.pb.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_bluetooth/flutter_web_bluetooth.dart';
import 'package:flutter_web_bluetooth/js_web_bluetooth.dart';
import 'package:collection/collection.dart';

class AddHub extends StatefulWidget {
  final String accessToken;
  const AddHub({Key? key, required this.accessToken}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AddHubState();
}

class AddHubState extends State<AddHub> {
  HubState curState = HubState.findHubs;
  bool connected = false;
  List<WiFiData> wifiList = [];

  @override
  void initState() {
    super.initState();
    if (!FlutterWebBluetooth.instance.isBluetoothApiSupported) {
      setState(() {
        curState = HubState.notSupported;
      });
    } else {
      FlutterWebBluetooth.instance.isAvailable.listen((isAvailable) {
        if (!isAvailable) {
          setState(() {
            curState = HubState.notAvailable;
          });
        }
      });
      () async {
        final requestOptions = RequestOptionsBuilder.acceptAllDevices(
            optionalServices: [HUB_UUID]);
        try {
          final device =
              await FlutterWebBluetooth.instance.requestDevice(requestOptions);
          setState(() {
            curState = HubState.aboutToConnect;
          });
          if (!device.hasGATT) {
            setState(() {
              curState = HubState.cannotCommunicate;
            });
          }
          await device.connect();
          device.connected.listen(
              (conn) {
                if (conn) {
                  connected = true;
                }
                if (!conn && connected) {
                  setState(() {
                    setState(() {
                      curState = HubState.lostConnection;
                    });
                  });
                }
              },
              onDone: () {
                setState(() {
                  curState = HubState.lostConnection;
                });
              },
              cancelOnError: true,
              onError: (e) {
                debugPrint("E=$e");
                setState(() {
                  curState = HubState.lostConnection;
                });
              });
          bool isAvailable = true;
          device.services.listen((event) async {
            if (event.isNotEmpty) {
              if (isAvailable) {
                isAvailable = false;
                debugPrint("event=${event[0].isPrimary}");
                debugPrint("len=${event.length},e=$event");

                BluetoothCharacteristic read =
                    await event[0].getCharacteristic(READ_UUID);
                Packet p = Packet(getWifi: GetWiFi());
                Uint8List protobufData = p.writeToBuffer();
                Uint8List size = int32LittleEndianBytes(protobufData.length);
                var b = BytesBuilder();
                b.add(size);
                b.add(protobufData);
                debugPrint("b=${b.toBytes()}");
                await read
                    .writeValueWithoutResponse(Uint8List.fromList(b.toBytes()));

                debugPrint("done writing");

                b.clear();
                int sizeOfWifiData = (await read.readValue())
                    .buffer
                    .asByteData()
                    .getUint32(0, Endian.little);

                while (b.length < sizeOfWifiData) {
                  b.add((await read.readValue()).buffer.asInt8List());
                  debugPrint("b=${b.toBytes()}");
                }

                debugPrint("b2=${b.toBytes()}");
                p = Packet.fromBuffer(b.toBytes());
                if (p.whichType() != Packet_Type.wifi) {
                  setState(() {
                    curState = HubState.assertionError;
                  });
                  return;
                }
                List<WiFiData> _wifiList = p.wifi.data
                    .map((e) => WiFiData(
                        name: e.sSID,
                        bssid: e.bSSID,
                        isEncrypted: e.isEncrypted,
                        channel: e.channel))
                    .toList();
                setState(() {
                  wifiList = _wifiList;
                  curState = HubState.getWiFiUsernamePassword;
                });
                isAvailable = true;
              }
            } else {
              setState(() {
                curState = HubState.networkError;
              });
              isAvailable = true;
            }
          });
        } on NetworkError {
          setState(() {
            curState = HubState.networkError;
          });
        } on UserCancelledDialogError {
          setState(() {
            curState = HubState.cancelled;
          });
        } on DeviceNotFoundError {
          setState(() {
            curState = HubState.deviceNotFound;
          });
        }
      }();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 480,
        child: AlertDialog(
          content: SizedBox(height: 480, width: 480, child: getView(curState)),
          title: const Text("Alert"),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20),
      ),
    );
  }

  Widget getView(HubState curState) {
    debugPrint("curState=$curState");
    switch (curState) {
      case HubState.findHubs:
        return const Center(child: CircularProgressIndicator());
      case HubState.getWiFiUsernamePassword:
        return SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: wifiList.map((e) => buildWiFis(e)).toList()));
      case HubState.notSupported:
        return const Center(
            child: Text(
                "Your browser does not support WebBluetooth on your platform"));
      case HubState.aboutToConnect:
        return Column(children: const [
          Text("Connecting..."),
          CircularProgressIndicator()
        ]);
      case HubState.notAvailable:
        return const Center(child: Text("Bluetooth is not available"));
      case HubState.cancelled:
        return const Center(child: Text("Device selection was cancelled"));
      case HubState.deviceNotFound:
        return const Center(child: Text("Device was not found"));
      case HubState.lostConnection:
        return const Center(child: Text("Lost Connection"));
      case HubState.networkError:
        return const Center(child: Text("Network Error"));
      case HubState.cannotCommunicate:
        return const Center(child: Text("GATT not able to connect"));
      case HubState.assertionError:
        return const Center(child: Text("Assertion Error"));
    }
  }

  Future<List<int>> waitForData(BluetoothCharacteristic read) async {
    List<int> data = [0, 0, 0, 0];
    debugPrint("bdata=$data");

    ByteData? bd;
    while (const DeepCollectionEquality().equals(data, [0, 0, 0, 0])) {
      bd = await read.readValue();
      data = bd.buffer.asUint8List();
      debugPrint("idata=$data");
    }
    debugPrint("adata=$data");

    if (bd == null) {
      return Uint8List(0);
    } else {
      return bd.buffer.asUint8List();
    }
  }

  Widget buildWiFis(WiFiData w) {
    return InkWell(
        onTap: () {
          debugPrint("Test");
        },
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                    child: Icon(
                      w.isEncrypted == true ? Icons.wifi_lock : Icons.wifi,
                      size: 24,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        w.name,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  )
                ])));
  }
}

enum HubState {
  findHubs,
  getWiFiUsernamePassword,
// Errors:
  notSupported,
  notAvailable,
  cancelled,
  deviceNotFound,
  lostConnection,
  aboutToConnect,
  cannotCommunicate,
  networkError,
  assertionError,
}

class WiFiData {
  String name;

  Int64 bssid;
  bool isEncrypted;
  int channel;
  WiFiData(
      {required this.name,
      required this.bssid,
      required this.channel,
      required this.isEncrypted});
}

Uint8List int32LittleEndianBytes(int value) =>
    Uint8List(4)..buffer.asByteData().setInt32(0, value, Endian.little);
