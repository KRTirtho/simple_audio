import 'package:simple_audio/src/bridge_generated.dart';
import 'ffi/stub.dart'
    if (dart.library.io) 'ffi/io.dart'
    if (dart.library.html) 'ffi/web.dart';

SimpleAudio? _wrapper;

SimpleAudio createLib() {
  _wrapper ??= createWrapperImpl(createLibraryImpl());
  return _wrapper!;
}