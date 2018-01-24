# How to construct coffee2 to c converter (Windows版)


## C 言語へコンパイルする coffeescript2 環境を作る


### 目的
* coffeescript2 から C言語を生成することで，C言語の罠にはまらずに実行速度を上げていく試み
* プログラム初学者はC, Javaを学習することが多いが，ポインタ(参照)，構造体(クラス)，ASTなど深い部分まで学ぶことは少ない．そこで，別言語からこうした概念を使用したC, Javaソースを生成することで，AltJSならではのプログラム言語の変換の可能性を体感していく
* anything lang to another lang via javascript を実現することで任意の言語から別言語への橋渡しとしていく

### 具体的なプログラム言語変換の流れ

1. 下記に従ったプロジェクトのフォルダ群を生成
1. coffeescript2 のソースを書く
1. transpile from coffeescript2 -> ECMAscript6 -> ECMAscript5 -> c99

### 言語変換ツール

* coffee
* Babel
* ts2c
* gcc

#### 依存するツール
* scoop
* git Bash
* npm

### 環境構築(coffeec 版)

1. coffeecを`git clone` する
    ```Bash
    $ git clone https://github.com/kuro-kuroite/coffeec.git .
    ```

    git が入っていない場合 [coffeec](https://github.com/kuro-kuroite/coffeec/archive/master.zip) からzip ファイルをダウンロードする

1. Powershell の実行権限を追加する
    ```Powershell
    > set-executionpolicy unrestricted -s cu
    ```

1. ./bin/build_env.ps1 をPowershell にドラッグ & ドロップ または 「右クリック > 編集 >> F5」 で実行し，coffeecを動かすツールをコンピュータにインストールする
    ```Powershell
    > cd ${APP_ROOT}
    > ./bin/build_env.ps1
    ```

1. `git bash` で開いて，APP_ROOT(coffeec のルート)まで`cd` で移動する
    ```Powershell
    > git bash
    ```

    ```Bash
    $ cd ${APP_ROOT}
    ```

1. init.sh で C 言語への変換ツールを「coffeec プロジェクト」に追加する
    ```Bash
    $ pwd
    ${APP_ROOT}
    $ ./bin/init.sh
    ```

### coffeescript2 から C 言語への変換

1. APP_ROOT or APP_ROOT/bin に移動
    ```Bash
    $ cd ${APP_ROOT}
    ```

1. coffeec スクリプトの実行
    ```Bash
    $ pwd
    ${APP_ROOT}
    $ ./bin/coffeec.sh
    ```

    または，
    ```Bash
    $ pwd
    ${APP_ROOT}/bin
    $ ./coffeec.sh
    ```

本工程で./lib/c/script_compiled.c と ./lib/exe/a.exe をcoffeescript2 から生成


## TL; DR coffeec の内部動作

以下は，build_env.ps1, init.sh, coffeec.sh で行う処理が書かれている

### 環境構築(スタンドアロン 版)

1. Powershell で scoop のインストール
    ```Powershell
    > set-executionpolicy unrestricted -s cu
    > iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
    > exit
    ```

1. Powershell で Git Bash をインストール
    ```Powershell
    > scoop install git
    ```

1. Git Bash で scoop コマンドを有効化
    ```Bash
    $ scoop_command="function scoop() {  powershell -ex unrestricted scoop.ps1 \"\$@\" ;} && export -f scoop"

    # TODO: .bashrc に ${scoop_command} があれば，skipするようにしたい
    # 二重に記述されるのを防ぐ目的
    $ echo ${scoop_command} >> ~/.bashrc
    $ source ~/.bashrc
    ```

1. Git Bash で nodejsのインストール
    ```Bash
    $ scoop install nvm
    $ nvm install && node -v
    ```

1. 任意のプロジェクトを作る
    ```Bash
    $ mkdir hoge_project && cd $_
    $ npm init -y
    ```

1. coffeescript2 のインストール
    ```Bash
    $ npm install --save-dev coffeescript && coffee -v
    ```

1. Babel のインストール
    ```Bash
    $ npm install --save-dev babel-cli
    $ npm install --save-dev babel-preset-es2015
    ```

1. ES6 to ES5 に設定
    ```Bash
    $ echo '{ "presets": ["es2015"] }' >> .babelrc
    ```

1. ts2c のインストール
    ```Bash
    $ npm install --save-dev ts2c
    ```

1. gcc のインストール
    ```Bash
    $ scoop install gcc
    ```
1. npxを有効化
    ```Bash
    $ npx
    ```

#### coffeescript2 開発から C 変換の流れ

1. 作業フォルダの作成
    ```Bash
    $ mkdir src lib
    $ mkdir lib/es6 lib/es5 lib/c lib/exe
    ```

1. coffee script 群を ./src 内に作成
    ```Bash
    $ ls ./src
    index.coffee
    SampleClass.coffee
    ChildClass.coffee
    ```

1. lib ディレクトリ内にあるファイルから，余計に生成されないように全て除去する
    ```Bash
    $ rm -rf ./lib/**/*
    ```

1. coffee to c
    ```Bash
    $ npx coffee --output ./lib/es6/ --compile --bare --no-header ./src
    $ npx babel ./lib/es6 --out-file lib/es5/script_compiled.js
    $ npx ts2c ./lib/es5/script_compiled.js
    $ mv ./lib/es5/script_compiled.c ./lib/c/
    ```

1. gcc compile
    ```Bash
    $ gcc ./lib/c/script_compiled.c
    $ mv ./a.exe ./lib/exe/
    ```
