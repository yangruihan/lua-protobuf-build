# lua-protobuf build

lua-protobuf build with Premake5

## Build

### 1 Get source

```sh
# clone from github
git clone https://github.com/yangruihan/lua-protobuf-build.git

cd lua-protobuf-build

# init submodule
git submodule init
git submodule update
```

### 2 Windows create project

```batch
Win_GenProj.bat
```

Will create VS2019 project in build directory.

- lua: lua.exe
- luac: luac.exe
- luaDLL: luaDLL.dll
- luaLib: luaLib.lib
- pb: pb.dll

## Directory

- lualib: lua source
- lua: entry point to lua
- luac: entry point to luac
- lua-protobuf: lua-protobuf source
