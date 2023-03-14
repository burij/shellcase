#! /bin/bash

echo "Removing previous version"

sudo rm -r /opt/shellcase
sudo rm /usr/local/bin/shellcase
sudo rm /usr/share/applications/shellcase.desktop


echo "Download SunVox from official server"
wget https://burij.duckdns.org/index.php/s/NxQSP287y78FEcF/download


# Unzip the downloaded file
unzip download
rm download

echo "Installation"


sudo mkdir /opt/shellcase
sudo mv 2202_Shellcase/* /opt/shellcase/
rm -r 2202_Shellcase

echo "Creating starters"


chmod +x shellcase
sudo ln -s /opt/shellcase/shellcase /usr/local/bin/



echo "[Desktop Entry]
Name=Shellcase
Exec=shellcase 
Icon=utilities-x-terminal
Terminal=true
Type=Application" | sudo tee /usr/share/applications/shellcase.desktop > /dev/null



# Set the permissions 
sudo chown -R $USER:$USER /opt/shellcase
sudo chmod -R 755 /opt/shellcase

echo "Shellcase is now installed on your system. You can start it with following commands from terminal:"
echo "shellcase"

sleep 10