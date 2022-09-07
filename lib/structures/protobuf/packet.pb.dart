///
//  Generated code. Do not modify.
//  source: packet.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

enum BLESendPacket_Type {
  placeholder, 
  getWifi, 
  wifiConnectInfo, 
  getWiFiConnectState, 
  token, 
  notSet
}

class BLESendPacket extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, BLESendPacket_Type> _BLESendPacket_TypeByTag = {
    1 : BLESendPacket_Type.placeholder,
    2 : BLESendPacket_Type.getWifi,
    3 : BLESendPacket_Type.wifiConnectInfo,
    4 : BLESendPacket_Type.getWiFiConnectState,
    5 : BLESendPacket_Type.token,
    0 : BLESendPacket_Type.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BLESendPacket', createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5])
    ..aOM<Placeholder>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'placeholder', subBuilder: Placeholder.create)
    ..aOM<GetWiFi>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'getWifi', protoName: 'getWifi', subBuilder: GetWiFi.create)
    ..aOM<WiFiConnectInfo>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'wifiConnectInfo', protoName: 'wifiConnectInfo', subBuilder: WiFiConnectInfo.create)
    ..aOM<GetWiFiConnectState>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'getWiFiConnectState', protoName: 'getWiFiConnectState', subBuilder: GetWiFiConnectState.create)
    ..aOM<RegisterToken>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'token', subBuilder: RegisterToken.create)
    ..hasRequiredFields = false
  ;

  BLESendPacket._() : super();
  factory BLESendPacket({
    Placeholder? placeholder,
    GetWiFi? getWifi,
    WiFiConnectInfo? wifiConnectInfo,
    GetWiFiConnectState? getWiFiConnectState,
    RegisterToken? token,
  }) {
    final _result = create();
    if (placeholder != null) {
      _result.placeholder = placeholder;
    }
    if (getWifi != null) {
      _result.getWifi = getWifi;
    }
    if (wifiConnectInfo != null) {
      _result.wifiConnectInfo = wifiConnectInfo;
    }
    if (getWiFiConnectState != null) {
      _result.getWiFiConnectState = getWiFiConnectState;
    }
    if (token != null) {
      _result.token = token;
    }
    return _result;
  }
  factory BLESendPacket.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BLESendPacket.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BLESendPacket clone() => BLESendPacket()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BLESendPacket copyWith(void Function(BLESendPacket) updates) => super.copyWith((message) => updates(message as BLESendPacket)) as BLESendPacket; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BLESendPacket create() => BLESendPacket._();
  BLESendPacket createEmptyInstance() => create();
  static $pb.PbList<BLESendPacket> createRepeated() => $pb.PbList<BLESendPacket>();
  @$core.pragma('dart2js:noInline')
  static BLESendPacket getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BLESendPacket>(create);
  static BLESendPacket? _defaultInstance;

  BLESendPacket_Type whichType() => _BLESendPacket_TypeByTag[$_whichOneof(0)]!;
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
  GetWiFi get getWifi => $_getN(1);
  @$pb.TagNumber(2)
  set getWifi(GetWiFi v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasGetWifi() => $_has(1);
  @$pb.TagNumber(2)
  void clearGetWifi() => clearField(2);
  @$pb.TagNumber(2)
  GetWiFi ensureGetWifi() => $_ensure(1);

  @$pb.TagNumber(3)
  WiFiConnectInfo get wifiConnectInfo => $_getN(2);
  @$pb.TagNumber(3)
  set wifiConnectInfo(WiFiConnectInfo v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasWifiConnectInfo() => $_has(2);
  @$pb.TagNumber(3)
  void clearWifiConnectInfo() => clearField(3);
  @$pb.TagNumber(3)
  WiFiConnectInfo ensureWifiConnectInfo() => $_ensure(2);

  @$pb.TagNumber(4)
  GetWiFiConnectState get getWiFiConnectState => $_getN(3);
  @$pb.TagNumber(4)
  set getWiFiConnectState(GetWiFiConnectState v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasGetWiFiConnectState() => $_has(3);
  @$pb.TagNumber(4)
  void clearGetWiFiConnectState() => clearField(4);
  @$pb.TagNumber(4)
  GetWiFiConnectState ensureGetWiFiConnectState() => $_ensure(3);

  @$pb.TagNumber(5)
  RegisterToken get token => $_getN(4);
  @$pb.TagNumber(5)
  set token(RegisterToken v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasToken() => $_has(4);
  @$pb.TagNumber(5)
  void clearToken() => clearField(5);
  @$pb.TagNumber(5)
  RegisterToken ensureToken() => $_ensure(4);
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

class WiFiConnectInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'WiFiConnectInfo', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ssid')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'password')
    ..hasRequiredFields = false
  ;

  WiFiConnectInfo._() : super();
  factory WiFiConnectInfo({
    $core.String? ssid,
    $core.String? password,
  }) {
    final _result = create();
    if (ssid != null) {
      _result.ssid = ssid;
    }
    if (password != null) {
      _result.password = password;
    }
    return _result;
  }
  factory WiFiConnectInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WiFiConnectInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WiFiConnectInfo clone() => WiFiConnectInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WiFiConnectInfo copyWith(void Function(WiFiConnectInfo) updates) => super.copyWith((message) => updates(message as WiFiConnectInfo)) as WiFiConnectInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WiFiConnectInfo create() => WiFiConnectInfo._();
  WiFiConnectInfo createEmptyInstance() => create();
  static $pb.PbList<WiFiConnectInfo> createRepeated() => $pb.PbList<WiFiConnectInfo>();
  @$core.pragma('dart2js:noInline')
  static WiFiConnectInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WiFiConnectInfo>(create);
  static WiFiConnectInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ssid => $_getSZ(0);
  @$pb.TagNumber(1)
  set ssid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSsid() => $_has(0);
  @$pb.TagNumber(1)
  void clearSsid() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get password => $_getSZ(1);
  @$pb.TagNumber(2)
  set password($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearPassword() => clearField(2);
}

class GetWiFiConnectState extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetWiFiConnectState', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetWiFiConnectState._() : super();
  factory GetWiFiConnectState() => create();
  factory GetWiFiConnectState.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetWiFiConnectState.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetWiFiConnectState clone() => GetWiFiConnectState()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetWiFiConnectState copyWith(void Function(GetWiFiConnectState) updates) => super.copyWith((message) => updates(message as GetWiFiConnectState)) as GetWiFiConnectState; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetWiFiConnectState create() => GetWiFiConnectState._();
  GetWiFiConnectState createEmptyInstance() => create();
  static $pb.PbList<GetWiFiConnectState> createRepeated() => $pb.PbList<GetWiFiConnectState>();
  @$core.pragma('dart2js:noInline')
  static GetWiFiConnectState getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetWiFiConnectState>(create);
  static GetWiFiConnectState? _defaultInstance;
}

class RegisterToken extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RegisterToken', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uuid')
    ..hasRequiredFields = false
  ;

  RegisterToken._() : super();
  factory RegisterToken({
    $core.String? uuid,
  }) {
    final _result = create();
    if (uuid != null) {
      _result.uuid = uuid;
    }
    return _result;
  }
  factory RegisterToken.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RegisterToken.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RegisterToken clone() => RegisterToken()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RegisterToken copyWith(void Function(RegisterToken) updates) => super.copyWith((message) => updates(message as RegisterToken)) as RegisterToken; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RegisterToken create() => RegisterToken._();
  RegisterToken createEmptyInstance() => create();
  static $pb.PbList<RegisterToken> createRepeated() => $pb.PbList<RegisterToken>();
  @$core.pragma('dart2js:noInline')
  static RegisterToken getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RegisterToken>(create);
  static RegisterToken? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get uuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set uuid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearUuid() => clearField(1);
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
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ssid')
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bssid', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Channel', $pb.PbFieldType.OU3, protoName: 'Channel')
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isEncrypted', protoName: 'isEncrypted')
    ..hasRequiredFields = false
  ;

  WiFiData._() : super();
  factory WiFiData({
    $core.String? ssid,
    $fixnum.Int64? bssid,
    $core.int? channel,
    $core.bool? isEncrypted,
  }) {
    final _result = create();
    if (ssid != null) {
      _result.ssid = ssid;
    }
    if (bssid != null) {
      _result.bssid = bssid;
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
  $core.String get ssid => $_getSZ(0);
  @$pb.TagNumber(1)
  set ssid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSsid() => $_has(0);
  @$pb.TagNumber(1)
  void clearSsid() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get bssid => $_getI64(1);
  @$pb.TagNumber(2)
  set bssid($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBssid() => $_has(1);
  @$pb.TagNumber(2)
  void clearBssid() => clearField(2);

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

enum WiFiConnectResponseInfo_Type {
  placeholder, 
  timeout, 
  connectingToWiFi, 
  connectedToWiFi, 
  connectingToServer, 
  failedConnectingToServer, 
  notSet
}

class WiFiConnectResponseInfo extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, WiFiConnectResponseInfo_Type> _WiFiConnectResponseInfo_TypeByTag = {
    1 : WiFiConnectResponseInfo_Type.placeholder,
    2 : WiFiConnectResponseInfo_Type.timeout,
    3 : WiFiConnectResponseInfo_Type.connectingToWiFi,
    4 : WiFiConnectResponseInfo_Type.connectedToWiFi,
    5 : WiFiConnectResponseInfo_Type.connectingToServer,
    6 : WiFiConnectResponseInfo_Type.failedConnectingToServer,
    0 : WiFiConnectResponseInfo_Type.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'WiFiConnectResponseInfo', createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5, 6])
    ..aOM<Placeholder>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'placeholder', subBuilder: Placeholder.create)
    ..aOM<Timeout>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timeout', subBuilder: Timeout.create)
    ..aOM<ConnectingToWiFi>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'connectingToWiFi', protoName: 'connectingToWiFi', subBuilder: ConnectingToWiFi.create)
    ..aOM<ConnectedToWiFi>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'connectedToWiFi', protoName: 'connectedToWiFi', subBuilder: ConnectedToWiFi.create)
    ..aOM<ConnectingToServer>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'connectingToServer', protoName: 'connectingToServer', subBuilder: ConnectingToServer.create)
    ..aOM<FailedConnectingToServer>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failedConnectingToServer', protoName: 'failedConnectingToServer', subBuilder: FailedConnectingToServer.create)
    ..hasRequiredFields = false
  ;

  WiFiConnectResponseInfo._() : super();
  factory WiFiConnectResponseInfo({
    Placeholder? placeholder,
    Timeout? timeout,
    ConnectingToWiFi? connectingToWiFi,
    ConnectedToWiFi? connectedToWiFi,
    ConnectingToServer? connectingToServer,
    FailedConnectingToServer? failedConnectingToServer,
  }) {
    final _result = create();
    if (placeholder != null) {
      _result.placeholder = placeholder;
    }
    if (timeout != null) {
      _result.timeout = timeout;
    }
    if (connectingToWiFi != null) {
      _result.connectingToWiFi = connectingToWiFi;
    }
    if (connectedToWiFi != null) {
      _result.connectedToWiFi = connectedToWiFi;
    }
    if (connectingToServer != null) {
      _result.connectingToServer = connectingToServer;
    }
    if (failedConnectingToServer != null) {
      _result.failedConnectingToServer = failedConnectingToServer;
    }
    return _result;
  }
  factory WiFiConnectResponseInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WiFiConnectResponseInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WiFiConnectResponseInfo clone() => WiFiConnectResponseInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WiFiConnectResponseInfo copyWith(void Function(WiFiConnectResponseInfo) updates) => super.copyWith((message) => updates(message as WiFiConnectResponseInfo)) as WiFiConnectResponseInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WiFiConnectResponseInfo create() => WiFiConnectResponseInfo._();
  WiFiConnectResponseInfo createEmptyInstance() => create();
  static $pb.PbList<WiFiConnectResponseInfo> createRepeated() => $pb.PbList<WiFiConnectResponseInfo>();
  @$core.pragma('dart2js:noInline')
  static WiFiConnectResponseInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WiFiConnectResponseInfo>(create);
  static WiFiConnectResponseInfo? _defaultInstance;

  WiFiConnectResponseInfo_Type whichType() => _WiFiConnectResponseInfo_TypeByTag[$_whichOneof(0)]!;
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
  Timeout get timeout => $_getN(1);
  @$pb.TagNumber(2)
  set timeout(Timeout v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasTimeout() => $_has(1);
  @$pb.TagNumber(2)
  void clearTimeout() => clearField(2);
  @$pb.TagNumber(2)
  Timeout ensureTimeout() => $_ensure(1);

  @$pb.TagNumber(3)
  ConnectingToWiFi get connectingToWiFi => $_getN(2);
  @$pb.TagNumber(3)
  set connectingToWiFi(ConnectingToWiFi v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasConnectingToWiFi() => $_has(2);
  @$pb.TagNumber(3)
  void clearConnectingToWiFi() => clearField(3);
  @$pb.TagNumber(3)
  ConnectingToWiFi ensureConnectingToWiFi() => $_ensure(2);

  @$pb.TagNumber(4)
  ConnectedToWiFi get connectedToWiFi => $_getN(3);
  @$pb.TagNumber(4)
  set connectedToWiFi(ConnectedToWiFi v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasConnectedToWiFi() => $_has(3);
  @$pb.TagNumber(4)
  void clearConnectedToWiFi() => clearField(4);
  @$pb.TagNumber(4)
  ConnectedToWiFi ensureConnectedToWiFi() => $_ensure(3);

  @$pb.TagNumber(5)
  ConnectingToServer get connectingToServer => $_getN(4);
  @$pb.TagNumber(5)
  set connectingToServer(ConnectingToServer v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasConnectingToServer() => $_has(4);
  @$pb.TagNumber(5)
  void clearConnectingToServer() => clearField(5);
  @$pb.TagNumber(5)
  ConnectingToServer ensureConnectingToServer() => $_ensure(4);

  @$pb.TagNumber(6)
  FailedConnectingToServer get failedConnectingToServer => $_getN(5);
  @$pb.TagNumber(6)
  set failedConnectingToServer(FailedConnectingToServer v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasFailedConnectingToServer() => $_has(5);
  @$pb.TagNumber(6)
  void clearFailedConnectingToServer() => clearField(6);
  @$pb.TagNumber(6)
  FailedConnectingToServer ensureFailedConnectingToServer() => $_ensure(5);
}

class Timeout extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Timeout', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  Timeout._() : super();
  factory Timeout() => create();
  factory Timeout.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Timeout.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Timeout clone() => Timeout()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Timeout copyWith(void Function(Timeout) updates) => super.copyWith((message) => updates(message as Timeout)) as Timeout; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Timeout create() => Timeout._();
  Timeout createEmptyInstance() => create();
  static $pb.PbList<Timeout> createRepeated() => $pb.PbList<Timeout>();
  @$core.pragma('dart2js:noInline')
  static Timeout getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Timeout>(create);
  static Timeout? _defaultInstance;
}

class ConnectingToWiFi extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ConnectingToWiFi', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  ConnectingToWiFi._() : super();
  factory ConnectingToWiFi() => create();
  factory ConnectingToWiFi.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConnectingToWiFi.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConnectingToWiFi clone() => ConnectingToWiFi()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConnectingToWiFi copyWith(void Function(ConnectingToWiFi) updates) => super.copyWith((message) => updates(message as ConnectingToWiFi)) as ConnectingToWiFi; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ConnectingToWiFi create() => ConnectingToWiFi._();
  ConnectingToWiFi createEmptyInstance() => create();
  static $pb.PbList<ConnectingToWiFi> createRepeated() => $pb.PbList<ConnectingToWiFi>();
  @$core.pragma('dart2js:noInline')
  static ConnectingToWiFi getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConnectingToWiFi>(create);
  static ConnectingToWiFi? _defaultInstance;
}

class ConnectedToWiFi extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ConnectedToWiFi', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  ConnectedToWiFi._() : super();
  factory ConnectedToWiFi() => create();
  factory ConnectedToWiFi.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConnectedToWiFi.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConnectedToWiFi clone() => ConnectedToWiFi()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConnectedToWiFi copyWith(void Function(ConnectedToWiFi) updates) => super.copyWith((message) => updates(message as ConnectedToWiFi)) as ConnectedToWiFi; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ConnectedToWiFi create() => ConnectedToWiFi._();
  ConnectedToWiFi createEmptyInstance() => create();
  static $pb.PbList<ConnectedToWiFi> createRepeated() => $pb.PbList<ConnectedToWiFi>();
  @$core.pragma('dart2js:noInline')
  static ConnectedToWiFi getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConnectedToWiFi>(create);
  static ConnectedToWiFi? _defaultInstance;
}

class ConnectingToServer extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ConnectingToServer', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  ConnectingToServer._() : super();
  factory ConnectingToServer() => create();
  factory ConnectingToServer.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConnectingToServer.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConnectingToServer clone() => ConnectingToServer()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConnectingToServer copyWith(void Function(ConnectingToServer) updates) => super.copyWith((message) => updates(message as ConnectingToServer)) as ConnectingToServer; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ConnectingToServer create() => ConnectingToServer._();
  ConnectingToServer createEmptyInstance() => create();
  static $pb.PbList<ConnectingToServer> createRepeated() => $pb.PbList<ConnectingToServer>();
  @$core.pragma('dart2js:noInline')
  static ConnectingToServer getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConnectingToServer>(create);
  static ConnectingToServer? _defaultInstance;
}

class FailedConnectingToServer extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FailedConnectingToServer', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'causeid', $pb.PbFieldType.O3)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cause')
    ..hasRequiredFields = false
  ;

  FailedConnectingToServer._() : super();
  factory FailedConnectingToServer({
    $core.int? causeid,
    $core.String? cause,
  }) {
    final _result = create();
    if (causeid != null) {
      _result.causeid = causeid;
    }
    if (cause != null) {
      _result.cause = cause;
    }
    return _result;
  }
  factory FailedConnectingToServer.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FailedConnectingToServer.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FailedConnectingToServer clone() => FailedConnectingToServer()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FailedConnectingToServer copyWith(void Function(FailedConnectingToServer) updates) => super.copyWith((message) => updates(message as FailedConnectingToServer)) as FailedConnectingToServer; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FailedConnectingToServer create() => FailedConnectingToServer._();
  FailedConnectingToServer createEmptyInstance() => create();
  static $pb.PbList<FailedConnectingToServer> createRepeated() => $pb.PbList<FailedConnectingToServer>();
  @$core.pragma('dart2js:noInline')
  static FailedConnectingToServer getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FailedConnectingToServer>(create);
  static FailedConnectingToServer? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get causeid => $_getIZ(0);
  @$pb.TagNumber(1)
  set causeid($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCauseid() => $_has(0);
  @$pb.TagNumber(1)
  void clearCauseid() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get cause => $_getSZ(1);
  @$pb.TagNumber(2)
  set cause($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCause() => $_has(1);
  @$pb.TagNumber(2)
  void clearCause() => clearField(2);
}

enum LoginResponse_Type {
  loginError, 
  timeout, 
  notSet
}

class LoginResponse extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, LoginResponse_Type> _LoginResponse_TypeByTag = {
    1 : LoginResponse_Type.loginError,
    2 : LoginResponse_Type.timeout,
    0 : LoginResponse_Type.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LoginResponse', createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<LoginError>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'loginError', subBuilder: LoginError.create)
    ..aOM<Timeout>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timeout', subBuilder: Timeout.create)
    ..hasRequiredFields = false
  ;

  LoginResponse._() : super();
  factory LoginResponse({
    LoginError? loginError,
    Timeout? timeout,
  }) {
    final _result = create();
    if (loginError != null) {
      _result.loginError = loginError;
    }
    if (timeout != null) {
      _result.timeout = timeout;
    }
    return _result;
  }
  factory LoginResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LoginResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LoginResponse clone() => LoginResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LoginResponse copyWith(void Function(LoginResponse) updates) => super.copyWith((message) => updates(message as LoginResponse)) as LoginResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LoginResponse create() => LoginResponse._();
  LoginResponse createEmptyInstance() => create();
  static $pb.PbList<LoginResponse> createRepeated() => $pb.PbList<LoginResponse>();
  @$core.pragma('dart2js:noInline')
  static LoginResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LoginResponse>(create);
  static LoginResponse? _defaultInstance;

  LoginResponse_Type whichType() => _LoginResponse_TypeByTag[$_whichOneof(0)]!;
  void clearType() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  LoginError get loginError => $_getN(0);
  @$pb.TagNumber(1)
  set loginError(LoginError v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasLoginError() => $_has(0);
  @$pb.TagNumber(1)
  void clearLoginError() => clearField(1);
  @$pb.TagNumber(1)
  LoginError ensureLoginError() => $_ensure(0);

  @$pb.TagNumber(2)
  Timeout get timeout => $_getN(1);
  @$pb.TagNumber(2)
  set timeout(Timeout v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasTimeout() => $_has(1);
  @$pb.TagNumber(2)
  void clearTimeout() => clearField(2);
  @$pb.TagNumber(2)
  Timeout ensureTimeout() => $_ensure(1);
}

class LoginError extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LoginError', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  LoginError._() : super();
  factory LoginError() => create();
  factory LoginError.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LoginError.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LoginError clone() => LoginError()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LoginError copyWith(void Function(LoginError) updates) => super.copyWith((message) => updates(message as LoginError)) as LoginError; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LoginError create() => LoginError._();
  LoginError createEmptyInstance() => create();
  static $pb.PbList<LoginError> createRepeated() => $pb.PbList<LoginError>();
  @$core.pragma('dart2js:noInline')
  static LoginError getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LoginError>(create);
  static LoginError? _defaultInstance;
}

