#!/usr/bin/env bash
set -o errexit -o errtrace -o functrace -o nounset -o pipefail
# ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★
# (c) 2024 Farcloser <apostasie@farcloser.world>
# Distributed under the terms of the MIT license
# ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★

root="$(cd "$(dirname "${BASH_SOURCE[0]:-$PWD}")" 2>/dev/null 1>&2 && pwd)"
readonly root

. "$root"/lib/log.sh
. "$root"/lib/utils.sh

log::info "Testing unattended forced install"

# The install goes into a throwaway HOME. Under the hermetic PATH the recipes
# set up, coreutils and curl are aqua's shims, which find aqua's root through
# HOME unless AQUA_ROOT_DIR names it: pin it from the real HOME first.
export AQUA_ROOT_DIR="${AQUA_ROOT_DIR:-$HOME/.local/share/aquaproj-aqua}"
HOME="$(portable::mktemp tarmac)"
export HOME

# Installation test: clear up any of the existing POSH vars, and force install
HOMEBREW_GITHUB_API_TOKEN="" \
  POSH_BIN="" \
  POSH_TMP="" \
  POSH_CACHE="" \
  POSH_LOG="" \
  TARMAC_FORCE_INSTALL=true \
  ./init

# shellcheck source=/dev/null
. "$HOME"/.profile

if [ "$(command -v brew)" != "$HOME/Applications/homebrew/bin/brew" ]; then
  log::error "brew installation failed - expected: $HOME/Applications/homebrew/bin/brew - command -v brew: $(command -v brew)"
  exit 1
fi

log::info "Homebrew installation successful"
