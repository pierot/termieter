cd ~
rm -rf .termieter
git clone git://github.com/pierot/termieter.git ~/.termieter

echo "Linking"

  echo -E "\t.bash_profile"
  ln -sf ~/.termieter/bash_profile ~/.bash_profile

  echo -E "\t.gitconfig"
  ln -sf ~/.termieter/gitconfig ~/.gitconfig

  echo -E "\t.screenrc"
  ln -sf ~/.termieter/screenrc ~/.screenrc

  echo -E "\t.irbrc"
  ln -sf ~/.termieter/irbrc ~/.irbrc
