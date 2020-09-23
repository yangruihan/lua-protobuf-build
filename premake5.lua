workspace "LuaProtobuf"
    configurations { "Debug32", "Release32", "Debug64", "Release64" }

    filter "configurations:*32"
       architecture "x86"
 
    filter "configurations:*64"
       architecture "x86_64"

    flags
    {
        "MultiProcessorCompile"
    }

    filter "system:windows"
        systemversion "latest"
        location "build/windows"

    filter "system:macosx"
        location "build/macos"

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

group ""

project "luaDLL"
    kind "SharedLib"
    language "c"
    cdialect "c99"
    staticruntime "on"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    files
    {
        "./lualib/*.h",
        "./lualib/*.c",
    }

    defines
    {
        "_CRT_SECURE_NO_WARNINGS",
    }

    includedirs
    {
        "./lualib"
    }

    filter "system:windows"
        systemversion "latest"
        location "build/windows"

        defines { "LUA_BUILD_AS_DLL" }

    filter "system:macosx"
        location "build/macos"

    filter "configurations:Debug"
        runtime "Debug"
        symbols "on"

    filter "configurations:Release"
        runtime "Release"
        optimize "on"

    filter "configurations:Dist"
        runtime "Release"
        optimize "on"

    filter { "system:windows", "configurations:Release" }
        buildoptions "/MT"

project "luaLib"
    kind "StaticLib"
    language "c"
    cdialect "c99"
    staticruntime "on"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    files
    {
        "./lualib/*.h",
        "./lualib/*.c",
    }

    defines
    {
        "_CRT_SECURE_NO_WARNINGS",
    }

    includedirs
    {
        "./lualib"
    }

    filter "system:windows"
        systemversion "latest"
        location "build/windows"

    filter "system:macosx"
        location "build/macos"

    filter "configurations:Debug"
        runtime "Debug"
        symbols "on"

    filter "configurations:Release"
        runtime "Release"
        optimize "on"

    filter "configurations:Dist"
        runtime "Release"
        optimize "on"

    filter { "system:windows", "configurations:Release" }
        buildoptions "/MT"


project "lua"
    kind "ConsoleApp"
    language "c"
    cdialect "c99"
    staticruntime "on"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    files
    {
        "./lua/*.h",
        "./lua/*.c",
    }

    links
    {
        "luaDLL"
    }

    defines
    {
        "_CRT_SECURE_NO_WARNINGS",
    }

    includedirs
    {
        "./lualib"
    }

    filter "system:windows"
        systemversion "latest"
        location "build/windows"

        defines { "LUA_BUILD_AS_DLL" }

    filter "system:macosx"
        location "build/macos"

    filter "configurations:Debug"
        runtime "Debug"
        symbols "on"

    filter "configurations:Release"
        runtime "Release"
        optimize "on"

    filter "configurations:Dist"
        runtime "Release"
        optimize "on"

    filter { "system:windows", "configurations:Release" }
        buildoptions "/MT"

project "luac"
    kind "ConsoleApp"
    language "c"
    cdialect "c99"
    staticruntime "on"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    files
    {
        "./luac/*.h",
        "./luac/*.c",
    }

    links
    {
        "luaLib"
    }

    defines
    {
        "_CRT_SECURE_NO_WARNINGS",
    }

    includedirs
    {
        "./lualib"
    }

    filter "system:windows"
        systemversion "latest"
        location "build/windows"

    filter "system:macosx"
        location "build/macos"

    filter "configurations:Debug"
        runtime "Debug"
        symbols "on"

    filter "configurations:Release"
        runtime "Release"
        optimize "on"

    filter "configurations:Dist"
        runtime "Release"
        optimize "on"

    filter { "system:windows", "configurations:Release" }
        buildoptions "/MT"

project "pb"
    kind "SharedLib"
    language "c"
    cdialect "c99"
    staticruntime "on"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    files
    {
        "./lua-protobuf/*.h",
        "./lua-protobuf/*.c",
    }

    links
    {
        "lualib"
    }

    defines
    {
        "_CRT_SECURE_NO_WARNINGS",
    }

    includedirs
    {
        "./lua-protobuf",
        "./lualib"
    }

    filter "system:windows"
        systemversion "latest"
        location "build/windows"

        defines { "LUA_BUILD_AS_DLL" }

    filter "system:macosx"
        location "build/macos"

    filter "configurations:Debug"
        runtime "Debug"
        symbols "on"

    filter "configurations:Release"
        runtime "Release"
        optimize "on"

    filter "configurations:Dist"
        runtime "Release"
        optimize "on"

    filter { "system:windows", "configurations:Release" }
        buildoptions "/MT /O2 /LD"
