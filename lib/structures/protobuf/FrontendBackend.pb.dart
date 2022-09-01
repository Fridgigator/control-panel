///
//  Generated code. Do not modify.
//  source: FrontendBackend.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

enum ToFrontEnd_Type {
  githubState, 
  accessCode, 
  notSet
}

class ToFrontEnd extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, ToFrontEnd_Type> _ToFrontEnd_TypeByTag = {
    1 : ToFrontEnd_Type.githubState,
    2 : ToFrontEnd_Type.accessCode,
    0 : ToFrontEnd_Type.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ToFrontEnd', createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<Nonce>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'githubState', subBuilder: Nonce.create)
    ..aOM<AccessCode>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accessCode', subBuilder: AccessCode.create)
    ..hasRequiredFields = false
  ;

  ToFrontEnd._() : super();
  factory ToFrontEnd({
    Nonce? githubState,
    AccessCode? accessCode,
  }) {
    final _result = create();
    if (githubState != null) {
      _result.githubState = githubState;
    }
    if (accessCode != null) {
      _result.accessCode = accessCode;
    }
    return _result;
  }
  factory ToFrontEnd.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ToFrontEnd.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ToFrontEnd clone() => ToFrontEnd()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ToFrontEnd copyWith(void Function(ToFrontEnd) updates) => super.copyWith((message) => updates(message as ToFrontEnd)) as ToFrontEnd; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ToFrontEnd create() => ToFrontEnd._();
  ToFrontEnd createEmptyInstance() => create();
  static $pb.PbList<ToFrontEnd> createRepeated() => $pb.PbList<ToFrontEnd>();
  @$core.pragma('dart2js:noInline')
  static ToFrontEnd getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ToFrontEnd>(create);
  static ToFrontEnd? _defaultInstance;

  ToFrontEnd_Type whichType() => _ToFrontEnd_TypeByTag[$_whichOneof(0)]!;
  void clearType() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  Nonce get githubState => $_getN(0);
  @$pb.TagNumber(1)
  set githubState(Nonce v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasGithubState() => $_has(0);
  @$pb.TagNumber(1)
  void clearGithubState() => clearField(1);
  @$pb.TagNumber(1)
  Nonce ensureGithubState() => $_ensure(0);

  @$pb.TagNumber(2)
  AccessCode get accessCode => $_getN(1);
  @$pb.TagNumber(2)
  set accessCode(AccessCode v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccessCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccessCode() => clearField(2);
  @$pb.TagNumber(2)
  AccessCode ensureAccessCode() => $_ensure(1);
}

class Nonce extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Nonce', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nonce')
    ..hasRequiredFields = false
  ;

  Nonce._() : super();
  factory Nonce({
    $core.String? nonce,
  }) {
    final _result = create();
    if (nonce != null) {
      _result.nonce = nonce;
    }
    return _result;
  }
  factory Nonce.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Nonce.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Nonce clone() => Nonce()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Nonce copyWith(void Function(Nonce) updates) => super.copyWith((message) => updates(message as Nonce)) as Nonce; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Nonce create() => Nonce._();
  Nonce createEmptyInstance() => create();
  static $pb.PbList<Nonce> createRepeated() => $pb.PbList<Nonce>();
  @$core.pragma('dart2js:noInline')
  static Nonce getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Nonce>(create);
  static Nonce? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get nonce => $_getSZ(0);
  @$pb.TagNumber(1)
  set nonce($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNonce() => $_has(0);
  @$pb.TagNumber(1)
  void clearNonce() => clearField(1);
}

class AccessCode extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AccessCode', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accessCode')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failed')
    ..hasRequiredFields = false
  ;

  AccessCode._() : super();
  factory AccessCode({
    $core.String? accessCode,
    $core.bool? failed,
  }) {
    final _result = create();
    if (accessCode != null) {
      _result.accessCode = accessCode;
    }
    if (failed != null) {
      _result.failed = failed;
    }
    return _result;
  }
  factory AccessCode.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AccessCode.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AccessCode clone() => AccessCode()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AccessCode copyWith(void Function(AccessCode) updates) => super.copyWith((message) => updates(message as AccessCode)) as AccessCode; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AccessCode create() => AccessCode._();
  AccessCode createEmptyInstance() => create();
  static $pb.PbList<AccessCode> createRepeated() => $pb.PbList<AccessCode>();
  @$core.pragma('dart2js:noInline')
  static AccessCode getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AccessCode>(create);
  static AccessCode? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accessCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set accessCode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccessCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccessCode() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get failed => $_getBF(1);
  @$pb.TagNumber(2)
  set failed($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFailed() => $_has(1);
  @$pb.TagNumber(2)
  void clearFailed() => clearField(2);
}

