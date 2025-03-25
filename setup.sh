#!/bin/bash

set -e

echo "🛠️ 更新系统依赖..."
sudo apt update
sudo apt install -y curl git build-essential pkg-config libssl-dev

# 安装 Rust（如果尚未安装）
if ! command -v cargo &> /dev/null; then
  echo "🦀 安装 Rust 和 Cargo..."
  curl https://sh.rustup.rs -sSf | sh -s -- -y
  source "$HOME/.cargo/env"
else
  echo "✅ Rust 已安装"
fi

# 安装 soundnessup
echo "📦 安装 soundnessup 工具..."
curl -sSL https://raw.githubusercontent.com/soundnesslabs/soundness-layer/main/soundnessup/install | bash

# 加载 ~/.bashrc
echo "🔄 刷新 bash 配置..."
source ~/.bashrc

# 安装 CLI 核心功能
echo "⚙️ 安装 Soundness CLI 核心组件..."
soundnessup install

# 生成密钥对
KEY_NAME="my-key"
echo "🔐 生成密钥对：$KEY_NAME"
soundness-cli generate-key --name "$KEY_NAME"

# 显示所有密钥并提取 base64 公钥
echo "📋 获取 base64 编码的公钥..."
soundness-cli list-keys

echo -e "\n🎉 安装和配置完成！"
echo "👉 请复制上方的 base64 公钥，去 Discord 的 #testnet-access 频道发送如下命令："
echo "!access <你的 base64 公钥>"
