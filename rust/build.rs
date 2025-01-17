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

use std::process::Command;

#[allow(dead_code)]
fn add_lib(name: impl AsRef<str>, _static: bool)
{
    #[cfg(not(feature = "test"))]
    println!(
        "cargo:rustc-link-lib={}{}",
        if _static { "static=" } else { "" },
        name.as_ref()
    );
}

fn main()
{
    println!("cargo:rerun-if-changed=src/lib.rs");
    let result = Command::new("python")
        .args(["plugin_tool.py", "-c"])
        .current_dir("../")
        .status();

    if result.is_err() || !result.as_ref().unwrap().success() {
        panic!("Error running codegen: {result:?}");
    }

    let target = std::env::var("TARGET").expect("ERR: Could not check the target for the build.");

    if target.contains("android") {
        add_lib("c++_shared", false);
    }
}
