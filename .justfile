# This file is the project's own.
# Add recipes leveraging provided `do` ready-made recipes, or create your own.
# The import must be kept: it mounts every shared limen task under `just do ...`.
import '.limen/just/main.just'

# The FIRST recipe defined here becomes `just`'s default.
lint: do::lint::default
fix: do::fix::default
# Run test.sh: a real, unattended Homebrew install into a throwaway HOME.
# macOS only (xcode-select, the brew bottles), a no-op elsewhere; it needs
# the network for the brew tarball and the two completion formulas.
test:
    #!/usr/bin/env bash
    set -euo pipefail
    if [ "$(uname -s)" != 'Darwin' ]; then
        echo "tarmac is macOS-only — nothing to test on this platform (skipped, not failed)."
        exit 0
    fi
    ./test.sh
security: do::security::default
