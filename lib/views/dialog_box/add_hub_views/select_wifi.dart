import 'package:flutter/material.dart';

import '../add_hub.dart';

class SelectWiFi extends StatefulWidget {
  final WiFiData wifi;

  final Function(WiFiData wifi) onWifiTap;
  final Function(WiFiData wifi, String password) onButtonTap;
  final bool shouldDisplayPassword;
  final bool isConnecting;
  const SelectWiFi(
      {Key? key,
      required this.wifi,
      required this.onWifiTap,
      required this.onButtonTap,
      required this.isConnecting,
      required this.shouldDisplayPassword})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SelectWiFiState();
}

class _SelectWiFiState extends State<SelectWiFi> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      Text(
        widget.wifi.name,
        textAlign: TextAlign.start,
        overflow: TextOverflow.clip,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontSize: 14,
        ),
      )
    ];
    if (widget.shouldDisplayPassword) {
      children.add(Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
              width: 300,
              child: TextField(
                controller: controller,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                obscuringCharacter: "*",
                decoration: const InputDecoration(
                  hintText: "Enter password",
                  suffixIcon: Icon(Icons.lock),
                ),
              )),
          !widget.isConnecting
              ? MaterialButton(
                  child: const Text("Connect"),
                  onPressed: () =>
                      widget.onButtonTap(widget.wifi, controller.text),
                )
              : const MaterialButton(
                  onPressed: null, child: Text("Connecting...")),
        ],
      ));
    }
    return InkWell(
        onTap: widget.shouldDisplayPassword
            ? null
            : () {
                widget.onWifiTap(widget.wifi);
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
                      widget.wifi.isEncrypted == true
                          ? Icons.wifi_lock
                          : Icons.wifi,
                      size: 24,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: children,
                  )
                ])));
  }
}
