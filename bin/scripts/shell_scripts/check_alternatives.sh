#!/bin/bash

# Output file
OUTFILE="arco_alternatives_report.txt"

# Choose AUR helper
if command -v paru >/dev/null 2>&1; then
    AUR_HELPER="paru"
elif command -v yay >/dev/null 2>&1; then
    AUR_HELPER="yay"
else
    echo "❌ No AUR helper (paru or yay) found."
    exit 1
fi

echo "🔍 Checking for alternatives using $AUR_HELPER..."

# Get installed packages
installed_pkgs=$(pacman -Qq)

# Get Arco packages
arco_pkgs=$(pacman -Q | grep -E '^arcolinux-|^arco-' | cut -d' ' -f1)

# Header
header="\nArco Package                        | Pacman Alternative            | AUR Alternative               | Installed Replacement"
printf "$header\n" | tee "$OUTFILE" >/dev/null
printf -- "----------------------------------------------------------------------------------------------------------------------------\n" | tee -a "$OUTFILE" >/dev/null

for pkg in $arco_pkgs; do
    base_name=${pkg#arcolinux-}
    base_name=${base_name#arco-}

    # Find pacman alternative (exact match)
    pacman_match=$(pacman -Ss "^$base_name$" | grep -m1 "^" | cut -d/ -f2 | cut -d' ' -f1)
    [[ -z "$pacman_match" ]] && pacman_match=$(pacman -Ss "$base_name" | grep -v -e '-git' -e '-bin' -e '-dev' | grep -m1 "^" | cut -d/ -f2 | cut -d' ' -f1)

    # Find AUR alternative
    aur_match=$($AUR_HELPER -Ss "^$base_name$" | grep -v -e '-git' -e '-bin' -e '-dev' | grep -m1 "^" | cut -d/ -f2 | cut -d' ' -f1)
    [[ -z "$aur_match" ]] && aur_match=$($AUR_HELPER -Ss "$base_name" | grep -v -e '-git' -e '-bin' -e '-dev' | grep -m1 "^" | cut -d/ -f2 | cut -d' ' -f1)

    # Filter out Arco-named matches
    [[ $pacman_match == arco* || $pacman_match == arcolinux* ]] && pacman_match=""
    [[ $aur_match == arco* || $aur_match == arcolinux* ]] && aur_match=""

    # Check if already installed
    replacement_installed=""
    for candidate in "$pacman_match" "$aur_match"; do
        if [[ -n "$candidate" && "$installed_pkgs" == *"$candidate"* ]]; then
            replacement_installed=$candidate
            break
        fi
    done

    # Output line
    line=$(printf "%-35s | %-30s | %-30s | %-25s" "$pkg" "${pacman_match:-—}" "${aur_match:-—}" "${replacement_installed:-—}")
    echo "$line" | tee -a "$OUTFILE" >/dev/null
done

echo -e "\n📄 Cleaned report saved to: $OUTFILE"


