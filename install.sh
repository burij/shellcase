#!/bin/bash
sudo apt --yes --allow install apt-transport-https curl
echo "install software"
sudo apt --yes --allow install libsdl2-dev
sudo apt --yes --allow  install mmv
sudo apt --yes --allow  install nemo
sudo apt --yes --allow  install flatpak
sudo add-apt-repository -y ppa:appimagelauncher-team/stable
sudo apt-get --yes --allow  update
sudo apt-get --yes --allow  install appimagelauncher
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install --user flathub  org.gnome.gitlab.somas.Apostrophe
flatpak install --user flathub  org.gnome.gitlab.somas.Apostrophe.Plugin.TexLive
echo "preparing folders"
mkdir /$HOME/.nix
sudo mkdir /nix
echo "creating deamon"
sudo cp nix-in-home.service /etc/systemd/system/
systemctl daemon-reload
systemctl start nix-in-home
systemctl enable nix-in-home
echo "installing environment"
cp bashrc /$HOME/.bashrc
sudo chown -R $USER /nix
curl -L https://nixos.org/nix/install | sh
source ~/.nix-profile/etc/profile.d/nix.sh
echo "restart shell to start using nix"
