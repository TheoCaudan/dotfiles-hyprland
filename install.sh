#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_ONLY=false

case "${1:-}" in
  "")
    ;;
  --config-only)
    CONFIG_ONLY=true
    ;;
  --help|-h)
    echo "Usage: $0 [--config-only]"
    echo "  --config-only  Déploie les configurations sans installer de paquets."
    exit 0
    ;;
  *)
    echo "Option inconnue : $1"
    echo "Utilise --help pour voir les options."
    exit 1
    ;;
esac

if [[ "$CONFIG_ONLY" == false ]]; then
  if [[ -f "$SCRIPT_DIR/pacman-list.txt" ]]; then
    echo "[+] Installation des paquets Pacman..."
    sudo pacman -S --needed - < "$SCRIPT_DIR/pacman-list.txt"
  fi

  if [[ -f "$SCRIPT_DIR/yay-list.txt" ]] && ! command -v yay >/dev/null 2>&1; then
    echo "[!] yay absent : installation depuis l'AUR..."
    sudo pacman -S --needed base-devel git

    BUILD_DIR="$(mktemp -d)"
    trap 'rm -rf -- "$BUILD_DIR"' EXIT

    git clone https://aur.archlinux.org/yay.git "$BUILD_DIR/yay"
    (cd "$BUILD_DIR/yay" && makepkg -si --noconfirm)

    rm -rf -- "$BUILD_DIR"
    trap - EXIT
  fi

  if [[ -f "$SCRIPT_DIR/yay-list.txt" ]]; then
    echo "[+] Installation des paquets AUR..."
    yay -S --needed - < "$SCRIPT_DIR/yay-list.txt"
  fi
else
  echo "[+] Mode configuration uniquement : installation des paquets ignorée."
fi

mkdir -p "$HOME/.config" "$HOME/.local/bin"

link_config() {
  local source="$1"
  local target="$2"
  local current

  if [[ ! -e "$source" ]]; then
    echo "[!] Source absente, ignorée : $source"
    return
  fi

  if [[ -L "$target" ]]; then
    current="$(readlink "$target")"

    if [[ "$current" == "$source" ]]; then
      echo "[=] Lien déjà correct : $target"
    elif [[ ! -e "$target" && "$current" == "$HOME/src/dotfiles/"* ]]; then
      echo "[+] Réparation du lien historique : $target"
      ln -sfnT "$source" "$target"
    else
      echo "[!] Lien existant préservé : $target -> $current"
    fi
  elif [[ -e "$target" ]]; then
    echo "[=] Fichier ou dossier existant préservé : $target"
  else
    echo "[+] Création du lien : $target"
    ln -s "$source" "$target"
  fi
}

echo "[+] Déploiement des configurations..."

for name in hypr waybar wofi eww dunst foot fish btop cava mpv yazi Thunar; do
  if [[ -d "$SCRIPT_DIR/config/$name" ]]; then
    link_config "$SCRIPT_DIR/config/$name" "$HOME/.config/$name"
  fi
done

if [[ -f "$SCRIPT_DIR/config/starship.toml" ]]; then
  link_config "$SCRIPT_DIR/config/starship.toml" "$HOME/.config/starship.toml"
fi

if [[ -f "$SCRIPT_DIR/bin/vpn-lab" ]]; then
  link_config "$SCRIPT_DIR/bin/vpn-lab" "$HOME/.local/bin/vpn-lab"
fi

echo "[+] Déploiement terminé."
