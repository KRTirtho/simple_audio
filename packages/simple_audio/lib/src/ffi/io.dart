import 'dart:ffi';
import 'dart:io';

import 'package:simple_audio/src/bridge_generated.dart';

typedef ExternalLibrary = DynamicLibrary;

SimpleAudio createWrapperImpl(ExternalLibrary dylib) =>
    SimpleAudioImpl(dylib);

DynamicLibrary createLibraryImpl() {
  const base = 'simple_audio';

  if (Platform.isIOS || Platform.isMacOS) {
    return DynamicLibrary.executable();
  } else if (Platform.isWindows) {
    return DynamicLibrary.open('$base.dll');
  } else {
    return DynamicLibrary.open('lib$base.so');
  }
}
