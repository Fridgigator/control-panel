///
//  Generated code. Do not modify.
//  source: FirmwareBackend.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use firmwareToBackendPacketDescriptor instead')
const FirmwareToBackendPacket$json = const {
  '1': 'FirmwareToBackendPacket',
  '2': const [
    const {'1': 'sensor_data', '3': 2, '4': 1, '5': 11, '6': '.SensorData', '9': 0, '10': 'sensorData'},
    const {'1': 'sensors_list', '3': 17, '4': 1, '5': 11, '6': '.SensorsList', '9': 0, '10': 'sensorsList'},
    const {'1': 'registration', '3': 18, '4': 1, '5': 11, '6': '.Registration', '9': 0, '10': 'registration'},
  ],
  '8': const [
    const {'1': 'type'},
  ],
};

/// Descriptor for `FirmwareToBackendPacket`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List firmwareToBackendPacketDescriptor = $convert.base64Decode('ChdGaXJtd2FyZVRvQmFja2VuZFBhY2tldBIuCgtzZW5zb3JfZGF0YRgCIAEoCzILLlNlbnNvckRhdGFIAFIKc2Vuc29yRGF0YRIxCgxzZW5zb3JzX2xpc3QYESABKAsyDC5TZW5zb3JzTGlzdEgAUgtzZW5zb3JzTGlzdBIzCgxyZWdpc3RyYXRpb24YEiABKAsyDS5SZWdpc3RyYXRpb25IAFIMcmVnaXN0cmF0aW9uQgYKBHR5cGU=');
@$core.Deprecated('Use uUIDDescriptor instead')
const UUID$json = const {
  '1': 'UUID',
  '2': const [
    const {'1': 'uuid', '3': 1, '4': 1, '5': 9, '8': const {}, '10': 'uuid'},
  ],
};

/// Descriptor for `UUID`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uUIDDescriptor = $convert.base64Decode('CgRVVUlEEhkKBHV1aWQYASABKAlCBZI/AnAkUgR1dWlk');
@$core.Deprecated('Use registrationDescriptor instead')
const Registration$json = const {
  '1': 'Registration',
  '2': const [
    const {'1': 'uuid_self', '3': 1, '4': 1, '5': 11, '6': '.UUID', '10': 'uuidSelf'},
    const {'1': 'uuid_user', '3': 2, '4': 1, '5': 11, '6': '.UUID', '10': 'uuidUser'},
  ],
};

/// Descriptor for `Registration`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registrationDescriptor = $convert.base64Decode('CgxSZWdpc3RyYXRpb24SIgoJdXVpZF9zZWxmGAEgASgLMgUuVVVJRFIIdXVpZFNlbGYSIgoJdXVpZF91c2VyGAIgASgLMgUuVVVJRFIIdXVpZFVzZXI=');
@$core.Deprecated('Use sensorsStartDescriptor instead')
const SensorsStart$json = const {
  '1': 'SensorsStart',
};

/// Descriptor for `SensorsStart`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sensorsStartDescriptor = $convert.base64Decode('CgxTZW5zb3JzU3RhcnQ=');
@$core.Deprecated('Use sensorsStopDescriptor instead')
const SensorsStop$json = const {
  '1': 'SensorsStop',
};

/// Descriptor for `SensorsStop`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sensorsStopDescriptor = $convert.base64Decode('CgtTZW5zb3JzU3RvcA==');
@$core.Deprecated('Use sensorsListDescriptor instead')
const SensorsList$json = const {
  '1': 'SensorsList',
  '2': const [
    const {'1': 'sensor_info', '3': 1, '4': 3, '5': 11, '6': '.SensorInfo', '8': const {}, '10': 'sensorInfo'},
  ],
};

/// Descriptor for `SensorsList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sensorsListDescriptor = $convert.base64Decode('CgtTZW5zb3JzTGlzdBIzCgtzZW5zb3JfaW5mbxgBIAMoCzILLlNlbnNvckluZm9CBZI/AhBAUgpzZW5zb3JJbmZv');
@$core.Deprecated('Use sensorInfoDescriptor instead')
const SensorInfo$json = const {
  '1': 'SensorInfo',
  '2': const [
    const {'1': 'uuid_name', '3': 1, '4': 1, '5': 11, '6': '.UUID', '10': 'uuidName'},
    const {'1': 'recognized', '3': 2, '4': 1, '5': 8, '10': 'recognized'},
    const {'1': 'sensor_type', '3': 3, '4': 1, '5': 14, '6': '.SensorInfo.SENSOR_TYPE', '10': 'sensorType'},
  ],
  '4': const [SensorInfo_SENSOR_TYPE$json],
};

@$core.Deprecated('Use sensorInfoDescriptor instead')
const SensorInfo_SENSOR_TYPE$json = const {
  '1': 'SENSOR_TYPE',
  '2': const [
    const {'1': 'PICO', '2': 0},
    const {'1': 'LPSTK', '2': 1},
    const {'1': 'NORDIC_THINGY', '2': 2},
  ],
};

/// Descriptor for `SensorInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sensorInfoDescriptor = $convert.base64Decode('CgpTZW5zb3JJbmZvEiIKCXV1aWRfbmFtZRgBIAEoCzIFLlVVSURSCHV1aWROYW1lEh4KCnJlY29nbml6ZWQYAiABKAhSCnJlY29nbml6ZWQSOAoLc2Vuc29yX3R5cGUYAyABKA4yFy5TZW5zb3JJbmZvLlNFTlNPUl9UWVBFUgpzZW5zb3JUeXBlIjUKC1NFTlNPUl9UWVBFEggKBFBJQ08QABIJCgVMUFNUSxABEhEKDU5PUkRJQ19USElOR1kQAg==');
@$core.Deprecated('Use sensorDataDescriptor instead')
const SensorData$json = const {
  '1': 'SensorData',
  '2': const [
    const {'1': 'origin_uuid', '3': 1, '4': 1, '5': 11, '6': '.UUID', '10': 'originUuid'},
    const {'1': 'middle_uuids', '3': 2, '4': 3, '5': 11, '6': '.UUID', '8': const {}, '10': 'middleUuids'},
    const {'1': 'temp', '3': 3, '4': 1, '5': 2, '9': 0, '10': 'temp'},
    const {'1': 'humidity', '3': 4, '4': 1, '5': 2, '9': 0, '10': 'humidity'},
  ],
  '8': const [
    const {'1': 'type'},
  ],
};

/// Descriptor for `SensorData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sensorDataDescriptor = $convert.base64Decode('CgpTZW5zb3JEYXRhEiYKC29yaWdpbl91dWlkGAEgASgLMgUuVVVJRFIKb3JpZ2luVXVpZBIvCgxtaWRkbGVfdXVpZHMYAiADKAsyBS5VVUlEQgWSPwIQQFILbWlkZGxlVXVpZHMSFAoEdGVtcBgDIAEoAkgAUgR0ZW1wEhwKCGh1bWlkaXR5GAQgASgCSABSCGh1bWlkaXR5QgYKBHR5cGU=');
@$core.Deprecated('Use backendToFirmwarePacketDescriptor instead')
const BackendToFirmwarePacket$json = const {
  '1': 'BackendToFirmwarePacket',
  '2': const [
    const {'1': 'get_sensors_list', '3': 1, '4': 1, '5': 11, '6': '.GetSensorsList', '9': 0, '10': 'getSensorsList'},
    const {'1': 'get_data', '3': 2, '4': 1, '5': 11, '6': '.GetData', '9': 0, '10': 'getData'},
    const {'1': 'add_sensor', '3': 3, '4': 1, '5': 11, '6': '.AddSensor', '9': 0, '10': 'addSensor'},
  ],
  '8': const [
    const {'1': 'type'},
  ],
};

/// Descriptor for `BackendToFirmwarePacket`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List backendToFirmwarePacketDescriptor = $convert.base64Decode('ChdCYWNrZW5kVG9GaXJtd2FyZVBhY2tldBI7ChBnZXRfc2Vuc29yc19saXN0GAEgASgLMg8uR2V0U2Vuc29yc0xpc3RIAFIOZ2V0U2Vuc29yc0xpc3QSJQoIZ2V0X2RhdGEYAiABKAsyCC5HZXREYXRhSABSB2dldERhdGESKwoKYWRkX3NlbnNvchgDIAEoCzIKLkFkZFNlbnNvckgAUglhZGRTZW5zb3JCBgoEdHlwZQ==');
@$core.Deprecated('Use getSensorsListDescriptor instead')
const GetSensorsList$json = const {
  '1': 'GetSensorsList',
};

/// Descriptor for `GetSensorsList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSensorsListDescriptor = $convert.base64Decode('Cg5HZXRTZW5zb3JzTGlzdA==');
@$core.Deprecated('Use getDataDescriptor instead')
const GetData$json = const {
  '1': 'GetData',
};

/// Descriptor for `GetData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDataDescriptor = $convert.base64Decode('CgdHZXREYXRh');
@$core.Deprecated('Use addSensorDescriptor instead')
const AddSensor$json = const {
  '1': 'AddSensor',
  '2': const [
    const {'1': 'sensor_uuid', '3': 1, '4': 1, '5': 11, '6': '.UUID', '10': 'sensorUuid'},
  ],
};

/// Descriptor for `AddSensor`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addSensorDescriptor = $convert.base64Decode('CglBZGRTZW5zb3ISJgoLc2Vuc29yX3V1aWQYASABKAsyBS5VVUlEUgpzZW5zb3JVdWlk');
