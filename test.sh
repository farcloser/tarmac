#!/usr/bin/env bash
set -o errexit -o errtrace -o functrace -o nounset -o pipefail

readonly COLOR_RED=1
readonly COLOR_GREEN=2
readonly COLOR_YELLOW=3

# Prefix a date to a log line and output to stderr
logger::stamp(){
  local color="$1"
  local level="$2"
  local i
  shift
  shift

  [ ! "$TERM" ] || [ ! -t 2 ] || >&2 tput setaf "$color" 2>/dev/null || true
  for i in "$@"; do
    >&2 printf "[%s] [%s] %s\n" "$(date 2>/dev/null || true)" "$level" "$i"
  done
  [ ! "$TERM" ] || [ ! -t 2 ] || >&2 tput op 2>/dev/null || true
}

logger::info(){
  logger::stamp "$COLOR_GREEN" "INFO" "$@"
}

logger::warning(){
  logger::stamp "$COLOR_YELLOW" "WARNING" "$@"
}

logger::error(){
  logger::stamp "$COLOR_RED" "ERROR" "$@"
}

lint::dockerfile(){
  >&2 printf " > %s\n" "$@"
  if ! hadolint "$@"; then
    logger::error "Failed linting Dockerfile\n"
    exit 1
  fi
}

lint::shell(){
  >&2 printf " > Shellchecking %s\n" "$@"
  shellcheck -a -x "$@" || {
    logger::error "Failed shellchecking shell script\n"
    return 1
  }
}

# Linting
logger::info "Linting"
lint::shell init ./*.sh
logger::info "Linting successful"

logger::info "Testing unattended forced install"

# Installation test
HOMEBREW_GITHUB_API_TOKEN="" \
POSH_BIN="$HOME/Applications" \
POSH_TMP="${GITHUB_WORKSPACE:-}/cache/tmp" \
POSH_CACHE="${GITHUB_WORKSPACE:-}/cache/cache" \
POSH_LOG="${GITHUB_WORKSPACE:-}/cache/log" \
  TARMAC_FORCE_INSTALL=true ./init

# shellcheck source=/dev/null
. "$HOME"/.posh_brew

if [ "$(command -v brew)" != "$HOME/Applications/homebrew/bin/brew" ]; then
  logger::error "brew installation failed - expected: $HOME/Applications/homebrew/bin/brew - command -v brew: $(command -v brew)"
  exit 1
fi

logger::info "Homebrew installation successful"
