///
//  Generated code. Do not modify.
//  source: FrontendBackend.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use toFrontEndDescriptor instead')
const ToFrontEnd$json = const {
  '1': 'ToFrontEnd',
  '2': const [
    const {'1': 'github_state', '3': 1, '4': 1, '5': 11, '6': '.Nonce', '9': 0, '10': 'githubState'},
    const {'1': 'access_code', '3': 2, '4': 1, '5': 11, '6': '.AccessCode', '9': 0, '10': 'accessCode'},
  ],
  '8': const [
    const {'1': 'type'},
  ],
};

/// Descriptor for `ToFrontEnd`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List toFrontEndDescriptor = $convert.base64Decode('CgpUb0Zyb250RW5kEisKDGdpdGh1Yl9zdGF0ZRgBIAEoCzIGLk5vbmNlSABSC2dpdGh1YlN0YXRlEi4KC2FjY2Vzc19jb2RlGAIgASgLMgsuQWNjZXNzQ29kZUgAUgphY2Nlc3NDb2RlQgYKBHR5cGU=');
@$core.Deprecated('Use nonceDescriptor instead')
const Nonce$json = const {
  '1': 'Nonce',
  '2': const [
    const {'1': 'nonce', '3': 1, '4': 1, '5': 9, '10': 'nonce'},
  ],
};

/// Descriptor for `Nonce`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nonceDescriptor = $convert.base64Decode('CgVOb25jZRIUCgVub25jZRgBIAEoCVIFbm9uY2U=');
@$core.Deprecated('Use accessCodeDescriptor instead')
const AccessCode$json = const {
  '1': 'AccessCode',
  '2': const [
    const {'1': 'access_code', '3': 1, '4': 1, '5': 9, '10': 'accessCode'},
    const {'1': 'failed', '3': 2, '4': 1, '5': 8, '10': 'failed'},
  ],
};

/// Descriptor for `AccessCode`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accessCodeDescriptor = $convert.base64Decode('CgpBY2Nlc3NDb2RlEh8KC2FjY2Vzc19jb2RlGAEgASgJUgphY2Nlc3NDb2RlEhYKBmZhaWxlZBgCIAEoCFIGZmFpbGVk');
