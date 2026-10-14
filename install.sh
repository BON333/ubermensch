#!/bin/bash
# Instala o modo Übermensch na home do utilizador (Omarchy ou outro Hyprland).
# Uso: ./install.sh              -> instalar
#      ./install.sh desinstalar  -> remover

set -e
cd "$(dirname "$0")"

BIN="$HOME/.local/bin"
DADOS="${XDG_DATA_HOME:-$HOME/.local/share}/bonvel/ubermensch"

if [ "$1" = desinstalar ]; then
    [ -x "$BIN/ubermensch" ] && "$BIN/ubermensch" off >/dev/null 2>&1 || true
    rm -f "$BIN/ubermensch"
    rm -rf "$DADOS"
    echo "Modo Übermensch removido."
    exit 0
fi

mkdir -p "$BIN" "$DADOS"
install -m 755 ubermensch "$BIN/ubermensch"
install -m 644 dados/* "$DADOS/"

echo "Instalado: $BIN/ubermensch e dados em $DADOS"
case ":$PATH:" in
    *":$BIN:"*) ;;
    *) echo "Atenção: $BIN não está no PATH." ;;
esac
echo "Para o atalho, a waybar, o Ghostty e o ecrã de bloqueio, vê a pasta exemplos/ e o README."
