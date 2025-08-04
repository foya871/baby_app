#! /bin/bash

set -e
#set -x

# ./build_web.sh --debug
# ./budild_web.sh

MODE=$1

# 默认全都release
RELEASE_MODE=1
if [ "$MODE" == "--debug" ]; then
  RELEASE_MODE=
fi

DART_COMPILE_OPT=
if [ -n "$RELEASE_MODE" ]; then
  DART_COMPILE_OPT="-O2 --no-source-maps"
fi

cd ..
ROOT_DIR=$(pwd)
cd -

flutter clean

./auto_assets.sh

WEB_DIR=$ROOT_DIR/web
WEB_BUILD_DIR=$ROOT_DIR/build/web

rm -rf ${WEB_DIR}/*.dart.js*

dart compile js ${WEB_DIR}/sw.dart $DART_COMPILE_OPT -o ${WEB_DIR}/sw.dart.js

flutter build web

sed -i '' "/^const CORE =/i\\
importScripts('sw.dart.js');
" "$WEB_BUILD_DIR/flutter_service_worker.js"

sed -i '' '/self.addEventListener("fetch"/a\
  if(self.__interceptor && self.__interceptor(event)) return;
' "$WEB_BUILD_DIR/flutter_service_worker.js"

# release mode
if [ -n "$RELEASE_MODE" ]; then
    # 删除dart
    rm -f $WEB_BUILD_DIR/*.dart
    # 删除 *.dart.js.deps
    rm -f $WEB_BUILD_DIR/*.dart.js.deps
fi
