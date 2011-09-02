cd ~
rm -rf .termieter
git clone git://github.com/pierot/termieter.git ~/.termieter

echo "Linking"

  echo -e "\t.bash_profile"
  ln -sf ~/.termieter/bash_profile ~/.bash_profile

  echo -e "\t.gitconfig"
  ln -sf ~/.termieter/gitconfig ~/.gitconfig

  echo -e "\t.screenrc"
  ln -sf ~/.termieter/screenrc ~/.screenrc

  echo -e "\t.irbrc"
  ln -sf ~/.termieter/irbrc ~/.irbrc
