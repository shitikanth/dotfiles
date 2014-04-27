$HOME/.bin/daily.sh

git pull origin master
git commit -am "weekly commit"
git push origin master

if [ -d "$HOME/Dropbox" ]; then
    rsync -avz $HOME/Documents/work/research $HOME/Dropbox
fi

