#!/bin/sh
#  ______      _ _      _____     _    _                                               _____
# |  ____|    (_) |    |  __ \   | |  | |                                             / ____|
# | |__   _ __ _| | __ | |  | |  | |__| | ___ _ __ _ __ _ __ ___   __ _ _ __  _ __   | (___  _ __
# |  __| | '__| | |/ / | |  | |  |  __  |/ _ \ '__| '__| '_ ` _ \ / _` | '_ \| '_ \   \___ \| '__|
# | |____| |  | |   <  | |__| |  | |  | |  __/ |  | |  | | | | | | (_| | | | | | | |  ____) | |_
# |______|_|  |_|_|\_\ |_____(_) |_|  |_|\___|_|  |_|  |_| |_| |_|\__,_|_| |_|_| |_| |_____/|_(_)

# Wallpaper setting script using Nitrogen - Triple monitor version - updated 06/24/2025
# ~/bin/scripts/shell_scripts/bgchooser.sh

IMAGE_0="$1"
CONFIG="$HOME/.config/nitrogen/bg-saved.cfg"
BACKUP="$CONFIG.bak"

# Check for image input
[ -z "$IMAGE_0" ] && notify-send "Wallpaper not set" "No image selected." && exit 1

# Prompt for layout
LAYOUT=$(zenity --list --title="Wallpaper Layout" --text="Choose layout mode:" \
  --column="Option" "Span image across both monitors" "Set monitor Right" "Set monitor Center" "Set monitor Left")

[ -z "$LAYOUT" ] && notify-send "Wallpaper not set" "No layout selected." && exit 1

# Prompt for display mode
MODE_NAME=$(zenity --list --title="Wallpaper Mode" --column="Mode" \
  "Scaled" "Tiled" "Centered" "Zoomed" "Automatic" "Zoomed Fill")
[ -z "$MODE_NAME" ] && notify-send "Wallpaper not set" "No display mode selected." && exit 1

# Convert mode name to number
get_mode_number() {
  case "$1" in
    "Scaled") echo 0 ;;
    "Tiled") echo 1 ;;
    "Centered") echo 2 ;;
    "Zoomed") echo 3 ;;
    "Automatic") echo 4 ;;
    "Zoomed Fill") echo 5 ;;
    *) echo 4 ;;
  esac
}
MODE=$(get_mode_number "$MODE_NAME")

# Backup config
cp "$CONFIG" "$BACKUP"

# Remove spanned entry if present
remove_span_entry() {
  awk '
    BEGIN { in_block = 0 }
    /^\[xin_-1\]/ { in_block = 1; next }
    /^\[/ && $0 != "[xin_-1]" { in_block = 0 }
    !in_block
  ' "$CONFIG" > "${CONFIG}.tmp" && mv "${CONFIG}.tmp" "$CONFIG"
}

# Update or add entry for specific monitor
update_monitor_entry() {
  MONITOR_HEADER="$1"
  FILE="$2"
  MODE="$3"

  awk -v image="$FILE" -v mode="$MODE" -v target="$MONITOR_HEADER" '
    BEGIN { in_block = 0; written = 0 }
    $0 == target { in_block = 1; print; next }
    /^\[/ && $0 != target { in_block = 0 }
    in_block && /^file=/ { print "file=" image; next }
    in_block && /^mode=/ { print "mode=" mode; next }
    in_block && /^bgcolor=/ { print "bgcolor=#000000"; written=1; next }
    in_block { next }
    { print }
    END {
      if (!written) {
        print "";
        print target;
        print "file=" image;
        print "mode=" mode;
        print "bgcolor=#000000";
      }
    }
  ' "$CONFIG" > "${CONFIG}.tmp" && mv "${CONFIG}.tmp" "$CONFIG"
}

# Handle layout options
case "$LAYOUT" in
  "Span image across both monitors")
    cat > "$CONFIG" <<EOF
[xin_-1]
file=$IMAGE_0
mode=$MODE
bgcolor=#000000
EOF
    notify-send "Wallpaper set:" "$(basename "$IMAGE_0"), $MODE_NAME, Spanned"
    ;;

  "Set monitor Right")
    remove_span_entry
    update_monitor_entry "[xin_0]" "$IMAGE_0" "$MODE"
    notify-send "Wallpaper set:" "$(basename "$IMAGE_0"), Right Monitor, $MODE_NAME"
    ;;

  "Set monitor Center")
    remove_span_entry
    update_monitor_entry "[xin_1]" "$IMAGE_0" "$MODE"
    notify-send "Wallpaper set:" "$(basename "$IMAGE_0"), Center Monitor, $MODE_NAME"
    ;;

  "Set monitor Left")
    remove_span_entry
    update_monitor_entry "[xin_2]" "$IMAGE_0" "$MODE"
    notify-send "Wallpaper set:" "$(basename "$IMAGE_0"), Left Monitor, $MODE_NAME"
    ;;
esac

# Reload wallpaper
nitrogen --restore
exit 0

