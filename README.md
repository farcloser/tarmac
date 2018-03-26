# TarMac
=======

Just a thin wrapper around the Homebrew installer.

## TL;DR

```
bash -c "$(curl -fsSL https://raw.github.com/dubo-dubon-duponey/tarmac/master/init)"
```

Or get a local copy and `./init`.


## Non interactive

Set the following environment variables:
 
 * `POSH_TOKEN`: github personal token to be used by brew
 * `POSH_TMP`: temporary directory to be used by brew, for eg `~/tmp`
 * `POSH_BIN`: final location of brew, for eg `~/Applications/bin`

Then call the script.
