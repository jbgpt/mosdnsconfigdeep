# mosdnsconfigdeep
deepseek生成的配置mosdns
# 赋予脚本执行权限
chmod +x /etc/mosdns/update-rules.sh

# 添加 crontab 任务
(crontab -l ; echo "0 3 * * * /etc/mosdns/update-rules.sh") | crontab -
