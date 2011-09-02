cd ~
rm -rf .termieter
git clone git://github.com/pierot/termieter.git ~/.termieter

echo "Linking"

  echo "\t.bash_profile"
  ln -sf ~/.termieter/bash_profile ~/.bash_profile

  echo "\t.gitconfig"
  ln -sf ~/.termieter/gitconfig ~/.gitconfig

  echo "\t.screenrc"
  ln -sf ~/.termieter/screenrc ~/.screenrc

  echo "\t.irbrc"
  ln -sf ~/.termieter/irbrc ~/.irbrc
