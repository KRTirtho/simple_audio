// AUTO GENERATED FILE, DO NOT EDIT.
// Generated by `flutter_rust_bridge`@ 1.65.0.
// ignore_for_file: non_constant_identifier_names, unused_element, duplicate_ignore, directives_ordering, curly_braces_in_flow_control_structures, unnecessary_lambdas, slash_for_doc_comments, prefer_const_literals_to_create_immutables, implicit_dynamic_list_literal, duplicate_import, unused_import, unnecessary_import, prefer_single_quotes, prefer_const_constructors, use_super_parameters, always_use_package_imports, annotate_overrides, invalid_use_of_protected_member, constant_identifier_names, invalid_use_of_internal_member, prefer_is_empty

import 'dart:convert';
import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';

abstract class SimpleAudio {
  Future<Player> newStaticMethodPlayer(
      {required Int32List actions,
      required String dbusName,
      int? hwnd,
      dynamic hint});

  FlutterRustBridgeTaskConstMeta get kNewStaticMethodPlayerConstMeta;

  Stream<int> playbackStateStreamStaticMethodPlayer({dynamic hint});

  FlutterRustBridgeTaskConstMeta
      get kPlaybackStateStreamStaticMethodPlayerConstMeta;

  Stream<ProgressState> progressStateStreamStaticMethodPlayer({dynamic hint});

  FlutterRustBridgeTaskConstMeta
      get kProgressStateStreamStaticMethodPlayerConstMeta;

  Stream<Callback> callbackStreamStaticMethodPlayer({dynamic hint});

  FlutterRustBridgeTaskConstMeta get kCallbackStreamStaticMethodPlayerConstMeta;

  Future<bool> isPlayingMethodPlayer({required Player that, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kIsPlayingMethodPlayerConstMeta;

  Future<ProgressState> getProgressMethodPlayer(
      {required Player that, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kGetProgressMethodPlayerConstMeta;

  Future<void> openMethodPlayer(
      {required Player that,
      required String path,
      required bool autoplay,
      dynamic hint});

  FlutterRustBridgeTaskConstMeta get kOpenMethodPlayerConstMeta;

  Future<void> playMethodPlayer({required Player that, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kPlayMethodPlayerConstMeta;

  Future<void> pauseMethodPlayer({required Player that, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kPauseMethodPlayerConstMeta;

  Future<void> stopMethodPlayer({required Player that, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kStopMethodPlayerConstMeta;

  Future<void> loopPlaybackMethodPlayer(
      {required Player that, required bool shouldLoop, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kLoopPlaybackMethodPlayerConstMeta;

  Future<void> setVolumeMethodPlayer(
      {required Player that, required double volume, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kSetVolumeMethodPlayerConstMeta;

  Future<void> seekMethodPlayer(
      {required Player that, required int seconds, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kSeekMethodPlayerConstMeta;

  Future<void> setMetadataMethodPlayer(
      {required Player that, required Metadata metadata, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kSetMetadataMethodPlayerConstMeta;

  Future<void> normalizeVolumeMethodPlayer(
      {required Player that, required bool shouldNormalize, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kNormalizeVolumeMethodPlayerConstMeta;
}

enum Callback {
  /// The media notification trigged the SkipPrev action.
  NotificationActionSkipPrev,

  /// The media notification trigged the SkipNext action.
  NotificationActionSkipNext,

  /// An error occurred during the CPAL stream.
  StreamError,
}

class Metadata {
  final String? title;
  final String? artist;
  final String? album;
  final String? artUri;
  final Uint8List? artBytes;
  Metadata({
    this.title,
    this.artist,
    this.album,
    this.artUri,
    this.artBytes,
  });
}

class Player {
  final SimpleAudio bridge;
  Player({
    required this.bridge,
  });

  static Future<Player> newPlayer(
          {required SimpleAudio bridge,
          required Int32List actions,
          required String dbusName,
          int? hwnd,
          dynamic hint}) =>
      bridge.newStaticMethodPlayer(
          actions: actions, dbusName: dbusName, hwnd: hwnd, hint: hint);

  static Stream<int> playbackStateStream(
          {required SimpleAudio bridge, dynamic hint}) =>
      bridge.playbackStateStreamStaticMethodPlayer(hint: hint);

  static Stream<ProgressState> progressStateStream(
          {required SimpleAudio bridge, dynamic hint}) =>
      bridge.progressStateStreamStaticMethodPlayer(hint: hint);

  static Stream<Callback> callbackStream(
          {required SimpleAudio bridge, dynamic hint}) =>
      bridge.callbackStreamStaticMethodPlayer(hint: hint);

  Future<bool> isPlaying({dynamic hint}) => bridge.isPlayingMethodPlayer(
        that: this,
      );

  Future<ProgressState> getProgress({dynamic hint}) =>
      bridge.getProgressMethodPlayer(
        that: this,
      );

  Future<void> open(
          {required String path, required bool autoplay, dynamic hint}) =>
      bridge.openMethodPlayer(
        that: this,
        path: path,
        autoplay: autoplay,
      );

  Future<void> play({dynamic hint}) => bridge.playMethodPlayer(
        that: this,
      );

  Future<void> pause({dynamic hint}) => bridge.pauseMethodPlayer(
        that: this,
      );

  Future<void> stop({dynamic hint}) => bridge.stopMethodPlayer(
        that: this,
      );

  Future<void> loopPlayback({required bool shouldLoop, dynamic hint}) =>
      bridge.loopPlaybackMethodPlayer(
        that: this,
        shouldLoop: shouldLoop,
      );

  Future<void> setVolume({required double volume, dynamic hint}) =>
      bridge.setVolumeMethodPlayer(
        that: this,
        volume: volume,
      );

  Future<void> seek({required int seconds, dynamic hint}) =>
      bridge.seekMethodPlayer(
        that: this,
        seconds: seconds,
      );

  Future<void> setMetadata({required Metadata metadata, dynamic hint}) =>
      bridge.setMetadataMethodPlayer(
        that: this,
        metadata: metadata,
      );

  Future<void> normalizeVolume({required bool shouldNormalize, dynamic hint}) =>
      bridge.normalizeVolumeMethodPlayer(
        that: this,
        shouldNormalize: shouldNormalize,
      );
}

class ProgressState {
  final int position;
  final int duration;
  ProgressState({
    required this.position,
    required this.duration,
  });
}
