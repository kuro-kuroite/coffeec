#!/usr/bin/env bash


# FIXME: どのディレクトリからでもcd APP_ROOT/bin/ に移動できるようにしたい 
# 現在は ROOT_APP からの実行(`./bin/coffeec.sh`)だけでも対処出来るように cd ./bin としている  
cd ./bin >& /dev/null 
cd ..


# FIXME: .babelrc に既に書き込まれているが，毎回初期化しても変わらないため残すこととする
echo '{ "presets": ["es2015"] }' > .babelrc

npx
npm install 
