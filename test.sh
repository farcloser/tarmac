#!/usr/bin/env bash

echo "Testing unattended forced install"

POSH_CASK="" POSH_TMP="" POSH_BIN="" POSH_TOKEN="" TARMAC_FORCE_INSTALL=true ./init
# shellcheck source=/dev/null
. ~/.profile
[ "$(command -v brew)" == "/Users/travis/Applications/bin/homebrew/bin/brew" ] || exit 1

echo "Successful"

shellcheck -a -x "./test.sh"
shellcheck -a -x "./init"
