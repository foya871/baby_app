#!/bin/bash

# 如果 ./build_apk.sh 执行不成功
# 先执行 chmod +x build_apk.sh

set -e  # 遇到错误立即退出

echo ">>>>>>>>> 开始运行 auto_assets.sh <<<<<<<<<"

# 进入 scripts 目录运行 auto_assets.sh
bash ./auto_assets.sh underscore
echo ">>>>>>>>> auto_assets 构建完成 <<<<<<<<<"

# 返回到项目根目录
cd ..

#echo ">>>>>>>>> 运行 dart run build_runner build --delete-conflicting-outputs <<<<<<<<<"
#
#dart run build_runner build --delete-conflicting-outputs
#echo ">>>>>>>>> build_runner build 构建完成 <<<<<<<<<"
#
#echo ">>>>>>>>> 开始清理 build 目录 <<<<<<<<<"
#
#BUILD_DIR="./build"
#
#if [ -d "$BUILD_DIR" ]; then
#  find "$BUILD_DIR" -type f ! -name "*.sh" -exec rm -f {} +
#  find "$BUILD_DIR" -type d -mindepth 1 -empty -delete
#  echo "build 目录清理完成，已保留 .sh 文件，且不会删除 build 目录"
#else
#  echo "build 目录不存在，无需清理"
#fi
#
#echo ">>>>>>>>> 清理完成 <<<<<<<<<"

echo ">>>>>>>>> 开始 build APK <<<<<<<<<"

flutter build apk

echo ">>>>>>>>> 打包完成 <<<<<<<<<"

echo ">>>>>>>>> 开始上传 APK 到远程服务器 <<<<<<<<<"

# 获取最新的 APK 文件路径
APK_FILE=$(find ./build/app/outputs/apk/release -type f -name "*.apk" | head -n 1)

if [ -z "$APK_FILE" ]; then
  echo ">>>>>>>>> 错误：未找到 APK 文件 <<<<<<<<<"
  exit 1
fi

# 获取 APK 文件名（用于远程服务器的目标文件名）
APK_NAME=$(basename "$APK_FILE")

# SCP 命令上传 APK 文件到远程服务器
scp -P 22335 "$APK_FILE" root@43.201.116.88:/fs/"$APK_NAME"

if [ $? -eq 0 ]; then
  echo ">>>>>>>>> APK 上传成功：http://43.201.116.88:/$APK_NAME <<<<<<<<<"
else
  echo ">>>>>>>>> APK 上传失败 <<<<<<<<<"
  exit 1
fi