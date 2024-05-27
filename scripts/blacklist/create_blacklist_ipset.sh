#!/bin/bash
# 脚本当前地址
readonly script_dir=$(cd "$(dirname $0)" && pwd)
# 刚才下载的只有ipv4的黑名列表
# 设置IP列表文件路径
IP_LIST_FILE="${script_dir}/blackips.txt"

# 设置ipset的名称
IPSET_NAME="my_blacklist"
if which ipset > /dev/null; then
    # 检查ipset是否已存在，如果不存在则创建
    if ! ipset list | grep -q "$IPSET_NAME"; then
        ipset create $IPSET_NAME hash:net maxelem 1000000
    fi

    if [ -s "$IP_LIST_FILE" ]; then
        # 清空ipset中的旧IP
        ipset flush $IPSET_NAME

        # 读取IP列表文件并添加到ipset
        while IFS= read -r ip; do
            ipset add $IPSET_NAME $ip
        done < "$IP_LIST_FILE"

        echo "IP列表更新成功"
    else
        echo "IP列表文件不存在"
    fi
fi