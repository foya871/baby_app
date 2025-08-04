#!/bin/bash
###
 # @Author: wdz
 # @Date: 2025-04-14 10:52:14
 # @LastEditTime: 2025-07-18 17:02:35
 # @LastEditors: wdz
 # @Description: 
 # @FilePath: /baby_app/scripts/auto_create_keystore.sh
### 
#==========该脚本尚未测试是否可行===============
# 该脚本用于生成 Android 应用程序的密钥库，可以选择 JKS 或 PKCS#12 格式。
# 使用方法：
# 1: 将终端切换到当前目录。
# 2: 使用 chmod 命令使脚本可执行。如果在第 3 步骤遇到权限错误，请先执行以下命令：
#    运行：chmod +x auto_create_keystore.sh
# 3: 运行脚本并指定所需格式，支持以下三种方式：
# 4-1: 生成 JKS 格式的密钥库
#      运行：./auto_create_keystore.sh jks
# 4-2: 生成 PKCS#12 格式的密钥库
#      运行：./auto_create_keystore.sh pkcs12
# 4-3: 生成 JKS 格式的密钥库并迁移到 PKCS#12 格式
#      运行：./auto_create_keystore.sh jks migrate
#      在此模式下，脚本将首先创建一个 JKS 格式的密钥库，并随后将其迁移为 PKCS#12 格式。
#      在迁移过程中，用户需要提供以下密码：
#      - 目标密钥库口令：为新创建的 PKCS#12 密钥库设置的密码。
#      - 再次输入新口令：确认目标密钥库口令。
#      - 输入源密钥库口令：为 JKS 密钥库设置的密码（由脚本中定义的 KEYSTORE_PASSWORD 提供）。
#      - 输入 <my-key-alias> 的密钥口令：为指定密钥别名设置的密码（由脚本中定义的 KEY_PASSWORD 提供）。

# 检查输入参数的数量，确保至少提供一个参数
if [ "$#" -lt 1 ]; then
    echo "用法: $0 <format> [migrate]"
    echo "格式: jks 或 pkcs12，migrate 表示是否迁移到 PKCS#12 格式"
    exit 1
fi

# 从命令行参数获取格式和迁移选项
FORMAT=$1  # 第一个参数，指定密钥库的格式（可选值为 jks 或 pkcs12）
MIGRATE=$2 # 第二个参数，表示是否进行迁移到 PKCS#12 格式（可选）

# 定义相关变量
ANDROID_DIR="../android"  # 指定上一级目录中的 android 文件夹
KEYSTORE_NAME="$ANDROID_DIR/kkmh0718.jks" # 生成的 JKS 密钥库文件名
PKCS12_NAME="$ANDROID_DIR/kkmh0718.p12"  # 生成的 PKCS#12 格式密钥库文件名
KEY_ALIAS="kkmh0718"  # 密钥的别名
KEY_PASSWORD="kkmh0718"  # 密钥的密码
KEYSTORE_PASSWORD="kkmh0718"  # JKS 密钥库的密码
VALIDITY_YEARS=25  # 密钥的有效年限（以年为单位）

# 创建 android 目录（如果不存在）
mkdir -p $ANDROID_DIR

# 根据指定格式创建签名文件
if [ "$FORMAT" == "jks" ]; then
    # 使用 keytool 生成 JKS 格式的密钥库
    keytool -genkeypair -v -keystore $KEYSTORE_NAME -alias $KEY_ALIAS \
        -storetype JKS \
        -keyalg RSA -keysize 2048 -validity $((VALIDITY_YEARS * 365)) \
        -storepass $KEYSTORE_PASSWORD -keypass $KEY_PASSWORD \
        -dname "CN=Your Name, OU=Your Org, O=Your Company, L=Your City, S=Your State, C=Your Country"
elif [ "$FORMAT" == "pkcs12" ]; then
    # 使用 keytool 生成 PKCS#12 格式的密钥库
    keytool -genkeypair -v -keystore $KEYSTORE_NAME -alias $KEY_ALIAS \
        -keyalg RSA -keysize 2048 -validity $((VALIDITY_YEARS * 365)) \
        -storepass $KEYSTORE_PASSWORD -keypass $KEY_PASSWORD \
        -dname "CN=Your Name, OU=Your Org, O=Your Company, L=Your City, S=Your State, C=Your Country"
else
    # 如果提供的格式不支持，输出错误信息并退出
    echo "不支持的格式: $FORMAT"
    exit 1
fi

# 输出成功创建密钥库的消息
echo "签名文件 $KEYSTORE_NAME 创建成功！"

# 如果指定了迁移选项，执行迁移操作
if [ "$MIGRATE" == "migrate" ]; then
    # 使用 keytool 将 JKS 密钥库迁移到 PKCS#12 格式
    keytool -importkeystore -srckeystore $KEYSTORE_NAME -destkeystore $PKCS12_NAME -deststoretype pkcs12
    echo "已将 $KEYSTORE_NAME 迁移到 $PKCS12_NAME (PKCS#12 格式)！"
fi
