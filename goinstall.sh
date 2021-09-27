#!/usr/bin/env bash
set -e

if [[ $(id -u) -eq 0 ]]; then
    echo "Please do not run this script using sudo or as root user."
    exit 1
fi

VERSION=${VERSION:-1.17.1}
# URL=${URL:-"https://golang.org/dl"}
URL=${URL:-"https://gomirrors.org/dl/go"}
FILE="go${VERSION}.linux-amd64.tar.gz"
GOPATH=${GOPATH:-"$HOME/.go"}
GOROOT="/usr/local/go"

wget -c ${URL}/${FILE}
# HASH=`shasum -a 256 ${FILE}`
sudo rm -rf ${GOROOT} && sudo tar -C /usr/local -xzf ${FILE}

setPath() {
    CO='\033[1;33m'
    NC='\033[0m' # No Color
    if ! grep -q 'GOPATH' $HOME/$1 ; then
        echo -e "export PATH=\$PATH:${GOROOT}/bin:${GOPATH}/bin" >> $HOME/$1
        echo -e "export GOPATH=${GOPATH}" >> $HOME/$1
        echo -e "Please execute ${CO}source ~/$1${NC} first."
    fi
}

if [[ -d "${GOPATH}" ]]; then
    echo "Go has switched to version $VERSION"
else
    echo "Installing Go version $VERSION"
    mkdir -p ${GOPATH}
fi

if [[ $SHELL = *bash* ]]; then
    setPath ".bashrc"
elif [[ $SHELL = *zsh* ]]; then
    setPath ".zshrc"
fi

if [[ -f "${GOROOT}/bin/go" ]]; then
    `${GOROOT}/bin/go env -w GO111MODULE=on`
    `${GOROOT}/bin/go env -w GOPROXY=https://goproxy.cn,direct`

    echo "GOPATH=$GOPATH"
    echo "GOROOT=$GOROOT"
else
    echo "Go installation failed."
    exit 1
fi
