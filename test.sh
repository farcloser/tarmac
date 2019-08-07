#!/usr/bin/env bash

readonly expected="$1"

echo "Testing unattended forced install"

POSH_CASK="" POSH_TMP="" POSH_BIN="" POSH_TOKEN="" TARMAC_FORCE_INSTALL=true ./init

# shellcheck source=/dev/null
. ~/.profile

if [ "$(command -v brew)" != "$expected/Applications/bin/homebrew/bin/brew" ]; then
  echo "brew installation failed - output of command -v brew: $(command -v brew)"
  exit 1
fi

echo "Homebrew installation Successful"

shellcheck -a -x "./test.sh"
shellcheck -a -x "./init"

echo "Shellcheck successful"
