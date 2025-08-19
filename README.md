# Clash Rules - 网络代理规则配置

这是一个为 [Clash](https://github.com/Dreamacro/clash) 设计的网络代理规则配置文件集合，提供智能分流和网络访问优化。

## 📋 项目简介

Clash Rules 是一个开源的网络代理规则配置项目，专门为需要访问国际服务、区块链应用、AI 工具和开发工具的用户设计。通过智能分流规则，确保不同类型的网络请求能够通过最合适的代理路径。

## 📁 文件结构

```bash
clash-rules/
├── README.md          # 项目说明文档
├── auto.yaml          # 自动分流规则配置文件（包含大量域名规则）
├── select.yaml        # 选择性代理规则（GitHub、Discord、Telegram 等）
├── openai.yaml        # AI 工具代理规则（ChatGPT、Cursor 等）
└── cspell.json        # 拼写检查配置
```

## 🔧 配置文件说明

### `auto.yaml` - 自动分流规则

包含大量预定义的域名规则，涵盖：

- 区块链和加密货币服务
- 开发工具和平台
- 国际新闻和媒体
- 云服务和基础设施
- 教育和学习平台

### `select.yaml` - 选择性代理

针对特定服务和应用的代理规则：

- GitHub 相关服务
- Discord 应用
- Telegram 应用

### `openai.yaml` - AI 工具代理

专门为 AI 工具设计的代理规则：

- ChatGPT 应用
- Cursor 编辑器

## 📖 使用方法

### 1. 安装 Clash

首先确保您的系统已安装 Clash 客户端：

- **macOS**: 下载 [ClashX Pro](https://github.com/yichengchen/clashX) 或 [Clash for Windows](https://github.com/Fndroid/clash_for_windows_pkg)
- **Windows**: 下载 [Clash for Windows](https://github.com/Fndroid/clash_for_windows_pkg)
- **Linux**: 使用包管理器安装或下载预编译版本

### 2. 配置规则文件

1. 将需要的规则文件复制到 Clash 配置目录
2. 在 Clash 配置中引用这些规则文件
3. 重启 Clash 服务

### 3. 配置示例

在您的 Clash 配置文件中添加：

```yaml
rules:
  - RULE-SET,auto,PROXY
  - RULE-SET,select,PROXY
  - RULE-SET,openai,PROXY
  - MATCH,DIRECT

rule-providers:
  auto:
    type: http
    behavior: domain
    url: "https://raw.githubusercontent.com/phenix3443/clash-rules/main/auto.yaml"
    path: ./auto.yaml
    interval: 3600
  select:
    type: http
    behavior: domain
    url: "https://raw.githubusercontent.com/phenix3443/clash-rules/main/select.yaml"
    path: ./select.yaml
    interval: 3600
  openai:
    type: http
    behavior: domain
    url: "https://raw.githubusercontent.com/phenix3443/clash-rules/main/openai.yaml"
    path: ./openai.yaml
    interval: 3600
```

## 🚀 特性

- **智能分流**: 根据域名和进程名自动选择代理路径
- **模块化设计**: 可按需选择不同的规则集
- **实时更新**: 支持远程规则更新
- **广泛覆盖**: 涵盖主流国际服务和开发工具
- **易于维护**: 清晰的规则分类和结构

## 🔄 更新和维护

项目会定期更新规则文件，添加新的域名和服务。建议：

- 定期拉取最新的规则文件
- 关注 GitHub 上的更新通知
- 根据个人需求自定义规则

## ⚠️ 免责声明

- 本项目仅提供网络代理规则配置，不提供代理服务器
- 请确保您遵守当地法律法规
- 使用代理服务时请注意网络安全和隐私保护
- 请合理使用网络资源，遵守相关服务条款

## 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

## 🔗 相关链接

- [Client for clash](https://github.com/phenix3443/Clash)
- [Clash 知识库](https://clash.wiki/)
- [clash rules](https://github.com/Loyalsoldier/clash-rules)

## 🤝 贡献

欢迎提交 Issue 和 Pull Request 来改进这个项目！

## 📞 联系方式

如果您有任何问题或建议，请通过以下方式联系：

- 提交 [GitHub Issue](https://github.com/phenix3443/clash-rules/issues)
- 发送邮件至：[phenix3443@gmail.com]

---

⭐ 如果这个项目对您有帮助，请给我们一个星标！
