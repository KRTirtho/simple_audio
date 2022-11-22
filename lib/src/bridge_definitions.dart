// AUTO GENERATED FILE, DO NOT EDIT.
// Generated by `flutter_rust_bridge`@ 1.49.0.
// ignore_for_file: non_constant_identifier_names, unused_element, duplicate_ignore, directives_ordering, curly_braces_in_flow_control_structures, unnecessary_lambdas, slash_for_doc_comments, prefer_const_literals_to_create_immutables, implicit_dynamic_list_literal, duplicate_import, unused_import, prefer_single_quotes, prefer_const_constructors, use_super_parameters, always_use_package_imports, annotate_overrides, invalid_use_of_protected_member, constant_identifier_names

import 'dart:convert';
import 'dart:async';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';

abstract class SimpleAudio {
  Future<Player> newStaticMethodPlayer(
      {required String mprisName, int? hwnd, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kNewStaticMethodPlayerConstMeta;

  Stream<int> playbackStateStreamStaticMethodPlayer({dynamic hint});

  FlutterRustBridgeTaskConstMeta
      get kPlaybackStateStreamStaticMethodPlayerConstMeta;

  Stream<ProgressState> progressStateStreamStaticMethodPlayer({dynamic hint});

  FlutterRustBridgeTaskConstMeta
      get kProgressStateStreamStaticMethodPlayerConstMeta;

  Stream<bool> metadataCallbackStreamStaticMethodPlayer({dynamic hint});

  FlutterRustBridgeTaskConstMeta
      get kMetadataCallbackStreamStaticMethodPlayerConstMeta;

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

  Future<void> setVolumeMethodPlayer(
      {required Player that, required double volume, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kSetVolumeMethodPlayerConstMeta;

  Future<void> seekMethodPlayer(
      {required Player that, required int seconds, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kSeekMethodPlayerConstMeta;

  Future<void> setMetadataMethodPlayer(
      {required Player that, required Metadata metadata, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kSetMetadataMethodPlayerConstMeta;
}

class Metadata {
  final String? title;
  final String? artist;
  final String? album;
  final String? artUri;

  Metadata({
    this.title,
    this.artist,
    this.album,
    this.artUri,
  });
}

class Player {
  final SimpleAudio bridge;
  final int dummy;

  Player({
    required this.bridge,
    required this.dummy,
  });

  static Future<Player> newPlayer(
          {required SimpleAudio bridge,
          required String mprisName,
          int? hwnd,
          dynamic hint}) =>
      bridge.newStaticMethodPlayer(
          mprisName: mprisName, hwnd: hwnd, hint: hint);

  static Stream<int> playbackStateStream(
          {required SimpleAudio bridge, dynamic hint}) =>
      bridge.playbackStateStreamStaticMethodPlayer(hint: hint);

  static Stream<ProgressState> progressStateStream(
          {required SimpleAudio bridge, dynamic hint}) =>
      bridge.progressStateStreamStaticMethodPlayer(hint: hint);

  static Stream<bool> metadataCallbackStream(
          {required SimpleAudio bridge, dynamic hint}) =>
      bridge.metadataCallbackStreamStaticMethodPlayer(hint: hint);

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
}

class ProgressState {
  final int position;
  final int duration;

  ProgressState({
    required this.position,
    required this.duration,
  });
}
