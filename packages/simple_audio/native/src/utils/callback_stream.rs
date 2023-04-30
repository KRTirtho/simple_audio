// This file is a part of simple_audio
// Copyright (c) 2022-2023 Erikas Taroza <erikastaroza@gmail.com>
//
// This program is free software: you can redistribute it and/or
// modify it under the terms of the GNU Lesser General Public License as
// published by the Free Software Foundation, either version 3 of
// the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
// See the GNU Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public License along with this program.
// If not, see <https://www.gnu.org/licenses/>.

use std::sync::RwLock;

use flutter_rust_bridge::{support::lazy_static, StreamSink};

use super::types::Callback;

lazy_static! {
    static ref CALLBACK_STREAM: RwLock<Option<StreamSink<Callback>>> = RwLock::new(None);
}

/// Creates a new stream for sending callbacks to Dart.
pub fn callback_stream(stream: StreamSink<Callback>)
{
    let mut state_stream = CALLBACK_STREAM.write().unwrap();
    *state_stream = Some(stream);
}

/// Updates/adds to the stream with the given value.
pub fn update_callback_stream(value: Callback)
{
    if let Some(stream) = &*CALLBACK_STREAM.read().unwrap() {
        stream.add(value);
    }
}