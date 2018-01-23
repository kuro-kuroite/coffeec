#!/usr/bin/env bash


# FIXME: どのディレクトリからでもcd APP_ROOT/bin/ に移動できるようにしたい 
# 現在は ROOT_APP からの実行(`./bin/coffeec.sh`)だけでも対処出来るように cd ./bin としている  
cd ./bin >& /dev/null 
cd ..


# rm cache for #2 (https://github.com/kuro-kuroite/coffeec/issues/2)
rm -rf ./lib/**/*

npx coffee --output ./lib/es6/ --compile --bare --no-header ./src >& /dev/null
npx babel ./lib/es6 --out-file lib/es5/script_compiled.js >& /dev/null

npx ts2c ./lib/es5/script_compiled.js >& /dev/null
# FIXME: mv をなくすように，ts2c で任意のディレクトリ出力ができないのか
mv ./lib/es5/script_compiled.c ./lib/c/

gcc ./lib/c/script_compiled.c
# FIXME: mv をなくすように，gcc で任意のディレクトリ出力ができないのか
mv ./a.exe ./lib/exe/


./lib/exe/a.exe
