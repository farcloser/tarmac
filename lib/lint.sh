#!/usr/bin/env bash
set -o errexit -o errtrace -o functrace -o nounset -o pipefail

lint::dockerfile(){
  log::info " > %s\n" "$@"
  if ! hadolint "$@"; then
    log::error "Failed linting Dockerfile"
    exit 1
  fi
}

lint::shell(){
  log::info " > Shellchecking %s\n" "$@"
  shellcheck -a -x "$@" || {
    log::error "Failed shellchecking shell script"
    return 1
  }
}

