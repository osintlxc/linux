#!/bin/bash 

touch ~/.bash_aliases &&
rm ~/.bash_aliases &&
echo "alias install='sudo apt-get install'" >> ~/.bash_aliases &&
echo "alias remove='sudo apt-get remove'" >> ~/.bash_aliases &&
echo "alias update='sudo apt-get update'" >> ~/.bash_aliases &&
echo "alias ..='cd ..'" >> ~/.bash_aliases &&
echo "alias ...='cd ../../'" >> ~/.bash_aliases &&
echo "alias shutdown='sudo shutdown –h now'" >> ~/.bash_aliases && 
echo "alias restart='sudo shutdown –r now'" >> ~/.bash_aliases &&
echo "alias g='git'" >> ~/.bash_aliases &&
echo "alias grh='git reset --hard'" >> ~/.bash_aliases &&
echo "alias gpush='git push'" >> ~/.bash_aliases &&
echo "alias gs='git status'" >> ~/.bash_aliases &&
echo "alias gpp='git pull --rebase && git push'" >> ~/.bash_aliases &&
echo "alias gspps='git stash && git pull --rebase && git push && git stash pop'" >> ~/.bash_aliases
