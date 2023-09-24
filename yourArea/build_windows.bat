ghc -XForeignFunctionInterface -c ../transpiler/src/UtilModule.hs -i../transpiler/src -o outW/util.o
echo "util-b"

ghc -XForeignFunctionInterface -c ../transpiler/src/ColorsModule.hs -i../transpiler/src -o outW/color.o
echo "color-b"

ghc -XForeignFunctionInterface -c ../transpiler/src/DivStructModule.hs -i../transpiler/src -o outW/div.o
echo "div-b"

ghc -XForeignFunctionInterface -c ../transpiler/src/TokenizerModule.hs -i../transpiler/src -o outW/transpiler.o
echo "token-b"

ghc -XForeignFunctionInterface -c ../transpiler/src/DllApi.hs -i../transpiler/src -o outW/api.o
echo "api-built"

g++ -c src\main.cpp -I..\..\..\..\..\usr\lib\ghc-9.0.2\include -o outW\main.o
echo build-cpp

ghc -no-hs-main outW/util.o outW/color.o outW/div.o outW/transpiler.o outW/api.o outW/main.o -lstdc++ -o outW/app
