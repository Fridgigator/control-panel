///
//  Generated code. Do not modify.
//  source: FirmwareBackend.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class SensorInfo_SENSOR_TYPE extends $pb.ProtobufEnum {
  static const SensorInfo_SENSOR_TYPE PICO = SensorInfo_SENSOR_TYPE._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PICO');
  static const SensorInfo_SENSOR_TYPE LPSTK = SensorInfo_SENSOR_TYPE._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LPSTK');
  static const SensorInfo_SENSOR_TYPE NORDIC_THINGY = SensorInfo_SENSOR_TYPE._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NORDIC_THINGY');

  static const $core.List<SensorInfo_SENSOR_TYPE> values = <SensorInfo_SENSOR_TYPE> [
    PICO,
    LPSTK,
    NORDIC_THINGY,
  ];

  static final $core.Map<$core.int, SensorInfo_SENSOR_TYPE> _byValue = $pb.ProtobufEnum.initByValue(values);
  static SensorInfo_SENSOR_TYPE? valueOf($core.int value) => _byValue[value];

  const SensorInfo_SENSOR_TYPE._($core.int v, $core.String n) : super(v, n);
}

