///
//  Generated code. Do not modify.
//  source: packet.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use packetDescriptor instead')
const Packet$json = const {
  '1': 'Packet',
  '2': const [
    const {'1': 'placeholder', '3': 1, '4': 1, '5': 11, '6': '.Placeholder', '9': 0, '10': 'placeholder'},
    const {'1': 'ack', '3': 2, '4': 1, '5': 11, '6': '.Ack', '9': 0, '10': 'ack'},
    const {'1': 'eot', '3': 3, '4': 1, '5': 11, '6': '.EndOfTransmission', '9': 0, '10': 'eot'},
    const {'1': 'wifi', '3': 4, '4': 1, '5': 11, '6': '.WiFiVector', '9': 0, '10': 'wifi'},
    const {'1': 'getWifi', '3': 5, '4': 1, '5': 11, '6': '.GetWiFi', '9': 0, '10': 'getWifi'},
  ],
  '8': const [
    const {'1': 'type'},
  ],
};

/// Descriptor for `Packet`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List packetDescriptor = $convert.base64Decode('CgZQYWNrZXQSMAoLcGxhY2Vob2xkZXIYASABKAsyDC5QbGFjZWhvbGRlckgAUgtwbGFjZWhvbGRlchIYCgNhY2sYAiABKAsyBC5BY2tIAFIDYWNrEiYKA2VvdBgDIAEoCzISLkVuZE9mVHJhbnNtaXNzaW9uSABSA2VvdBIhCgR3aWZpGAQgASgLMgsuV2lGaVZlY3RvckgAUgR3aWZpEiQKB2dldFdpZmkYBSABKAsyCC5HZXRXaUZpSABSB2dldFdpZmlCBgoEdHlwZQ==');
@$core.Deprecated('Use placeholderDescriptor instead')
const Placeholder$json = const {
  '1': 'Placeholder',
};

/// Descriptor for `Placeholder`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List placeholderDescriptor = $convert.base64Decode('CgtQbGFjZWhvbGRlcg==');
@$core.Deprecated('Use ackDescriptor instead')
const Ack$json = const {
  '1': 'Ack',
};

/// Descriptor for `Ack`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List ackDescriptor = $convert.base64Decode('CgNBY2s=');
@$core.Deprecated('Use endOfTransmissionDescriptor instead')
const EndOfTransmission$json = const {
  '1': 'EndOfTransmission',
};

/// Descriptor for `EndOfTransmission`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List endOfTransmissionDescriptor = $convert.base64Decode('ChFFbmRPZlRyYW5zbWlzc2lvbg==');
@$core.Deprecated('Use getWiFiDescriptor instead')
const GetWiFi$json = const {
  '1': 'GetWiFi',
};

/// Descriptor for `GetWiFi`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWiFiDescriptor = $convert.base64Decode('CgdHZXRXaUZp');
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
    const {'1': 'SSID', '3': 1, '4': 1, '5': 9, '8': const {}, '10': 'SSID'},
    const {'1': 'BSSID', '3': 2, '4': 1, '5': 4, '10': 'BSSID'},
    const {'1': 'Channel', '3': 3, '4': 1, '5': 13, '10': 'Channel'},
    const {'1': 'isEncrypted', '3': 4, '4': 1, '5': 8, '10': 'isEncrypted'},
  ],
};

/// Descriptor for `WiFiData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List wiFiDataDescriptor = $convert.base64Decode('CghXaUZpRGF0YRIZCgRTU0lEGAEgASgJQgWSPwIID1IEU1NJRBIUCgVCU1NJRBgCIAEoBFIFQlNTSUQSGAoHQ2hhbm5lbBgDIAEoDVIHQ2hhbm5lbBIgCgtpc0VuY3J5cHRlZBgEIAEoCFILaXNFbmNyeXB0ZWQ=');
