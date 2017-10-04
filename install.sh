echo "[...] Commencement de la post installation du pc";sleep 2
echo "[...] Utilisation sur archlinux obligatoire";sleep 2
sudo pacman -Sy
sudo pacman zsh git curl vim --noconfirm
sudo pacaur cowsay --noconfirm
cd /tmp
echo "[...] download the dotfile (now only zshrc) and install it";sleep 2
git clone https://github.com/rogafe/dotfile_pc.git
cd dotfile_pc
mv zshrc_save ~/.zshrc
echo "[...] dotfile install"
echo "[...] install antigen"
cd ~
mkdir ~/.antigen
cd ~/.antigen
curl -L git.io/antigen > antigen.zsh
echo "[...] All done thanks you "