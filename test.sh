#!/usr/bin/env bash
set -o errexit -o errtrace -o functrace -o nounset -o pipefail

# Linting
# shellcheck source=tooling/helpers.sh
. "$(cd "$(dirname "${BASH_SOURCE[0]:-$PWD}")" 2>/dev/null 1>&2 && pwd)"/tooling/helpers.sh

logger::info "Linting"
lint::shell init ./*.sh ./*/*.sh
logger::info "Linting successful"

logger::info "Testing unattended forced install"

# Installation test
expected="$*"

POSH_CASK="" POSH_TMP="" POSH_BIN="" POSH_TOKEN="" TARMAC_FORCE_INSTALL=true ./init

# Brew completion script will fail with our level of erroring, so, deactivate it.
export POSH_BREW_COMPLETION=true
# shellcheck source=/dev/null
. "$HOME"/.posh_brew

if [ "$(command -v brew)" != "$expected/Applications/bin/homebrew/bin/brew" ]; then
  logger::error "brew installation failed - expected: $expected - command -v brew: $(command -v brew)"
  exit 1
fi

logger::info "Homebrew installation successful"
