#!/usr/bin/env bash
set -o errexit -o errtrace -o functrace -o nounset -o pipefail

portable::mktemp(){
  local prefix="${1:-}"
  local directory=${2:-true}
  local args=()

  [ "$directory" == true ] && args+=(-dq) || args+=(-q)

  mktemp "${args[@]}" "${TMPDIR:-/tmp}/$prefix.XXXXXX" 2>/dev/null || mktemp "${args[@]}"
}


# Helpers
host::require(){
  local binary="$1"

  log::debug "Checking presence of $binary"
  command -v "$binary" >/dev/null || {
    log::error "You need $binary for this script to work, and it cannot be found in your path"
    return 1
  }
}

host::install(){
  local binary

  for binary in "$@"; do
    log::debug "sudo install -D -m 755 $binary /usr/local/bin/$(basename "$binary")"
    sudo install -D -m 755 "$binary" /usr/local/bin/"$(basename "$binary")"
  done
}
