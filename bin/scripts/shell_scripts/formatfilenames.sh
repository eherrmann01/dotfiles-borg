#!/usr/bin/env bash
#  ______      _ _      _____     _    _                                               _____
# |  ____|    (_) |    |  __ \   | |  | |                                             / ____|
# | |__   _ __ _| | __ | |  | |  | |__| | ___ _ __ _ __ _ __ ___   __ _ _ __  _ __   | (___  _ __
# |  __| | '__| | |/ / | |  | |  |  __  |/ _ \ '__| '__| '_ ` _ \ / _` | '_ \| '_ \   \___ \| '__|
# | |____| |  | |   <  | |__| |  | |  | |  __/ |  | |  | | | | | | (_| | | | | | | |  ____) | |_
# |______|_|  |_|_|\_\ |_____(_) |_|  |_|\___|_|  |_|  |_| |_| |_|\__,_|_| |_|_| |_| |_____/|_(_)

# Script to replace spaces & hyphens with underscores & makes filenames all lowercase - updated 11/27/2025
# Works in both Bash and Zsh
# ~/bin/scripts/shell_scripts/formatfilenames.sh

for f in *; do
    # Skip if not a regular file
    [ -f "$f" ] || continue

    # Replace ' - ' with '_', replace remaining spaces with '_'
    new="${f// - /_}"
    new="${new// /_}"

    # Convert to lowercase in a portable way
    if [ -n "$BASH_VERSION" ]; then
        # Bash lowercase
        new="${new,,}"
    else
        # Zsh lowercase
        new="${(L)new}"
    fi

    # Only rename if the name actually changes
    [ "$f" != "$new" ] && mv "$f" "$new"
done
