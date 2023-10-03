winghc -XForeignFunctionInterface -c ../transpiler/src/UtilModule.hs -i../transpiler/src -o outW/util.o \d .
echo "util-b"

winghc -XForeignFunctionInterface -c ../transpiler/src/ColorsModule.hs -i../transpiler/src -o outW/color.o
echo "color-b"

winghc -XForeignFunctionInterface -c ../transpiler/src/DivStructModule.hs -i../transpiler/src -o outW/div.o
echo "div-b"

winghc -XForeignFunctionInterface -c ../transpiler/src/TokenizerModule.hs -i../transpiler/src -o outW/transpiler.o
echo "token-b"

winghc -XForeignFunctionInterface -c ../transpiler/src/DllApi.hs -i../transpiler/src -o outW/api.o
echo "api-built"

wine cross-x86_64-w64-mingw32-10.0.0_1 -c src\main.cpp -I..\..\..\..\..\usr\lib\ghc-9.0.2\include -o outW\main.o \d .
echo build-cpp

winghc -no-hs-main outW/util.o outW/color.o outW/div.o outW/transpiler.o outW/api.o outW/main.o -lstdc++ -o outW/app
