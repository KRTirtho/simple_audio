#!/bin/bash

CURR_VERSION=simple_audio-v`awk '/^version: /{print $2}' packages/simple_audio/pubspec.yaml`

# iOS & macOS
APPLE_HEADER="release_tag_name = '$CURR_VERSION' # generated; do not edit"
sed -i.bak "1 s/.*/$APPLE_HEADER/" packages/simple_audio/ios/simple_audio.podspec
sed -i.bak "1 s/.*/$APPLE_HEADER/" packages/simple_audio/macos/simple_audio.podspec
rm packages/simple_audio/macos/*.bak packages/simple_audio/ios/*.bak

# CMake platforms (Linux, Windows, and Android)
CMAKE_HEADER="set(LibraryVersion \"$CURR_VERSION\") # generated; do not edit"
for CMAKE_PLATFORM in android linux windows
do
    sed -i.bak "1 s/.*/$CMAKE_HEADER/" packages/simple_audio/$CMAKE_PLATFORM/CMakeLists.txt
    rm packages/simple_audio/$CMAKE_PLATFORM/*.bak
done

git add packages/simple_audio/
