# mosdnsconfigdeep
deepseek生成的配置mosdns
# 赋予脚本执行权限
chmod +x /etc/mosdns/update-rules.sh

# 添加 crontab 任务
(crontab -l ; echo "0 3 * * * /etc/mosdns/update-rules.sh") | crontab -
4. 配置文件说明**

#### **功能分解**：
1. **广告拦截**：  
   - 使用 [StevenBlack/hosts](https://github.com/StevenBlack/hosts) 规则列表，命中后返回 `0.0.0.0`。

2. **国内域名分流**：  
   - 匹配 `geosite:cn` 列表（国内域名），转发至 `114.114.114.114`。

3. **国外域名解析**：  
   - 默认使用 OpenDNS 和 Google DNS（支持 DoT/DoH）。

4. **流媒体加速**：  
   - 匹配流媒体域名（如 Netflix/YouTube），使用优化 DNS（示例为 Cloudflare 和 Snopyta）。

5. **自动更新**：  
   - 每日凌晨 3 点更新规则文件并重启 mosdns。

---

### **5. 验证与测试**

#### **检查配置语法**：
```bash
mosdns validate -c /etc/mosdns/config.yaml
```

#### **测试域名解析**：
```bash
# 测试广告域名（应返回 0.0.0.0）
dig @localhost ads.example.com

# 测试国内域名（如 qq.com）
dig @localhost qq.com

# 测试流媒体域名（如 netflix.com）
dig @localhost netflix.com
```

#### **查看日志**：
```bash
journalctl -u mosdns -f
```

---

### **6. 性能优化建议**
1. **精简规则文件**：  
   - 删除注释行（如 `sed -i '/^#/d' adblock.txt`）。

2. **启用缓存**：  
   - 配置文件已包含 `cache` 插件，显著减少重复查询。

3. **按需调整 DNS 服务器**：  
   - 替换 `streaming_dns` 中的地址为本地网络更快的 DNS（如运营商提供的高速 DNS）。

---

### **7. 扩展功能**
- **增加恶意域名拦截**：  
  添加 [malware-domains](https://github.com/malware-domains) 规则到 `ad_block` 插件。
- **按设备分流**：  
  结合 `metadata` 插件标记设备 IP，实现更复杂的分流逻辑。

---
