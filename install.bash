#!/usr/bin/env bash

set -e

RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'


echo_red() {
	echo -e "${RED}$1${NC}"
}

echo_blue() {
	echo -e "${BLUE}$1${NC}"
}

if [ "$EUID" -ne 0 ]; then
	echo_red "Please run script as root"
	exit 1
fi


APP_VERSION="0.4"
APP_DIR="/opt/libvirt-starter/v$APP_VERSION/"

echo_blue "Removing app dir"
rm -rf $APP_DIR

echo_blue "Creating app dir"
install \
	--directory \
	--group root \
	--owner root \
	--mode 755 \
		$APP_DIR


echo_blue "Copying whl"
install \
	--owner root \
	--group root \
		./dist/libvirt_starter-$APP_VERSION-py3-none-any.whl $APP_DIR
install \
	--owner root \
	--group root \
		./dist/libvirt-starter-$APP_VERSION.tar.gz $APP_DIR

pushd $APP_DIR > /dev/null

echo_blue "Creating venv"
python3 -m venv ./venv

echo_blue "Activating venv"
source ./venv/bin/activate

echo_blue "Install whl"
pip install ./*.whl

echo_blue "Linking app to PATH"
ln --symbolic --force "$APP_DIR""venv/bin/libvirt-starter" /usr/local/bin/libvirt-starter

echo_blue "Installation complete"
