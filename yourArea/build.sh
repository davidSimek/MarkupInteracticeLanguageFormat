rm out/util.o
ghc -XForeignFunctionInterface -c ../transpiler/src/UtilModule.hs -i../transpiler/src -o out/util.o
echo "util-b"

rm out/color.o
ghc -XForeignFunctionInterface -c ../transpiler/src/ColorsModule.hs -i../transpiler/src -o out/color.o
echo "color-b"

rm out/div.o
ghc -XForeignFunctionInterface -c ../transpiler/src/DivStructModule.hs -i../transpiler/src -o out/div.o
echo "div-b"

rm out/transpiler.o
ghc -XForeignFunctionInterface -c ../transpiler/src/TokenizerModule.hs -i../transpiler/src -o out/transpiler.o
echo "token-b"

rm out/api.o
ghc -XForeignFunctionInterface -c ../transpiler/src/DllApi.hs -i../transpiler/src -o out/api.o
echo "api-built"

rm out/main.o
g++ -c src/main.cpp -I/usr/lib/ghc-9.0.2/include -o out/main.o
echo "build-cpp"

rm out/app
ghc -no-hs-main out/util.o out/color.o out/div.o out/transpiler.o out/api.o out/main.o -lstdc++ -o out/app
