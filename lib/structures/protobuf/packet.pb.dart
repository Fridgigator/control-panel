///
//  Generated code. Do not modify.
//  source: packet.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

enum Packet_Type {
  placeholder, 
  ack, 
  eot, 
  wifi, 
  getWifi, 
  notSet
}

class Packet extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, Packet_Type> _Packet_TypeByTag = {
    1 : Packet_Type.placeholder,
    2 : Packet_Type.ack,
    3 : Packet_Type.eot,
    4 : Packet_Type.wifi,
    5 : Packet_Type.getWifi,
    0 : Packet_Type.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Packet', createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5])
    ..aOM<Placeholder>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'placeholder', subBuilder: Placeholder.create)
    ..aOM<Ack>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ack', subBuilder: Ack.create)
    ..aOM<EndOfTransmission>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'eot', subBuilder: EndOfTransmission.create)
    ..aOM<WiFiVector>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'wifi', subBuilder: WiFiVector.create)
    ..aOM<GetWiFi>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'getWifi', protoName: 'getWifi', subBuilder: GetWiFi.create)
    ..hasRequiredFields = false
  ;

  Packet._() : super();
  factory Packet({
    Placeholder? placeholder,
    Ack? ack,
    EndOfTransmission? eot,
    WiFiVector? wifi,
    GetWiFi? getWifi,
  }) {
    final _result = create();
    if (placeholder != null) {
      _result.placeholder = placeholder;
    }
    if (ack != null) {
      _result.ack = ack;
    }
    if (eot != null) {
      _result.eot = eot;
    }
    if (wifi != null) {
      _result.wifi = wifi;
    }
    if (getWifi != null) {
      _result.getWifi = getWifi;
    }
    return _result;
  }
  factory Packet.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Packet.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Packet clone() => Packet()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Packet copyWith(void Function(Packet) updates) => super.copyWith((message) => updates(message as Packet)) as Packet; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Packet create() => Packet._();
  Packet createEmptyInstance() => create();
  static $pb.PbList<Packet> createRepeated() => $pb.PbList<Packet>();
  @$core.pragma('dart2js:noInline')
  static Packet getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Packet>(create);
  static Packet? _defaultInstance;

  Packet_Type whichType() => _Packet_TypeByTag[$_whichOneof(0)]!;
  void clearType() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  Placeholder get placeholder => $_getN(0);
  @$pb.TagNumber(1)
  set placeholder(Placeholder v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPlaceholder() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlaceholder() => clearField(1);
  @$pb.TagNumber(1)
  Placeholder ensurePlaceholder() => $_ensure(0);

  @$pb.TagNumber(2)
  Ack get ack => $_getN(1);
  @$pb.TagNumber(2)
  set ack(Ack v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasAck() => $_has(1);
  @$pb.TagNumber(2)
  void clearAck() => clearField(2);
  @$pb.TagNumber(2)
  Ack ensureAck() => $_ensure(1);

  @$pb.TagNumber(3)
  EndOfTransmission get eot => $_getN(2);
  @$pb.TagNumber(3)
  set eot(EndOfTransmission v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasEot() => $_has(2);
  @$pb.TagNumber(3)
  void clearEot() => clearField(3);
  @$pb.TagNumber(3)
  EndOfTransmission ensureEot() => $_ensure(2);

  @$pb.TagNumber(4)
  WiFiVector get wifi => $_getN(3);
  @$pb.TagNumber(4)
  set wifi(WiFiVector v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasWifi() => $_has(3);
  @$pb.TagNumber(4)
  void clearWifi() => clearField(4);
  @$pb.TagNumber(4)
  WiFiVector ensureWifi() => $_ensure(3);

  @$pb.TagNumber(5)
  GetWiFi get getWifi => $_getN(4);
  @$pb.TagNumber(5)
  set getWifi(GetWiFi v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasGetWifi() => $_has(4);
  @$pb.TagNumber(5)
  void clearGetWifi() => clearField(5);
  @$pb.TagNumber(5)
  GetWiFi ensureGetWifi() => $_ensure(4);
}

class Placeholder extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Placeholder', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  Placeholder._() : super();
  factory Placeholder() => create();
  factory Placeholder.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Placeholder.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Placeholder clone() => Placeholder()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Placeholder copyWith(void Function(Placeholder) updates) => super.copyWith((message) => updates(message as Placeholder)) as Placeholder; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Placeholder create() => Placeholder._();
  Placeholder createEmptyInstance() => create();
  static $pb.PbList<Placeholder> createRepeated() => $pb.PbList<Placeholder>();
  @$core.pragma('dart2js:noInline')
  static Placeholder getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Placeholder>(create);
  static Placeholder? _defaultInstance;
}

class Ack extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Ack', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  Ack._() : super();
  factory Ack() => create();
  factory Ack.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Ack.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Ack clone() => Ack()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Ack copyWith(void Function(Ack) updates) => super.copyWith((message) => updates(message as Ack)) as Ack; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Ack create() => Ack._();
  Ack createEmptyInstance() => create();
  static $pb.PbList<Ack> createRepeated() => $pb.PbList<Ack>();
  @$core.pragma('dart2js:noInline')
  static Ack getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Ack>(create);
  static Ack? _defaultInstance;
}

class EndOfTransmission extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'EndOfTransmission', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  EndOfTransmission._() : super();
  factory EndOfTransmission() => create();
  factory EndOfTransmission.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EndOfTransmission.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EndOfTransmission clone() => EndOfTransmission()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EndOfTransmission copyWith(void Function(EndOfTransmission) updates) => super.copyWith((message) => updates(message as EndOfTransmission)) as EndOfTransmission; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static EndOfTransmission create() => EndOfTransmission._();
  EndOfTransmission createEmptyInstance() => create();
  static $pb.PbList<EndOfTransmission> createRepeated() => $pb.PbList<EndOfTransmission>();
  @$core.pragma('dart2js:noInline')
  static EndOfTransmission getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EndOfTransmission>(create);
  static EndOfTransmission? _defaultInstance;
}

class GetWiFi extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetWiFi', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetWiFi._() : super();
  factory GetWiFi() => create();
  factory GetWiFi.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetWiFi.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetWiFi clone() => GetWiFi()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetWiFi copyWith(void Function(GetWiFi) updates) => super.copyWith((message) => updates(message as GetWiFi)) as GetWiFi; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetWiFi create() => GetWiFi._();
  GetWiFi createEmptyInstance() => create();
  static $pb.PbList<GetWiFi> createRepeated() => $pb.PbList<GetWiFi>();
  @$core.pragma('dart2js:noInline')
  static GetWiFi getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetWiFi>(create);
  static GetWiFi? _defaultInstance;
}

class WiFiVector extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'WiFiVector', createEmptyInstance: create)
    ..pc<WiFiData>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'data', $pb.PbFieldType.PM, subBuilder: WiFiData.create)
    ..hasRequiredFields = false
  ;

  WiFiVector._() : super();
  factory WiFiVector({
    $core.Iterable<WiFiData>? data,
  }) {
    final _result = create();
    if (data != null) {
      _result.data.addAll(data);
    }
    return _result;
  }
  factory WiFiVector.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WiFiVector.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WiFiVector clone() => WiFiVector()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WiFiVector copyWith(void Function(WiFiVector) updates) => super.copyWith((message) => updates(message as WiFiVector)) as WiFiVector; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WiFiVector create() => WiFiVector._();
  WiFiVector createEmptyInstance() => create();
  static $pb.PbList<WiFiVector> createRepeated() => $pb.PbList<WiFiVector>();
  @$core.pragma('dart2js:noInline')
  static WiFiVector getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WiFiVector>(create);
  static WiFiVector? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<WiFiData> get data => $_getList(0);
}

class WiFiData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'WiFiData', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'SSID', protoName: 'SSID')
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'BSSID', $pb.PbFieldType.OU6, protoName: 'BSSID', defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Channel', $pb.PbFieldType.OU3, protoName: 'Channel')
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isEncrypted', protoName: 'isEncrypted')
    ..hasRequiredFields = false
  ;

  WiFiData._() : super();
  factory WiFiData({
    $core.String? sSID,
    $fixnum.Int64? bSSID,
    $core.int? channel,
    $core.bool? isEncrypted,
  }) {
    final _result = create();
    if (sSID != null) {
      _result.sSID = sSID;
    }
    if (bSSID != null) {
      _result.bSSID = bSSID;
    }
    if (channel != null) {
      _result.channel = channel;
    }
    if (isEncrypted != null) {
      _result.isEncrypted = isEncrypted;
    }
    return _result;
  }
  factory WiFiData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WiFiData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WiFiData clone() => WiFiData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WiFiData copyWith(void Function(WiFiData) updates) => super.copyWith((message) => updates(message as WiFiData)) as WiFiData; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WiFiData create() => WiFiData._();
  WiFiData createEmptyInstance() => create();
  static $pb.PbList<WiFiData> createRepeated() => $pb.PbList<WiFiData>();
  @$core.pragma('dart2js:noInline')
  static WiFiData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WiFiData>(create);
  static WiFiData? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sSID => $_getSZ(0);
  @$pb.TagNumber(1)
  set sSID($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSSID() => $_has(0);
  @$pb.TagNumber(1)
  void clearSSID() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get bSSID => $_getI64(1);
  @$pb.TagNumber(2)
  set bSSID($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBSSID() => $_has(1);
  @$pb.TagNumber(2)
  void clearBSSID() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get channel => $_getIZ(2);
  @$pb.TagNumber(3)
  set channel($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasChannel() => $_has(2);
  @$pb.TagNumber(3)
  void clearChannel() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get isEncrypted => $_getBF(3);
  @$pb.TagNumber(4)
  set isEncrypted($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIsEncrypted() => $_has(3);
  @$pb.TagNumber(4)
  void clearIsEncrypted() => clearField(4);
}

