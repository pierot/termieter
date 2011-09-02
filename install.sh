cd ~
git clone git://github.com/pierot/termieter.git ~/.termieter

echo "Linking"

  echo -E "\t.bash_profile"
  ln -s ~/.termieter/bash_profile ~/.bash_profile

  echo -E "\t.gitconfig"
  ln -s ~/.termieter/gitconfig ~/.gitconfig

  echo -E "\t.screenrc"
  ln -s ~/.termieter/screenrc ~/.screenrc

  echo -E "\t.irbrc"
  ln -s ~/.termieter/irbrc ~/.irbrc
