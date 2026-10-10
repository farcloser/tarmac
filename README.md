# TarMac

TarMac is a very simple shell script with no dependency meant to install a per-user homebrew on a blank macOS.

It does surface a couple of homebrew configuration nooks, will nag for git and xcode command-line tools,
and will seed `.profile`.

## TL;DR

Run:

```bash
bash -c "$(curl --proto '=https' --tlsv1.2 -fsSL https://raw.githubusercontent.com/farcloser/tarmac/main/init)"
```

To run a specific release instead of `main`, replace `main` in that URL with a tag from
the [releases](https://github.com/farcloser/tarmac/releases). Or clone it the git way,
then call `./init` inside the clone.

The Homebrew it installs is a pinned release (`BREW_TAG` in `init`, fetched by commit),
kept current by Renovate; `brew update` moves it on from there.

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

## Development

The repository is governed by [limen](https://github.com/farcloser/limen); install it
through [limen-install](https://github.com/farcloser/limen-install), then:

```bash
just lint
just fix
just test   # a real install into a throwaway HOME; macOS only
```

Note that `-o errtrace -o functrace` are not recognized by zsh, and that `-o nounset`
will trip brew bash completion.

Finally, tarmac will not enable bash completion unless `POSH_SHELL` is set (to `bash`).
This is typically achieved with `ps -p $$ -ocomm=` (but mind the leading dash
in some cases). Out of scope for here.
