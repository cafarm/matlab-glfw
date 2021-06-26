#!/usr/bin/env bash

case "$(uname -s)" in
Linux)
    mw_arch='glnxa'
    ;;
Darwin)
    mw_arch='maci'
    ;;
CYGWIN*|MINGW32*|MSYS*|MINGW*)
    mw_arch='win'
    ;;
esac

case "$(uname -m)" in
*64)
    mw_arch+='64'
    ;;
*)
    mw_arch+='32'
    ;;
esac

# Compile GLFW from source
# You may need to pre-install some deps before this will work
# See: https://www.glfw.org/docs/latest/compile.html#compile_deps
git clone --depth 1 --branch 3.3.4 https://github.com/glfw/glfw.git
cd glfw
cmake -DCMAKE_INSTALL_PREFIX=../deps/glfw/${mw_arch} -DBUILD_SHARED_LIBS=ON -DCMAKE_OSX_ARCHITECTURES='arm64;x86_64' .
cmake --build . --target install