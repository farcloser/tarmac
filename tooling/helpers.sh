#!/usr/bin/env bash
set -o errexit -o errtrace -o functrace -o nounset -o pipefail

lint::dockerfile(){
  >&2 printf "Linting dockerfile:\n"
  >&2 printf " > %s\n" "$@"
  if ! hadolint "$@"; then
    >&2 printf "Failed linting Dockerfile\n"
    exit 1
  fi
}

lint::shell(){
  >&2 printf "Linting shellscript:\n"
  >&2 printf " > %s\n" "$@"
  if ! shellcheck -a -x "$@"; then
    >&2 printf "Failed shellchecking shell script\n"
    exit 1
  fi
}
