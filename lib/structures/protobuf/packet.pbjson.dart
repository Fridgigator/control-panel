///
//  Generated code. Do not modify.
//  source: packet.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use bLESendPacketDescriptor instead')
const BLESendPacket$json = const {
  '1': 'BLESendPacket',
  '2': const [
    const {'1': 'placeholder', '3': 1, '4': 1, '5': 11, '6': '.Placeholder', '9': 0, '10': 'placeholder'},
    const {'1': 'getWifi', '3': 2, '4': 1, '5': 11, '6': '.GetWiFi', '9': 0, '10': 'getWifi'},
    const {'1': 'wifiConnectInfo', '3': 3, '4': 1, '5': 11, '6': '.WiFiConnectInfo', '9': 0, '10': 'wifiConnectInfo'},
    const {'1': 'getWiFiConnectState', '3': 4, '4': 1, '5': 11, '6': '.GetWiFiConnectState', '9': 0, '10': 'getWiFiConnectState'},
    const {'1': 'nonce', '3': 5, '4': 1, '5': 11, '6': '.RegisterNonce', '9': 0, '10': 'nonce'},
  ],
  '8': const [
    const {'1': 'type'},
  ],
};

/// Descriptor for `BLESendPacket`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bLESendPacketDescriptor = $convert.base64Decode('Cg1CTEVTZW5kUGFja2V0EjAKC3BsYWNlaG9sZGVyGAEgASgLMgwuUGxhY2Vob2xkZXJIAFILcGxhY2Vob2xkZXISJAoHZ2V0V2lmaRgCIAEoCzIILkdldFdpRmlIAFIHZ2V0V2lmaRI8Cg93aWZpQ29ubmVjdEluZm8YAyABKAsyEC5XaUZpQ29ubmVjdEluZm9IAFIPd2lmaUNvbm5lY3RJbmZvEkgKE2dldFdpRmlDb25uZWN0U3RhdGUYBCABKAsyFC5HZXRXaUZpQ29ubmVjdFN0YXRlSABSE2dldFdpRmlDb25uZWN0U3RhdGUSJgoFbm9uY2UYBSABKAsyDi5SZWdpc3Rlck5vbmNlSABSBW5vbmNlQgYKBHR5cGU=');
@$core.Deprecated('Use placeholderDescriptor instead')
const Placeholder$json = const {
  '1': 'Placeholder',
};

/// Descriptor for `Placeholder`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List placeholderDescriptor = $convert.base64Decode('CgtQbGFjZWhvbGRlcg==');
@$core.Deprecated('Use getWiFiDescriptor instead')
const GetWiFi$json = const {
  '1': 'GetWiFi',
};

/// Descriptor for `GetWiFi`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWiFiDescriptor = $convert.base64Decode('CgdHZXRXaUZp');
@$core.Deprecated('Use wiFiConnectInfoDescriptor instead')
const WiFiConnectInfo$json = const {
  '1': 'WiFiConnectInfo',
  '2': const [
    const {'1': 'ssid', '3': 1, '4': 1, '5': 9, '8': const {}, '10': 'ssid'},
    const {'1': 'password', '3': 2, '4': 1, '5': 9, '8': const {}, '10': 'password'},
  ],
};

/// Descriptor for `WiFiConnectInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List wiFiConnectInfoDescriptor = $convert.base64Decode('Cg9XaUZpQ29ubmVjdEluZm8SGQoEc3NpZBgBIAEoCUIFkj8CCCBSBHNzaWQSIQoIcGFzc3dvcmQYAiABKAlCBZI/AghAUghwYXNzd29yZA==');
@$core.Deprecated('Use getWiFiConnectStateDescriptor instead')
const GetWiFiConnectState$json = const {
  '1': 'GetWiFiConnectState',
};

/// Descriptor for `GetWiFiConnectState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWiFiConnectStateDescriptor = $convert.base64Decode('ChNHZXRXaUZpQ29ubmVjdFN0YXRl');
@$core.Deprecated('Use registerNonceDescriptor instead')
const RegisterNonce$json = const {
  '1': 'RegisterNonce',
  '2': const [
    const {'1': 'nonce', '3': 1, '4': 1, '5': 9, '8': const {}, '10': 'nonce'},
  ],
};

/// Descriptor for `RegisterNonce`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerNonceDescriptor = $convert.base64Decode('Cg1SZWdpc3Rlck5vbmNlEhsKBW5vbmNlGAEgASgJQgWSPwIIEFIFbm9uY2U=');
@$core.Deprecated('Use wiFiVectorDescriptor instead')
const WiFiVector$json = const {
  '1': 'WiFiVector',
  '2': const [
    const {'1': 'data', '3': 1, '4': 3, '5': 11, '6': '.WiFiData', '8': const {}, '10': 'data'},
  ],
};

/// Descriptor for `WiFiVector`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List wiFiVectorDescriptor = $convert.base64Decode('CgpXaUZpVmVjdG9yEiQKBGRhdGEYASADKAsyCS5XaUZpRGF0YUIFkj8CEEBSBGRhdGE=');
@$core.Deprecated('Use wiFiDataDescriptor instead')
const WiFiData$json = const {
  '1': 'WiFiData',
  '2': const [
    const {'1': 'ssid', '3': 1, '4': 1, '5': 9, '8': const {}, '10': 'ssid'},
    const {'1': 'bssid', '3': 2, '4': 1, '5': 4, '10': 'bssid'},
    const {'1': 'Channel', '3': 3, '4': 1, '5': 13, '10': 'Channel'},
    const {'1': 'isEncrypted', '3': 4, '4': 1, '5': 8, '10': 'isEncrypted'},
  ],
};

/// Descriptor for `WiFiData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List wiFiDataDescriptor = $convert.base64Decode('CghXaUZpRGF0YRIZCgRzc2lkGAEgASgJQgWSPwIIIFIEc3NpZBIUCgVic3NpZBgCIAEoBFIFYnNzaWQSGAoHQ2hhbm5lbBgDIAEoDVIHQ2hhbm5lbBIgCgtpc0VuY3J5cHRlZBgEIAEoCFILaXNFbmNyeXB0ZWQ=');
@$core.Deprecated('Use wiFiConnectResponseInfoDescriptor instead')
const WiFiConnectResponseInfo$json = const {
  '1': 'WiFiConnectResponseInfo',
  '2': const [
    const {'1': 'placeholder', '3': 1, '4': 1, '5': 11, '6': '.Placeholder', '9': 0, '10': 'placeholder'},
    const {'1': 'timeout', '3': 2, '4': 1, '5': 11, '6': '.Timeout', '9': 0, '10': 'timeout'},
    const {'1': 'connectingToWiFi', '3': 3, '4': 1, '5': 11, '6': '.ConnectingToWiFi', '9': 0, '10': 'connectingToWiFi'},
    const {'1': 'connectedToWiFi', '3': 4, '4': 1, '5': 11, '6': '.ConnectedToWiFi', '9': 0, '10': 'connectedToWiFi'},
    const {'1': 'connectingToServer', '3': 5, '4': 1, '5': 11, '6': '.ConnectingToServer', '9': 0, '10': 'connectingToServer'},
    const {'1': 'failedConnectingToServer', '3': 6, '4': 1, '5': 11, '6': '.FailedConnectingToServer', '9': 0, '10': 'failedConnectingToServer'},
  ],
  '8': const [
    const {'1': 'type'},
  ],
};

/// Descriptor for `WiFiConnectResponseInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List wiFiConnectResponseInfoDescriptor = $convert.base64Decode('ChdXaUZpQ29ubmVjdFJlc3BvbnNlSW5mbxIwCgtwbGFjZWhvbGRlchgBIAEoCzIMLlBsYWNlaG9sZGVySABSC3BsYWNlaG9sZGVyEiQKB3RpbWVvdXQYAiABKAsyCC5UaW1lb3V0SABSB3RpbWVvdXQSPwoQY29ubmVjdGluZ1RvV2lGaRgDIAEoCzIRLkNvbm5lY3RpbmdUb1dpRmlIAFIQY29ubmVjdGluZ1RvV2lGaRI8Cg9jb25uZWN0ZWRUb1dpRmkYBCABKAsyEC5Db25uZWN0ZWRUb1dpRmlIAFIPY29ubmVjdGVkVG9XaUZpEkUKEmNvbm5lY3RpbmdUb1NlcnZlchgFIAEoCzITLkNvbm5lY3RpbmdUb1NlcnZlckgAUhJjb25uZWN0aW5nVG9TZXJ2ZXISVwoYZmFpbGVkQ29ubmVjdGluZ1RvU2VydmVyGAYgASgLMhkuRmFpbGVkQ29ubmVjdGluZ1RvU2VydmVySABSGGZhaWxlZENvbm5lY3RpbmdUb1NlcnZlckIGCgR0eXBl');
@$core.Deprecated('Use timeoutDescriptor instead')
const Timeout$json = const {
  '1': 'Timeout',
};

/// Descriptor for `Timeout`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List timeoutDescriptor = $convert.base64Decode('CgdUaW1lb3V0');
@$core.Deprecated('Use connectingToWiFiDescriptor instead')
const ConnectingToWiFi$json = const {
  '1': 'ConnectingToWiFi',
};

/// Descriptor for `ConnectingToWiFi`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List connectingToWiFiDescriptor = $convert.base64Decode('ChBDb25uZWN0aW5nVG9XaUZp');
@$core.Deprecated('Use connectedToWiFiDescriptor instead')
const ConnectedToWiFi$json = const {
  '1': 'ConnectedToWiFi',
};

/// Descriptor for `ConnectedToWiFi`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List connectedToWiFiDescriptor = $convert.base64Decode('Cg9Db25uZWN0ZWRUb1dpRmk=');
@$core.Deprecated('Use connectingToServerDescriptor instead')
const ConnectingToServer$json = const {
  '1': 'ConnectingToServer',
};

/// Descriptor for `ConnectingToServer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List connectingToServerDescriptor = $convert.base64Decode('ChJDb25uZWN0aW5nVG9TZXJ2ZXI=');
@$core.Deprecated('Use failedConnectingToServerDescriptor instead')
const FailedConnectingToServer$json = const {
  '1': 'FailedConnectingToServer',
  '2': const [
    const {'1': 'causeid', '3': 1, '4': 1, '5': 5, '10': 'causeid'},
    const {'1': 'cause', '3': 2, '4': 1, '5': 9, '8': const {}, '10': 'cause'},
  ],
};

/// Descriptor for `FailedConnectingToServer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List failedConnectingToServerDescriptor = $convert.base64Decode('ChhGYWlsZWRDb25uZWN0aW5nVG9TZXJ2ZXISGAoHY2F1c2VpZBgBIAEoBVIHY2F1c2VpZBIbCgVjYXVzZRgCIAEoCUIFkj8CCCBSBWNhdXNl');
