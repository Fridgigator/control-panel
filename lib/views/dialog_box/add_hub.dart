import 'dart:async';
import 'dart:typed_data';

import 'package:control_panel/structures/constants.dart';
import 'package:control_panel/structures/protobuf/packet.pb.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_bluetooth/flutter_web_bluetooth.dart';
import 'package:flutter_web_bluetooth/js_web_bluetooth.dart';
import 'package:collection/collection.dart';

import 'add_hub_views/select_wifi.dart';

class AddHub extends StatefulWidget {
  final String accessToken;
  const AddHub({Key? key, required this.accessToken}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AddHubState();
}

class AddHubState extends State<AddHub> {
  HubState curState = HubState.aboutToConnect;
  bool connected = false;
  List<WiFiData> wifiList = [];
  bool isConnectedToWiFi = false;
  WiFiData? selectedWiFi;
  int? currentlySelected;
  Completer<WiFiData> wifiToConnect = Completer<WiFiData>();
  Completer<String> passwordToConnect = Completer<String>();
  bool isConnectingToWiFi = false;
  BluetoothDevice? device;
  @override
  void dispose() {
    connected = false;
    device?.disconnect();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (!FlutterWebBluetooth.instance.isBluetoothApiSupported) {
      if (!mounted) {
        return;
      }
      setState(() {
        curState = HubState.notSupported;
      });
    } else {
      FlutterWebBluetooth.instance.isAvailable.listen((isAvailable) {
        if (!isAvailable) {
          if (!mounted) {
            return;
          }
          setState(() {
            curState = HubState.notAvailable;
          });
        }
      });
      () async {
        final requestOptions = RequestOptionsBuilder.acceptAllDevices(
            optionalServices: [HUB_UUID]);
        try {
          if (!mounted) {
            return;
          }
          device =
              await FlutterWebBluetooth.instance.requestDevice(requestOptions);
          if (!mounted) {
            return;
          }
          setState(() {
            curState = HubState.aboutToConnect;
          });

          if (device?.hasGATT != true) {
            if (!mounted) {
              return;
            }
            setState(() {
              curState = HubState.cannotCommunicate;
            });
          }
          await device?.connect();

          device?.connected.listen(
              (conn) {
                if (conn) {
                  connected = true;
                }
                if (!conn && connected) {
                  if (!mounted) {
                    return;
                  }
                  setState(() {
                    curState = HubState.lostConnection;
                    connected = false;
                  });
                }
              },
              onDone: () {
                if (!mounted) {
                  return;
                }
                setState(() {
                  curState = HubState.lostConnection;
                });
              },
              cancelOnError: true,
              onError: (e) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  curState = HubState.lostConnection;
                });
              });
          bool isAvailable = true;
          device?.services.listen((event) async {
            if (event.isNotEmpty) {
              if (isAvailable) {
                isAvailable = false;
                if (!mounted) {
                  return;
                }
                BluetoothCharacteristic ch =
                    await event[0].getCharacteristic(READ_UUID);
                if (!mounted) {
                  return;
                }
                await writeData(BLESendPacket(getWifi: GetWiFi()), ch);

                WiFiVector p = WiFiVector.fromBuffer(await readData(ch));

                List<WiFiData> _wifiList = p.data
                    .map((e) => WiFiData(
                        name: e.ssid,
                        bssid: e.bssid,
                        isEncrypted: e.isEncrypted,
                        channel: e.channel))
                    .toList();
                if (!mounted) {
                  return;
                }
                if (!mounted) {
                  return;
                }
                setState(() {
                  wifiList = _wifiList;
                  curState = HubState.selectWiFi;
                });
                while (!isConnectedToWiFi) {
                  WiFiData wifiToConnectWiFiData = await wifiToConnect.future;
                  String passwordToConnectString =
                      await passwordToConnect.future;
                  BLESendPacket wifi = BLESendPacket(
                      wifiConnectInfo: WiFiConnectInfo(
                          ssid: wifiToConnectWiFiData.name,
                          password: passwordToConnectString));
                  await writeData(wifi, ch);
                  bool breakout = false;
                  while (!breakout) {
                    BLESendPacket wifi = BLESendPacket(
                        getWiFiConnectState: GetWiFiConnectState());
                    await writeData(wifi, ch);
                    var txt = await readData(ch);
                    WiFiConnectResponseInfo response =
                        WiFiConnectResponseInfo.fromBuffer(txt);
                    if (!mounted) {
                      return;
                    }

                    if (response.whichType() ==
                        WiFiConnectResponseInfo_Type.connectedToWiFi) {
                      isConnectedToWiFi = true;
                      breakout = true;
                      setState(() {
                        curState = HubState.registerDevice;
                      });
                    } else if (response.whichType() ==
                        WiFiConnectResponseInfo_Type.timeout) {
                      const snackBar = SnackBar(
                        content: Text(
                            'Your attempted WiFi connection timed out. Please check the WiFi name and password'),
                      );
                      if (!mounted) {
                        return;
                      }
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      wifiToConnect = Completer<WiFiData>();
                      passwordToConnect = Completer<String>();
                      breakout = true;
                      if (!mounted) {
                        return;
                      }

                      setState(() {
                        isConnectingToWiFi = false;
                      });
                    }
                  }
                }
                isAvailable = true;
              }
            } else {
              if (!mounted) {
                return;
              }
              setState(() {
                curState = HubState.networkError;
              });
              isAvailable = true;
            }
          });
        } on NetworkError {
          if (!mounted) {
            return;
          }
          setState(() {
            curState = HubState.networkError;
          });
        } on UserCancelledDialogError {
          if (!mounted) {
            return;
          }
          setState(() {
            curState = HubState.cancelled;
          });
        } on DeviceNotFoundError {
          if (!mounted) {
            return;
          }
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
          title: getTitle(curState),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20),
      ),
    );
  }

  Widget getView(HubState curState) {
    switch (curState) {
      case HubState.findHubs:
        return const Center(child: LinearProgressIndicator());
      case HubState.selectWiFi:
        return SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: wifiList
                    .mapIndexed((index, e) => SelectWiFi(
                          key: ValueKey(e),
                          wifi: e,
                          shouldDisplayPassword: currentlySelected == index,
                          isConnecting: isConnectingToWiFi,
                          onWifiTap: (WiFiData wifi) {
                            setState(() {
                              currentlySelected = index;
                            });
                          },
                          onButtonTap: (WiFiData wifi, String password) {
                            setState(() {
                              isConnectingToWiFi = true;
                            });
                            wifiToConnect.complete(wifi);
                            passwordToConnect.complete(password);
                          },
                        ))
                    .toList()));
      case HubState.registerDevice:
        return const Text("");

      case HubState.notSupported:
        return const Text(
            "Your browser does not support WebBluetooth on your platform");
      case HubState.aboutToConnect:
        return const Center(child: CircularProgressIndicator());
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

  Widget getTitle(HubState curState) {
    switch (curState) {
      case HubState.findHubs:
        return const Text("Finding hubs...");
      case HubState.selectWiFi:
        return const Text("Select WiFi...");
      case HubState.registerDevice:
        return const Text("Registering Device");

      case HubState.notSupported:
        return const Text("Error");
      case HubState.aboutToConnect:
        return const Text("Connecting...");
      case HubState.notAvailable:
        return const Text("Error");
      case HubState.cancelled:
        return const Text("Error");
      case HubState.deviceNotFound:
        return const Text("Error");
      case HubState.lostConnection:
        return const Text("Error");
      case HubState.networkError:
        return const Text("Error");
      case HubState.cannotCommunicate:
        return const Text("Error");
      case HubState.assertionError:
        return const Text("Error");
    }
  }

  Future<List<int>> waitForData(BluetoothCharacteristic read) async {
    List<int> data = [0, 0, 0, 0];

    ByteData? bd;
    while (const DeepCollectionEquality().equals(data, [0, 0, 0, 0])) {
      bd = await read.readValue();
      data = bd.buffer.asUint8List();
    }

    if (bd == null) {
      return Uint8List(0);
    } else {
      return bd.buffer.asUint8List();
    }
  }
}

enum HubState {
  findHubs,
  selectWiFi,
  registerDevice,
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
  @override
  bool operator ==(Object other) {
    return other is WiFiData && hashCode == other.hashCode;
  }

  @override
  int get hashCode => hashValues(name, bssid, isEncrypted, channel);
}

Uint8List int32LittleEndianBytes(int value) =>
    Uint8List(4)..buffer.asByteData().setInt32(0, value, Endian.little);

Future<List<int>> readData(BluetoothCharacteristic ch) async {
  var b = BytesBuilder();

  int sizeOfWifiData =
      (await ch.readValue()).buffer.asByteData().getUint32(0, Endian.little);

  while (b.length < sizeOfWifiData) {
    b.add((await ch.readValue()).buffer.asInt8List());
  }
  return b.toBytes();
}

Future<void> writeData(dynamic data, BluetoothCharacteristic ch) async {
  Uint8List protobufData = data.writeToBuffer();
  Uint8List size = int32LittleEndianBytes(protobufData.length);
  var b = BytesBuilder();
  b.add(size);
  b.add(protobufData);
  await ch.writeValueWithoutResponse(Uint8List.fromList(b.toBytes()));
}
