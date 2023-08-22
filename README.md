# TarMac

[![Build Status](https://travis-ci.org/dubo-dubon-duponey/tarmac.svg?branch=master)](https://travis-ci.org/dubo-dubon-duponey/tarmac)

TarMac is a very simple shell script with no dependency meant to install a per-user homebrew on a blank macOS.

It does surface a couple of homebrew configuration nooks, will nag for git and xcode command-line tools, 
and will initialize your .profile with what you need.

## TL;DR

Run:

```bash
bash -c "$(curl -fsSL https://raw.github.com/dubo-dubon-duponey/tarmac/master/init)"

# Alternatively, get a specific version, or even master:
# bash -c "$(curl -fsSL https://raw.github.com/dubo-dubon-duponey/tarmac/v1.0.0/init)"
```

... or clone it the git way, then call `./init` inside the clone.

You will be prompted for a GitHub token, and optionally a `bin`, `tmp`, `cache` and `log` path.

## Non-interactive

You can alternatively set the following environment variables:
 
* `HOMEBREW_GITHUB_API_TOKEN`: GitHub personal token to be used by brew
* `POSH_BIN`: install location, for eg `~/Applications`
* `POSH_TMP`: temporary directory to be used for temporary files, for eg `~/transient/tmp`
* `POSH_CACHE`: temporary directory to be used for cache files, for eg `~/transient/cache`
* `POSH_LOG`: temporary directory to be used for log files, for eg `~/transient/log`

Then call the script.

## After that...

Typically, you may migrate / seed stuff from a template or another machine dump.

Dump it:
`brew bundle dump --file=MigrateBrewfile`

Load it:
`brew bundle install --file=MigrateBrewfile`

Or any other way to set up the rest of your laptop environment on top of brew.
