# TarMac

[![Build Status](https://travis-ci.org/dubo-dubon-duponey/tarmac.svg?branch=master)](https://travis-ci.org/dubo-dubon-duponey/tarmac)

TarMac is a very simple shell script with no dependency meant to install a per-user homebrew on a blank macOS.

It does surface a couple of homebrew configuration nooks, will nag for git and xcode command-line tools, 
and will initialize your .profile with what you need.

## TL;DR

Run:

```bash
bash -c "$(curl -fsSL https://raw.github.com/dubo-dubon-duponey/tarmac/1/init)"

# Alternatively, get a specific version, or even master:
# bash -c "$(curl -fsSL https://raw.github.com/dubo-dubon-duponey/tarmac/v1.0.0/init)"
# bash -c "$(curl -fsSL https://raw.github.com/dubo-dubon-duponey/tarmac/master/init)"
```

... or clone it the git way, then call `./init` inside the clone.

You will be prompted for a github token, and optionally a `tmp`, `bin` and `cask` paths.

## Non-interactive

You can alternatively set the following environment variables:
 
 * `POSH_TOKEN`: github personal token to be used by brew
 * `POSH_TMP`: temporary directory to be used by brew, for eg `~/tmp`
 * `POSH_BIN`: final location of brew, for eg `~/Applications/bin`
 * `POSH_CASK`: final location for casks, for eg `~/Applications/cask`

Then call the script.

## After that...

Typically, you may migrate / seed stuff from a template or another machine dump.

Dump it:
`brew bundle dump --file=MigrateBrewfile`

Load it:
`brew bundle install --file=MigrateBrewfile`

Or any other way to setup the rest of your laptop environment on top of brew.
