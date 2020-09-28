# lua-protobuf build

lua-protobuf build with Premake5

- lua 5.3.5
- protobuf master a01f5cf

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

Will create VS2019 project in `build/windows`.

- lua: lua.exe
- luac: luac.exe
- luaDLL: luaDLL.dll
- luaLib: luaLib.lib
- pb: pb.dll

### 3 macOS create project

```sh
Mac_GenProj.sh
```

Will create XCode project in `build/macos`.

- lua: lua
- luac: luac
- luaDLL: libluaDLL.dylib
- luaLib: libluaLib.a
- pb: libpb.dylib

## Directory

- lualib: lua source
- lua: entry point to lua
- luac: entry point to luac
- lua-protobuf: lua-protobuf source


## Q&A

### macOS

#### 1 dyld: Library not loaded: /usr/local/lib/libluaDLL.dylib

Put `lua`、`libluaDLL.dylib` in same directory, run `./lua`, get `dyld: Library not loaded: /usr/local/lib/libluaDLL.dylib` error.

There are two solution:

1. put `lialuaDLL.dylib` to `/usr/local/lib/`:

    ```sh
    cp libluaDLL.dylib /usr/local/lib/libluaDLL.dylib
    ```

2. change reference path：

    ```sh
    install_name_tool -change /usr/local/lib/libluaDLL.dylib @executable_path/libluaDLL.dylib lua
    ```

#### 2 `pb` not found

```lua
test.lua:3: module 'pb' not found:
    no field package.preload['pb']
    no file '/usr/local/share/lua/5.3/pb.lua'
    no file '/usr/local/share/lua/5.3/pb/init.lua'
    no file '/usr/local/lib/lua/5.3/pb.lua'
    no file '/usr/local/lib/lua/5.3/pb/init.lua'
    no file './pb.lua'
    no file './pb/init.lua'
    no file '/usr/local/lib/lua/5.3/pb.so'
    no file '/usr/local/lib/lua/5.3/loadall.so'
    no file './pb.so'
stack traceback:
    [C]: in function 'require'
    test.lua:3: in main chunk
    [C]: in ?
```

There are two solution:

1. change `libpb.dylib` name to `pb.so`

2. change `package.cpath` to `/usr/local/lib/lua/5.3/?.so;/usr/local/lib/lua/5.3/loadall.so;./?.so;./?.dylib`
