#usr/bin/env bash

function run-remote-file() {
    bash <(curl -sSL  https://gitee.com/$1/raw/master/$2 || curl -sSL https://raw.githubusercontent.com/$1/master/$2 || "echo can't get $2 in $1")
}

function setup() {
    echo "Setup for linux"
    run-remote-file liszt21/lisux scripts/mirror-helper.sh
    run-remote-file liszt21/lisux scripts/setup-basic.sh
}

setup