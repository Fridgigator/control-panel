import 'package:flutter/foundation.dart';

const remoteHttpDomain = kDebugMode
    ? "http://192.168.1.164:1234"
    : "https://fridgigator-001.fly.dev";
const remoteWsDomain =
    kDebugMode ? "ws://192.168.1.164:1234" : "wss://fridgigator-001.fly.dev";

const clientID = kDebugMode ? "ceaa445aaef178c6cba4" : "30bf4172998cc4ec684e";