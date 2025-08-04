#! /bin/bash
###
# @Author: wangdazhuang
# @Date: 2024-09-02 09:11:51
 # @LastEditTime: 2025-01-15 15:52:11
 # @LastEditors: ziqi jhzq12345678
# @Description:
# @FilePath: /baby_app/scripts/launch_web_proxy.sh
###

set -e

launch_mode=$1
local_port=5268
problem_key=Error
web_proxy_json=.web_proxy.json

ensure_cmd() {
    cmd=$1
    path=$(which $cmd)
    code=$?
    if [ "$code" != "0" ]; then
        echo "$problem_key:$cmd not found, pls install, $path"
        exit 1
    else
        echo $path
    fi
}

netstat_path=$(ensure_cmd netstat)
nohup_path=$(ensure_cmd nohup)

check_port_in_use() {
    listening=$($netstat_path -an | grep LISTEN | grep tcp4 | grep "$local_port")
    echo $listening
}

kill_pid_running() {
    local name=$1
    ps aux | grep "$1" | grep -v "grep" | awk '{print $2}' | xargs kill
}

write_json() {
    echo \{\"__WEB_PROXY_ADDRESS__\":\"http://$1\"\} >$web_proxy_json
}

kill_pid_running "porxy.dart"

rm -f $web_proxy_json

local_ip=$(ifconfig | grep inet | grep "192.168" | awk '{print $2}')

if [ -z "$local_ip" ]; then
    echo "$problem_key fail to find local ip address."
    exit 1
fi

local_address=$local_ip:$local_port

if [ "$launch_mode" = "vscode" ]; then
    echo "Prepare to Start Proxy <VSCODE> mode At $local_address."
    $nohup_path dart run ./lib/env/porxy.dart --host $local_ip --port $local_port >/dev/null 2>&1 &
    check_count=10
    for ((i=1; i<=$check_count; i++))
    do
        sleep 1
        listening=$(check_port_in_use)
        if [ -z "$listening" ]; then
            echo "check listening $local_port count:$i"
            if [[ "$i" -eq $check_count ]]; then
                echo "Proxy Failed At: $local_address"
                exit 1
            fi
        else
            write_json $local_address
            echo "Proxy Started At: $local_address"
            break
        fi
    done
else
    echo "Prepare to Start Proxy <FORGROUND> Mode At $local_address."
    write_json $local_address
    dart run ../lib/env/porxy.dart --host $local_ip --port $local_port
fi
