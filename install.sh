#!/usr/bin/env bash

set -e 

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Restore in progress..."

if [ -f "$SCRIPT_DIR/pacman-list.txt" ]; then
  echo "[+] Pacman packets install..."
  sudo pacman -S --needed - < "$SCRIPT_DIR/pacman-list.txt"
fi

if [ -f "$SCRIPT_DIR/yay-list.txt" ] && ! command -v yay &> /dev/null; then
  echo "[!] yay not found. Installing yay from AUR..."
  sudo pacman -S --needed base-devel git
  (
    cd /tmp
    rm -rf yay
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    )
fi

if [ -f "$SCRIPT_DIR/yay-list.txt" ]; then
  echo "[+] AUR packets install..."
  yay -S --needed - < "$SCRIPT_DIR/yay-list.txt"
fi

echo "[+] Conf files deployment..."
mkdir -p ~/.config

DOT_CONFIG_DIR="$SCRIPT_DIR/config"

for dir in hypr waybar wofi eww dunst foot kitty fish btop cava mpv yazi Thunar; do
  if [ -d "$DOT_CONFIG_DIR/$dir" ]; then
    if [ -e "$HOME/.config/$dir" ]; then
      echo "[!] Saving $dir in $dir.bak"
      rm -rf "$HOME/.config/$dir.bak"
      mv "$HOME/.config/$dir" "$HOME/.config/$dir.bak"
    fi
    echo " -> Link $dir..."
    ln -s "$DOT_CONFIG_DIR/$dir" "$HOME/.config/$dir"
  fi
done

if [ -f "$DOT_CONFIG_DIR/starship.toml" ]; then
  if [ -e "$HOME/.config/starship.toml" ]; then
    rm -f "$HOME/.config/starship.toml.bak"
    mv "$HOME/.config/starship.toml" "$HOME/.config/starship.toml.bak"
  fi
  ln -s "$DOT_CONFIG_DIR/starship.toml" "$HOME/.config/starship.toml"
fi

echo "Restore done."
