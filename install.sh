#!/bin/bash
sudo apt --yes install apt-transport-https curl
echo "install software"
# sudo apt --yes install libsdl2-dev
sudo apt --yes install mmv
sudo apt --yes install nemo
sudo apt --yes install flatpak
sudo add-apt-repository -y ppa:appimagelauncher-team/stable
sudo apt-get --yes update
sudo apt-get --yes install appimagelauncher
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install --user flathub  org.gnome.gitlab.somas.Apostrophe
flatpak install --user flathub  org.gnome.gitlab.somas.Apostrophe.Plugin.TexLive
echo "preparing folders"
mkdir /$HOME/.nix
sudo mkdir /nix
echo "creating deamon"
cat <<EOF >./nix-in-home.service
[Unit]
Description=Mounts nix-store im home

[Service]
User=root
WorkingDirectory=/root
ExecStart=mount -o bind /home/michaelburij/.nix /nix
Restart=on-success

[Install]
WantedBy=multi-user.target
EOF
sudo cp nix-in-home.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl start nix-in-home
sudo systemctl enable nix-in-home
echo "installing environment"
cd /$HOME
touch /$HOME/.bashrc
grep -q 'source ~/.nix-profile/etc/profile.d/nix.sh' '.bashrc' || bash -c 'echo "source ~/.nix-profile/etc/profile.d/nix.sh" >> .bashrc'
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR
sudo chown -R $USER /nix
curl -L https://nixos.org/nix/install | sh
source ~/.nix-profile/etc/profile.d/nix.sh
echo "restart shell to start using nix"
rm ./nix-in-home.service
