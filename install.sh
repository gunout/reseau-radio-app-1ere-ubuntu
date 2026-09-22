#!/usr/bin/env bash
# ============================================================
#  Radio La 1ère — Script d'installation automatique
#  Auteur  : gleaphe
#  Licence : MIT
# ============================================================

set -euo pipefail

# ---------- Couleurs ----------
RESET="\033[0m"
BOLD="\033[1m"
DIM="\033[2m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
CYAN="\033[36m"

info()    { echo -e "${CYAN}${BOLD}[INFO]${RESET}  $*"; }
success() { echo -e "${GREEN}${BOLD}[ OK ]${RESET}  $*"; }
warn()    { echo -e "${YELLOW}${BOLD}[WARN]${RESET}  $*"; }
error()   { echo -e "${RED}${BOLD}[FAIL]${RESET}  $*" >&2; }

# ---------- Bannière ----------
banner() {
    echo -e "${CYAN}${BOLD}"
    cat <<'EOF'
    ╔══════════════════════════════════════════════════════╗
    ║                                                      ║
    ║          ██████╗  █████╗ ██████╗ ██╗ ██████╗         ║
    ║          ██╔══██╗██╔══██╗██╔══██╗██║██╔═══██╗        ║
    ║          ██████╔╝███████║██║  ██║██║██║   ██║        ║
    ║          ██╔══██╗██╔══██║██║  ██║██║██║   ██║        ║
    ║          ██║  ██║██║  ██║██████╔╝██║╚██████╔╝        ║
    ║          ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚═╝ ╚═════╝         ║
    ║                                                      ║
    ║              L A   1 È R E   —   RADIO               ║
    ║                                                      ║
    ╚══════════════════════════════════════════════════════╝
EOF
    echo -e "${RESET}"
}

# ---------- Détection OS ----------
detect_os() {
    case "$(uname -s)" in
        Linux*)   OS="linux"   ;;
        Darwin*)  OS="macos"   ;;
        *)        OS="unknown" ;;
    esac
    info "Système détecté : ${BOLD}${OS}${RESET}"
}

# ---------- Détection gestionnaire de paquets ----------
detect_pkg_manager() {
    if command -v apt-get >/dev/null 2>&1; then
        PKG="apt"
    elif command -v dnf >/dev/null 2>&1; then
        PKG="dnf"
    elif command -v pacman >/dev/null 2>&1; then
        PKG="pacman"
    elif command -v brew >/dev/null 2>&1; then
        PKG="brew"
    else
        PKG="unknown"
    fi
    info "Gestionnaire de paquets : ${BOLD}${PKG}${RESET}"
}

# ---------- Vérification Python ----------
check_python() {
    if ! command -v python3 >/dev/null 2>&1; then
        error "Python 3 n'est pas installé. Installe-le puis relance ce script."
        exit 1
    fi
    PY_VERSION=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')
    info "Python détecté : ${BOLD}${PY_VERSION}${RESET}"

    if python3 -c 'import sys; sys.exit(0 if sys.version_info >= (3, 9) else 1)'; then
        success "Version Python compatible (>= 3.9)"
    else
        error "Python 3.9+ requis. Version actuelle : ${PY_VERSION}"
        exit 1
    fi
}

# ---------- Installation des dépendances système ----------
install_system_deps() {
    info "Installation des dépendances système (mpv, ffmpeg)..."

    case "$PKG" in
        apt)
            sudo apt-get update -qq
            sudo apt-get install -y mpv ffmpeg python3-pip python3-venv \
                libxcb-cursor0 libxkbcommon-x11-0 libxcb-xinerama0
            ;;
        dnf)
            sudo dnf install -y mpv ffmpeg python3-pip python3-virtualenv \
                xcb-util-cursor xkbcommon-x11
            ;;
        pacman)
            sudo pacman -Sy --noconfirm mpv ffmpeg python-pip python-virtualenv \
                xcb-util-cursor xkbcommon-x11
            ;;
        brew)
            brew install mpv ffmpeg python@3.11
            ;;
        *)
            warn "Gestionnaire inconnu. Installe manuellement : mpv, ffmpeg, python3-pip"
            ;;
    esac
    success "Dépendances système installées"
}

# ---------- Création de l'environnement virtuel ----------
setup_venv() {
    VENV_DIR=".venv"

    if [ -d "$VENV_DIR" ]; then
        warn "Environnement virtuel déjà présent — réutilisation"
    else
        info "Création de l'environnement virtuel..."
        python3 -m venv "$VENV_DIR"
        success "Environnement virtuel créé dans ${VENV_DIR}/"
    fi

    # shellcheck disable=SC1091
    source "$VENV_DIR/bin/activate"
    info "Activation de l'environnement virtuel"

    pip install --upgrade pip setuptools wheel -q
    success "pip mis à jour"
}

# ---------- Installation des dépendances Python ----------
install_python_deps() {
    info "Installation des dépendances Python (PyQt6, python-mpv)..."

    if [ -f "requirements.txt" ]; then
        pip install -r requirements.txt -q
    else
        warn "requirements.txt introuvable — installation directe"
        pip install PyQt6 python-mpv -q
    fi
    success "Dépendances Python installées"
}

# ---------- Vérification mpv (module Python) ----------
check_mpv_module() {
    if python3 -c "import mpv" 2>/dev/null; then
        success "Module Python 'mpv' opérationnel"
    else
        warn "Le module 'mpv' ne se charge pas correctement."
        warn "Vérifie que libmpv est installé :"
        warn "  • Debian/Ubuntu : sudo apt install libmpv-dev mpv"
        warn "  • Fedora        : sudo dnf install mpv-libs"
        warn "  • Arch          : sudo pacman -S mpv"
        warn "  • macOS         : brew install mpv"
    fi
}

# ---------- Création du lanceur ----------
create_launcher() {
    LAUNCHER="run.sh"
    info "Création du lanceur ${LAUNCHER}..."

    cat > "$LAUNCHER" <<'LAUNCH_EOF'
#!/usr/bin/env bash
# Lanceur Radio La 1ère
set -euo pipefail
cd "$(dirname "$0")"

if [ ! -d ".venv" ]; then
    echo "[ERREUR] Environnement virtuel absent. Lance d'abord ./install.sh"
    exit 1
fi

source .venv/bin/activate

if [ ! -f "radio.py" ]; then
    echo "[ERREUR] radio.py introuvable."
    exit 1
fi

exec python3 radio.py "$@"
LAUNCH_EOF

    chmod +x "$LAUNCHER"
    success "Lanceur créé : ${BOLD}./run.sh${RESET}"
}

# ---------- Création requirements.txt si absent ----------
ensure_requirements() {
    if [ ! -f "requirements.txt" ]; then
        info "Création de requirements.txt..."
        cat > requirements.txt <<'REQ_EOF'
PyQt6>=6.5.0
python-mpv>=1.0.4
REQ_EOF
        success "requirements.txt généré"
    else
        success "requirements.txt déjà présent"
    fi
}

# ---------- Message final ----------
final_message() {
    echo
    echo -e "${GREEN}${BOLD}══════════════════════════════════════════════════════${RESET}"
    echo -e "${GREEN}${BOLD}   ✔  INSTALLATION TERMINÉE AVEC SUCCÈS${RESET}"
    echo -e "${GREEN}${BOLD}══════════════════════════════════════════════════════${RESET}"
    echo
    echo -e "  ${BOLD}Pour lancer l'application :${RESET}"
    echo -e "     ${CYAN}./run.sh${RESET}"
    echo
    echo -e "  ${BOLD}Ou manuellement :${RESET}"
    echo -e "     ${DIM}source .venv/bin/activate && python3 radio.py${RESET}"
    echo
    echo -e "  ${DIM}Bon streaming 📻${RESET}"
    echo
}

# ---------- Main ----------
main() {
    banner
    detect_os
    detect_pkg_manager
    check_python
    ensure_requirements
    install_system_deps
    setup_venv
    install_python_deps
    check_mpv_module
    create_launcher
    final_message
}

main "$@"