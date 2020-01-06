#!/usr/bin/env bash
set -o errexit -o errtrace -o functrace -o nounset -o pipefail

# Linting
. tooling/helpers.sh
lint::shell init ./*.sh ./*/*.sh
>&2 printf "Linting successful\n"

# Installation test
expected="$*"

>&2 printf "Testing unattended forced install"

POSH_CASK="" POSH_TMP="" POSH_BIN="" POSH_TOKEN="" TARMAC_FORCE_INSTALL=true ./init

# shellcheck source=/dev/null
. ~/.profile

if [ "$(command -v brew)" != "$expected/Applications/bin/homebrew/bin/brew" ]; then
  >&2 printf "brew installation failed - expected: %s - command -v brew: %s\n" "$expected" "$(command -v brew)"
  exit 1
fi

>&2 printf "Homebrew installation successful\n"
