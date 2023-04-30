# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(simple_audio_library VERSION 0.0.1 LANGUAGES C)

add_library(simple_audio SHARED
  "simple_audio.c"
)

set_target_properties(simple_audio PROPERTIES
  PUBLIC_HEADER simple_audio.h
  OUTPUT_NAME "simple_audio"
)

target_compile_definitions(simple_audio PUBLIC DART_SHARED_LIB)
