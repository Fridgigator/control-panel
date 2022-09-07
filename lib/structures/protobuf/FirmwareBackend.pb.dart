///
//  Generated code. Do not modify.
//  source: FirmwareBackend.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'FirmwareBackend.pbenum.dart';

export 'FirmwareBackend.pbenum.dart';

enum FirmwareToBackendPacket_Type {
  sensorData, 
  sensorsList, 
  registration, 
  notSet
}

class FirmwareToBackendPacket extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, FirmwareToBackendPacket_Type> _FirmwareToBackendPacket_TypeByTag = {
    2 : FirmwareToBackendPacket_Type.sensorData,
    17 : FirmwareToBackendPacket_Type.sensorsList,
    18 : FirmwareToBackendPacket_Type.registration,
    0 : FirmwareToBackendPacket_Type.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FirmwareToBackendPacket', createEmptyInstance: create)
    ..oo(0, [2, 17, 18])
    ..aOM<SensorData>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sensorData', subBuilder: SensorData.create)
    ..aOM<SensorsList>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sensorsList', subBuilder: SensorsList.create)
    ..aOM<Registration>(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'registration', subBuilder: Registration.create)
    ..hasRequiredFields = false
  ;

  FirmwareToBackendPacket._() : super();
  factory FirmwareToBackendPacket({
    SensorData? sensorData,
    SensorsList? sensorsList,
    Registration? registration,
  }) {
    final _result = create();
    if (sensorData != null) {
      _result.sensorData = sensorData;
    }
    if (sensorsList != null) {
      _result.sensorsList = sensorsList;
    }
    if (registration != null) {
      _result.registration = registration;
    }
    return _result;
  }
  factory FirmwareToBackendPacket.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FirmwareToBackendPacket.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FirmwareToBackendPacket clone() => FirmwareToBackendPacket()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FirmwareToBackendPacket copyWith(void Function(FirmwareToBackendPacket) updates) => super.copyWith((message) => updates(message as FirmwareToBackendPacket)) as FirmwareToBackendPacket; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FirmwareToBackendPacket create() => FirmwareToBackendPacket._();
  FirmwareToBackendPacket createEmptyInstance() => create();
  static $pb.PbList<FirmwareToBackendPacket> createRepeated() => $pb.PbList<FirmwareToBackendPacket>();
  @$core.pragma('dart2js:noInline')
  static FirmwareToBackendPacket getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FirmwareToBackendPacket>(create);
  static FirmwareToBackendPacket? _defaultInstance;

  FirmwareToBackendPacket_Type whichType() => _FirmwareToBackendPacket_TypeByTag[$_whichOneof(0)]!;
  void clearType() => clearField($_whichOneof(0));

  @$pb.TagNumber(2)
  SensorData get sensorData => $_getN(0);
  @$pb.TagNumber(2)
  set sensorData(SensorData v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasSensorData() => $_has(0);
  @$pb.TagNumber(2)
  void clearSensorData() => clearField(2);
  @$pb.TagNumber(2)
  SensorData ensureSensorData() => $_ensure(0);

  @$pb.TagNumber(17)
  SensorsList get sensorsList => $_getN(1);
  @$pb.TagNumber(17)
  set sensorsList(SensorsList v) { setField(17, v); }
  @$pb.TagNumber(17)
  $core.bool hasSensorsList() => $_has(1);
  @$pb.TagNumber(17)
  void clearSensorsList() => clearField(17);
  @$pb.TagNumber(17)
  SensorsList ensureSensorsList() => $_ensure(1);

  @$pb.TagNumber(18)
  Registration get registration => $_getN(2);
  @$pb.TagNumber(18)
  set registration(Registration v) { setField(18, v); }
  @$pb.TagNumber(18)
  $core.bool hasRegistration() => $_has(2);
  @$pb.TagNumber(18)
  void clearRegistration() => clearField(18);
  @$pb.TagNumber(18)
  Registration ensureRegistration() => $_ensure(2);
}

class UUID extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UUID', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uuid')
    ..hasRequiredFields = false
  ;

  UUID._() : super();
  factory UUID({
    $core.String? uuid,
  }) {
    final _result = create();
    if (uuid != null) {
      _result.uuid = uuid;
    }
    return _result;
  }
  factory UUID.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UUID.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UUID clone() => UUID()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UUID copyWith(void Function(UUID) updates) => super.copyWith((message) => updates(message as UUID)) as UUID; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UUID create() => UUID._();
  UUID createEmptyInstance() => create();
  static $pb.PbList<UUID> createRepeated() => $pb.PbList<UUID>();
  @$core.pragma('dart2js:noInline')
  static UUID getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UUID>(create);
  static UUID? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get uuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set uuid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearUuid() => clearField(1);
}

class Registration extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Registration', createEmptyInstance: create)
    ..aOM<UUID>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uuidSelf', subBuilder: UUID.create)
    ..aOM<UUID>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uuidUser', subBuilder: UUID.create)
    ..hasRequiredFields = false
  ;

  Registration._() : super();
  factory Registration({
    UUID? uuidSelf,
    UUID? uuidUser,
  }) {
    final _result = create();
    if (uuidSelf != null) {
      _result.uuidSelf = uuidSelf;
    }
    if (uuidUser != null) {
      _result.uuidUser = uuidUser;
    }
    return _result;
  }
  factory Registration.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Registration.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Registration clone() => Registration()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Registration copyWith(void Function(Registration) updates) => super.copyWith((message) => updates(message as Registration)) as Registration; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Registration create() => Registration._();
  Registration createEmptyInstance() => create();
  static $pb.PbList<Registration> createRepeated() => $pb.PbList<Registration>();
  @$core.pragma('dart2js:noInline')
  static Registration getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Registration>(create);
  static Registration? _defaultInstance;

  @$pb.TagNumber(1)
  UUID get uuidSelf => $_getN(0);
  @$pb.TagNumber(1)
  set uuidSelf(UUID v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUuidSelf() => $_has(0);
  @$pb.TagNumber(1)
  void clearUuidSelf() => clearField(1);
  @$pb.TagNumber(1)
  UUID ensureUuidSelf() => $_ensure(0);

  @$pb.TagNumber(2)
  UUID get uuidUser => $_getN(1);
  @$pb.TagNumber(2)
  set uuidUser(UUID v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasUuidUser() => $_has(1);
  @$pb.TagNumber(2)
  void clearUuidUser() => clearField(2);
  @$pb.TagNumber(2)
  UUID ensureUuidUser() => $_ensure(1);
}

class SensorsStart extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SensorsStart', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  SensorsStart._() : super();
  factory SensorsStart() => create();
  factory SensorsStart.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SensorsStart.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SensorsStart clone() => SensorsStart()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SensorsStart copyWith(void Function(SensorsStart) updates) => super.copyWith((message) => updates(message as SensorsStart)) as SensorsStart; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SensorsStart create() => SensorsStart._();
  SensorsStart createEmptyInstance() => create();
  static $pb.PbList<SensorsStart> createRepeated() => $pb.PbList<SensorsStart>();
  @$core.pragma('dart2js:noInline')
  static SensorsStart getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SensorsStart>(create);
  static SensorsStart? _defaultInstance;
}

class SensorsStop extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SensorsStop', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  SensorsStop._() : super();
  factory SensorsStop() => create();
  factory SensorsStop.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SensorsStop.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SensorsStop clone() => SensorsStop()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SensorsStop copyWith(void Function(SensorsStop) updates) => super.copyWith((message) => updates(message as SensorsStop)) as SensorsStop; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SensorsStop create() => SensorsStop._();
  SensorsStop createEmptyInstance() => create();
  static $pb.PbList<SensorsStop> createRepeated() => $pb.PbList<SensorsStop>();
  @$core.pragma('dart2js:noInline')
  static SensorsStop getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SensorsStop>(create);
  static SensorsStop? _defaultInstance;
}

class SensorsList extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SensorsList', createEmptyInstance: create)
    ..pc<SensorInfo>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sensorInfo', $pb.PbFieldType.PM, subBuilder: SensorInfo.create)
    ..hasRequiredFields = false
  ;

  SensorsList._() : super();
  factory SensorsList({
    $core.Iterable<SensorInfo>? sensorInfo,
  }) {
    final _result = create();
    if (sensorInfo != null) {
      _result.sensorInfo.addAll(sensorInfo);
    }
    return _result;
  }
  factory SensorsList.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SensorsList.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SensorsList clone() => SensorsList()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SensorsList copyWith(void Function(SensorsList) updates) => super.copyWith((message) => updates(message as SensorsList)) as SensorsList; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SensorsList create() => SensorsList._();
  SensorsList createEmptyInstance() => create();
  static $pb.PbList<SensorsList> createRepeated() => $pb.PbList<SensorsList>();
  @$core.pragma('dart2js:noInline')
  static SensorsList getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SensorsList>(create);
  static SensorsList? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<SensorInfo> get sensorInfo => $_getList(0);
}

class SensorInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SensorInfo', createEmptyInstance: create)
    ..aOM<UUID>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uuidName', subBuilder: UUID.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recognized')
    ..e<SensorInfo_SENSOR_TYPE>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sensorType', $pb.PbFieldType.OE, defaultOrMaker: SensorInfo_SENSOR_TYPE.PICO, valueOf: SensorInfo_SENSOR_TYPE.valueOf, enumValues: SensorInfo_SENSOR_TYPE.values)
    ..hasRequiredFields = false
  ;

  SensorInfo._() : super();
  factory SensorInfo({
    UUID? uuidName,
    $core.bool? recognized,
    SensorInfo_SENSOR_TYPE? sensorType,
  }) {
    final _result = create();
    if (uuidName != null) {
      _result.uuidName = uuidName;
    }
    if (recognized != null) {
      _result.recognized = recognized;
    }
    if (sensorType != null) {
      _result.sensorType = sensorType;
    }
    return _result;
  }
  factory SensorInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SensorInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SensorInfo clone() => SensorInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SensorInfo copyWith(void Function(SensorInfo) updates) => super.copyWith((message) => updates(message as SensorInfo)) as SensorInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SensorInfo create() => SensorInfo._();
  SensorInfo createEmptyInstance() => create();
  static $pb.PbList<SensorInfo> createRepeated() => $pb.PbList<SensorInfo>();
  @$core.pragma('dart2js:noInline')
  static SensorInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SensorInfo>(create);
  static SensorInfo? _defaultInstance;

  @$pb.TagNumber(1)
  UUID get uuidName => $_getN(0);
  @$pb.TagNumber(1)
  set uuidName(UUID v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUuidName() => $_has(0);
  @$pb.TagNumber(1)
  void clearUuidName() => clearField(1);
  @$pb.TagNumber(1)
  UUID ensureUuidName() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get recognized => $_getBF(1);
  @$pb.TagNumber(2)
  set recognized($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRecognized() => $_has(1);
  @$pb.TagNumber(2)
  void clearRecognized() => clearField(2);

  @$pb.TagNumber(3)
  SensorInfo_SENSOR_TYPE get sensorType => $_getN(2);
  @$pb.TagNumber(3)
  set sensorType(SensorInfo_SENSOR_TYPE v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasSensorType() => $_has(2);
  @$pb.TagNumber(3)
  void clearSensorType() => clearField(3);
}

enum SensorData_Type {
  temp, 
  humidity, 
  notSet
}

class SensorData extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, SensorData_Type> _SensorData_TypeByTag = {
    3 : SensorData_Type.temp,
    4 : SensorData_Type.humidity,
    0 : SensorData_Type.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SensorData', createEmptyInstance: create)
    ..oo(0, [3, 4])
    ..aOM<UUID>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'originUuid', subBuilder: UUID.create)
    ..pc<UUID>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'middleUuids', $pb.PbFieldType.PM, subBuilder: UUID.create)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'temp', $pb.PbFieldType.OF)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'humidity', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  SensorData._() : super();
  factory SensorData({
    UUID? originUuid,
    $core.Iterable<UUID>? middleUuids,
    $core.double? temp,
    $core.double? humidity,
  }) {
    final _result = create();
    if (originUuid != null) {
      _result.originUuid = originUuid;
    }
    if (middleUuids != null) {
      _result.middleUuids.addAll(middleUuids);
    }
    if (temp != null) {
      _result.temp = temp;
    }
    if (humidity != null) {
      _result.humidity = humidity;
    }
    return _result;
  }
  factory SensorData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SensorData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SensorData clone() => SensorData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SensorData copyWith(void Function(SensorData) updates) => super.copyWith((message) => updates(message as SensorData)) as SensorData; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SensorData create() => SensorData._();
  SensorData createEmptyInstance() => create();
  static $pb.PbList<SensorData> createRepeated() => $pb.PbList<SensorData>();
  @$core.pragma('dart2js:noInline')
  static SensorData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SensorData>(create);
  static SensorData? _defaultInstance;

  SensorData_Type whichType() => _SensorData_TypeByTag[$_whichOneof(0)]!;
  void clearType() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  UUID get originUuid => $_getN(0);
  @$pb.TagNumber(1)
  set originUuid(UUID v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasOriginUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearOriginUuid() => clearField(1);
  @$pb.TagNumber(1)
  UUID ensureOriginUuid() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<UUID> get middleUuids => $_getList(1);

  @$pb.TagNumber(3)
  $core.double get temp => $_getN(2);
  @$pb.TagNumber(3)
  set temp($core.double v) { $_setFloat(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTemp() => $_has(2);
  @$pb.TagNumber(3)
  void clearTemp() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get humidity => $_getN(3);
  @$pb.TagNumber(4)
  set humidity($core.double v) { $_setFloat(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasHumidity() => $_has(3);
  @$pb.TagNumber(4)
  void clearHumidity() => clearField(4);
}

enum BackendToFirmwarePacket_Type {
  getSensorsList, 
  getData, 
  addSensor, 
  notSet
}

class BackendToFirmwarePacket extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, BackendToFirmwarePacket_Type> _BackendToFirmwarePacket_TypeByTag = {
    1 : BackendToFirmwarePacket_Type.getSensorsList,
    2 : BackendToFirmwarePacket_Type.getData,
    3 : BackendToFirmwarePacket_Type.addSensor,
    0 : BackendToFirmwarePacket_Type.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BackendToFirmwarePacket', createEmptyInstance: create)
    ..oo(0, [1, 2, 3])
    ..aOM<GetSensorsList>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'getSensorsList', subBuilder: GetSensorsList.create)
    ..aOM<GetData>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'getData', subBuilder: GetData.create)
    ..aOM<AddSensor>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'addSensor', subBuilder: AddSensor.create)
    ..hasRequiredFields = false
  ;

  BackendToFirmwarePacket._() : super();
  factory BackendToFirmwarePacket({
    GetSensorsList? getSensorsList,
    GetData? getData,
    AddSensor? addSensor,
  }) {
    final _result = create();
    if (getSensorsList != null) {
      _result.getSensorsList = getSensorsList;
    }
    if (getData != null) {
      _result.getData = getData;
    }
    if (addSensor != null) {
      _result.addSensor = addSensor;
    }
    return _result;
  }
  factory BackendToFirmwarePacket.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BackendToFirmwarePacket.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BackendToFirmwarePacket clone() => BackendToFirmwarePacket()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BackendToFirmwarePacket copyWith(void Function(BackendToFirmwarePacket) updates) => super.copyWith((message) => updates(message as BackendToFirmwarePacket)) as BackendToFirmwarePacket; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BackendToFirmwarePacket create() => BackendToFirmwarePacket._();
  BackendToFirmwarePacket createEmptyInstance() => create();
  static $pb.PbList<BackendToFirmwarePacket> createRepeated() => $pb.PbList<BackendToFirmwarePacket>();
  @$core.pragma('dart2js:noInline')
  static BackendToFirmwarePacket getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BackendToFirmwarePacket>(create);
  static BackendToFirmwarePacket? _defaultInstance;

  BackendToFirmwarePacket_Type whichType() => _BackendToFirmwarePacket_TypeByTag[$_whichOneof(0)]!;
  void clearType() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  GetSensorsList get getSensorsList => $_getN(0);
  @$pb.TagNumber(1)
  set getSensorsList(GetSensorsList v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasGetSensorsList() => $_has(0);
  @$pb.TagNumber(1)
  void clearGetSensorsList() => clearField(1);
  @$pb.TagNumber(1)
  GetSensorsList ensureGetSensorsList() => $_ensure(0);

  @$pb.TagNumber(2)
  GetData get getData => $_getN(1);
  @$pb.TagNumber(2)
  set getData(GetData v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasGetData() => $_has(1);
  @$pb.TagNumber(2)
  void clearGetData() => clearField(2);
  @$pb.TagNumber(2)
  GetData ensureGetData() => $_ensure(1);

  @$pb.TagNumber(3)
  AddSensor get addSensor => $_getN(2);
  @$pb.TagNumber(3)
  set addSensor(AddSensor v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasAddSensor() => $_has(2);
  @$pb.TagNumber(3)
  void clearAddSensor() => clearField(3);
  @$pb.TagNumber(3)
  AddSensor ensureAddSensor() => $_ensure(2);
}

class GetSensorsList extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSensorsList', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetSensorsList._() : super();
  factory GetSensorsList() => create();
  factory GetSensorsList.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSensorsList.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSensorsList clone() => GetSensorsList()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSensorsList copyWith(void Function(GetSensorsList) updates) => super.copyWith((message) => updates(message as GetSensorsList)) as GetSensorsList; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSensorsList create() => GetSensorsList._();
  GetSensorsList createEmptyInstance() => create();
  static $pb.PbList<GetSensorsList> createRepeated() => $pb.PbList<GetSensorsList>();
  @$core.pragma('dart2js:noInline')
  static GetSensorsList getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSensorsList>(create);
  static GetSensorsList? _defaultInstance;
}

class GetData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetData', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetData._() : super();
  factory GetData() => create();
  factory GetData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetData clone() => GetData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetData copyWith(void Function(GetData) updates) => super.copyWith((message) => updates(message as GetData)) as GetData; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetData create() => GetData._();
  GetData createEmptyInstance() => create();
  static $pb.PbList<GetData> createRepeated() => $pb.PbList<GetData>();
  @$core.pragma('dart2js:noInline')
  static GetData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetData>(create);
  static GetData? _defaultInstance;
}

class AddSensor extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddSensor', createEmptyInstance: create)
    ..aOM<UUID>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sensorUuid', subBuilder: UUID.create)
    ..hasRequiredFields = false
  ;

  AddSensor._() : super();
  factory AddSensor({
    UUID? sensorUuid,
  }) {
    final _result = create();
    if (sensorUuid != null) {
      _result.sensorUuid = sensorUuid;
    }
    return _result;
  }
  factory AddSensor.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddSensor.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddSensor clone() => AddSensor()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddSensor copyWith(void Function(AddSensor) updates) => super.copyWith((message) => updates(message as AddSensor)) as AddSensor; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddSensor create() => AddSensor._();
  AddSensor createEmptyInstance() => create();
  static $pb.PbList<AddSensor> createRepeated() => $pb.PbList<AddSensor>();
  @$core.pragma('dart2js:noInline')
  static AddSensor getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddSensor>(create);
  static AddSensor? _defaultInstance;

  @$pb.TagNumber(1)
  UUID get sensorUuid => $_getN(0);
  @$pb.TagNumber(1)
  set sensorUuid(UUID v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSensorUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearSensorUuid() => clearField(1);
  @$pb.TagNumber(1)
  UUID ensureSensorUuid() => $_ensure(0);
}

