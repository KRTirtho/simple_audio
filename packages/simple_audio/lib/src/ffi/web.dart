import 'package:simple_audio/src/bridge_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';

typedef ExternalLibrary = WasmModule;

SimpleAudio createWrapperImpl(ExternalLibrary module) =>
    SimpleAudioImpl.wasm(module);


WasmModule createLibraryImpl() {
  // TODO add web support. See:
  // https://github.com/fzyzcjy/flutter_rust_bridge/blob/master/frb_example/with_flutter/lib/ffi.web.dart
  throw UnsupportedError('Web support is not provided yet.');
}
