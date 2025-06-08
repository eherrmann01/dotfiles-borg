#!/bin/sh
#   ______      _ _      _____     _    _                                               _____
#  |  ____|    (_) |    |  __ \   | |  | |                                             / ____|
#  | |__   _ __ _| | __ | |  | |  | |__| | ___ _ __ _ __ _ __ ___   __ _ _ __  _ __   | (___  _ __
#  |  __| | '__| | |/ / | |  | |  |  __  |/ _ \ '__| '__| '_ ` _ \ / _` | '_ \| '_ \   \___ \| '__|
#  | |____| |  | |   <  | |__| |  | |  | |  __/ |  | |  | | | | | | (_| | | | | | | |  ____) | |_
#  |______|_|  |_|_|\_\ |_____(_) |_|  |_|\___|_|  |_|  |_| |_| |_|\__,_|_| |_|_| |_| |_____/|_(_)

# A script to clean up system files, updated 06/03/2025
# ~/bin/scripts/shell_scripts/system-cleanup.sh

set -euo pipefail
IFS=$'\n\t'

# Default options
DRY_RUN=false
LOG_FILE=~/system-cleanup.log

# Parse arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run)
      DRY_RUN=true
      ;;
    --log)
      shift
      LOG_FILE="$1"
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
  shift
done

# Start logging
exec > >(tee -a "$LOG_FILE") 2>&1

echo "System cleanup started at $(date)"
echo "Dry run mode: $DRY_RUN"
echo "Logging to $LOG_FILE"

# Track number of orphaned packages and files removed
ORPHANS_REMOVED=0
FILES_REMOVED=0

# Capture disk usage before cleanup
ROOT_FREE_BEFORE=$(df -h / | awk 'NR==2 {print $4}')
HOME_FREE_BEFORE=$(df -h /home | awk 'NR==2 {print $4}')

echo "Free space before cleanup:"
echo "  /        : $ROOT_FREE_BEFORE"
echo "  /home    : $HOME_FREE_BEFORE"

# Clean package cache
echo "Cleaning package cache..."

if command -v paccache &>/dev/null; then
  if [[ "$DRY_RUN" == true ]]; then
    echo "[DRY RUN] Would run: sudo paccache -r"
  else
    sudo paccache -r
  fi
else
  echo "paccache not found. Skipping package cache cleanup."
fi

# Clean orphaned packages
echo "Removing orphaned packages..."

if command -v pacman &>/dev/null; then
  ORPHANS=$(pacman -Qdtq || true)
  if [[ -n "$ORPHANS" ]]; then
    COUNT=$(echo "$ORPHANS" | wc -l)
    if [[ "$DRY_RUN" == true ]]; then
      echo "[DRY RUN] Would remove $COUNT orphaned packages"
      echo "$ORPHANS" | sed 's/^/  - /'
    else
      echo "$ORPHANS" | xargs sudo pacman -Rns --
      ORPHANS_REMOVED=$COUNT
    fi
  else
    echo "No orphaned packages found."
  fi
fi

# Clean ~/.cache
echo "Cleaning ~/.cache/..."

if [[ "$DRY_RUN" == true ]]; then
  echo "[DRY RUN] Would run: rm -rf ~/.cache/*"
else
  rm -rf ~/.cache/* || true
fi

# Estimate files removed from ~/.cache and Trash
CACHE_COUNT=0
for dir in ~/.cache ~/.local/share/Trash; do
  if [[ -d "$dir" ]]; then
    COUNT=$(find "$dir" -type f 2>/dev/null | wc -l)
    CACHE_COUNT=$((CACHE_COUNT + COUNT))
  fi
done
FILES_REMOVED=$((FILES_REMOVED + CACHE_COUNT))

# Clean npm cache
echo "Cleaning npm cache..."

if command -v npm &>/dev/null; then
  if [[ "$DRY_RUN" == true ]]; then
    echo "[DRY RUN] Would run: npm cache clean --force"
  else
    npm cache clean --force
  fi
else
  echo "npm not found. Skipping npm cache cleanup."
fi

# Clean unused Flatpaks
echo "Cleaning Flatpak leftovers..."

if command -v flatpak &>/dev/null; then
  if [[ "$DRY_RUN" == true ]]; then
    echo "[DRY RUN] Would run: flatpak uninstall --unused -y"
  else
    flatpak uninstall --unused -y
  fi
else
  echo "flatpak not found. Skipping Flatpak cleanup."
fi

# Vacuum journal logs
echo "Cleaning journal logs (keeping 7 days)..."

if [[ "$DRY_RUN" == true ]]; then
  echo "[DRY RUN] Would run: sudo journalctl --vacuum-time=7d"
else
  sudo journalctl --vacuum-time=7d
fi

# Empty the trash
echo "Emptying trash..."

TRASH_PATH=~/.local/share/Trash

if [[ "$DRY_RUN" == true ]]; then
  echo "[DRY RUN] Would run: rm -rf $TRASH_PATH/files/*"
  echo "[DRY RUN] Would run: rm -rf $TRASH_PATH/info/*"
else
  rm -rf "$TRASH_PATH/files/"* || true
  rm -rf "$TRASH_PATH/info/"* || true
fi

# Recalculate files removed
CACHE_COUNT=0
for dir in ~/.cache ~/.local/share/Trash; do
  if [[ -d "$dir" ]]; then
    COUNT=$(find "$dir" -type f 2>/dev/null | wc -l)
    CACHE_COUNT=$((CACHE_COUNT + COUNT))
  fi
done
FILES_REMOVED=$((FILES_REMOVED + CACHE_COUNT))

# Capture disk usage after cleanup
ROOT_FREE_AFTER=$(df -h / | awk 'NR==2 {print $4}')
HOME_FREE_AFTER=$(df -h /home | awk 'NR==2 {print $4}')

# Final summary
echo
echo "🧹 Cleanup Summary"
echo "-------------------------"
echo "Orphaned packages removed : $ORPHANS_REMOVED"
echo "Estimated files removed   : $FILES_REMOVED"
echo
echo "Disk Space Before:"
echo "  /        : $ROOT_FREE_BEFORE"
echo "  /home    : $HOME_FREE_BEFORE"
echo
echo "Disk Space After:"
echo "  /        : $ROOT_FREE_AFTER"
echo "  /home    : $HOME_FREE_AFTER"
echo "-------------------------"
echo "Cleanup completed at $(date)"

