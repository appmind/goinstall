# Goinstall

一个用于安装 Go 语言环境的 bash 脚本。

支持断点续传，支持通过重装实现简单的多版本切换。

## 安裝或更新 Golang

```sh
$ bash <(curl -L https://raw.githubusercontent.com/appmind/goinstall/master/goinstall.sh)

# 执行 . ~/.bashrc 或 . ~/.zshrc
$ go version
```

## 定制安装或更新

使用环境变量设置 Golang 版本和 GOPATH。

```sh
$ gh repo clone appmind/goinstall # or
$ git clone https://github.com/appmind/goinstall.git

$ cd goinstall
# 指定安装的 Golang 版本和 GOPATH 位置
$ GOPATH=~/go VERSION=1.17.1 ./goinstall.sh

# 执行 . ~/.bashrc 或 . ~/.zshrc
$ go version
```

## 测试脚本

创建 Docker 镜像，使用容器测试脚本。

```sh
docker build -t goinstall .
docker run -d -p 22:22 goinstall

# ssh登录测试容器，密码 test
ssh test@localhost
```
