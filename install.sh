#!/bin/bash

# Check the distribution
distro=""
if command -v lsb_release &> /dev/null; then
    distro=$(lsb_release -si)
elif [ -e /etc/os-release ]; then
    distro=$(awk -F= '/^ID=/{print $2}' /etc/os-release)
elif [ -e /etc/lsb-release ]; then
    distro=$(awk -F= '/^DISTRIB_ID=/{print $2}' /etc/lsb-release)
fi

# Function to install packages based on the distribution
install_packages() {
    local distro="$1"
    case "$distro" in
        "Arch Linux" | "ManjaroLinux" | "GarudaLinux" )
            sudo pacman -Sy --noconfirm "$@"
            ;;
        "Alpine" )
            sudo apk update
            sudo apk add --no-cache "$@"
            ;;
        * )
            echo "Unsupported distribution: $distro"
            exit 1
            ;;
    esac
}

# Affiche un message indiquant le début de la post-installation et attend 2 secondes.
echo "[...] Commencement de la post installation du PC"
sleep 2

# Affiche un message indiquant qu'une utilisation sur Arch Linux ou Alpine Linux est obligatoire et attend 2 secondes.
echo "[...] Utilisation sur Arch Linux ou Alpine Linux obligatoire"
sleep 2

# Installe yay uniquement si la distribution est Arch Linux
if [ "$distro" == "Arch Linux" ]; then
    echo "[...] Installation de yay (gestionnaire de paquets AUR)"
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd -
    rm -rf /tmp/yay
fi

# Installe les paquets Zsh, Git, Curl, Vim et cowsay en utilisant la fonction install_packages().
install_packages "$distro" zsh git curl vim cowsay

# Clone le dépôt Git contenant les fichiers de configuration et les installe.
echo "[...] Téléchargement et installation des dotfiles"
cd /tmp
git clone https://github.com/rogafe/dotfile_pc.git
cd dotfile_pc
mv zshrc_save ~/.zshrc

# Installe Antigen, un gestionnaire de plugins pour Zsh.
echo "[...] Installation d'Antigen"
mkdir -p ~/.antigen
cd ~/.antigen
curl -L git.io/antigen > antigen.zsh

# Nettoie les fichiers temporaires.
cd ~
rm -rf /tmp/dotfile_pc

# Affiche un message indiquant que tout est terminé.
echo "[...] Tout est terminé, merci !"
