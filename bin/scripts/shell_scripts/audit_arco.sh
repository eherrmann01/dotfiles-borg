#!/bin/bash

# List Arco packages
arco_pkgs=$(pacman -Q | grep -E '^arcolinux-|^arco-' | cut -d' ' -f1)

if [[ -z "$arco_pkgs" ]]; then
    echo "✅ No ArcoLinux packages are installed."
    exit 0
fi

# Define package categories
safe_patterns=(
    ".*-wallpapers"
    ".*-themes?"
    ".*-icons?"
    "arcolinux-grub-theme"
    "arcolinux-gtk3.*"
    "arcolinux-qt5.*"
    "arcolinux-plank.*"
)

caution_patterns=(
    "keyring"
    "mirrorlist"
    "tweak"
    "welcome"
    "config"
    "system"
    "grub"
    "lightdm"
    "nvidia"
    "bspwm"
    "qtile"
    "i3"
    "openbox"
    "plasma"
    "lxqt"
    "xfce"
)

# Initialize arrays
safe_list=()
caution_list=()
critical_list=()

# Categorize packages
for pkg in $arco_pkgs; do
    matched=false
    for pattern in "${safe_patterns[@]}"; do
        if [[ $pkg =~ $pattern ]]; then
            safe_list+=("$pkg")
            matched=true
            break
        fi
    done
    if ! $matched; then
        for pattern in "${caution_patterns[@]}"; do
            if [[ $pkg =~ $pattern ]]; then
                caution_list+=("$pkg")
                matched=true
                break
            fi
        done
    fi
    if ! $matched; then
        critical_list+=("$pkg")
    fi
done

# Display results
echo "📦 Found ${#arco_pkgs[@]} ArcoLinux packages installed."

echo -e "\n✅ Safe to Remove (${#safe_list[@]}):"
for pkg in "${safe_list[@]}"; do
    echo "  $pkg"
done

echo -e "\n⚠️  Use Caution (${#caution_list[@]}):"
for pkg in "${caution_list[@]}"; do
    echo "  $pkg"
done

echo -e "\n🚨 Possibly Critical (${#critical_list[@]}):"
for pkg in "${critical_list[@]}"; do
    echo "  $pkg"
done

