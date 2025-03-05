#!/bin/bash
# 自动更新规则脚本

# 创建规则目录
mkdir -p /etc/mosdns/rules/

# 下载规则列表
wget -O /etc/mosdns/rules/adblock.txt https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
wget -O /etc/mosdns/rules/streaming.txt https://raw.githubusercontent.com/geekdada/mosdns-geo/rule/geolocation-streaming.txt
wget -O /etc/mosdns/rules/geosite-cn.txt https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/geosite/cn.txt

# 清理无效格式（可选：将 AdGuard 规则转为纯域名）
sed -i 's/||//g; s/\^//g' /etc/mosdns/rules/adblock.txt

# 重启 mosdns
systemctl restart mosdns#updata
