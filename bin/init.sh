#!/usr/bin/env bash


# FIXME: どのディレクトリからでもcd APP_ROOT/bin/ に移動できるようにしたい 
# 現在は ROOT_APP からの実行(`./bin/coffeec.sh`)だけでも対処出来るように cd ./bin としている  
cd ./bin >& /dev/null 
cd ..


npm init -y

npm install --save-dev coffeescript && coffee -v

npm install --save-dev babel-cli
npm install --save-dev babel-preset-es2015

echo '{ "presets": ["es2015"] }' > .babelrc

npm install --save-dev ts2c

npx
npm install 
