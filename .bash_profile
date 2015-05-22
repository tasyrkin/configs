
export SBT_HOME=/Users/tasyrkin/Development/sbt-0.13.7
export SCALA_HOME=/Users/tasyrkin/Development/scala-2.11.6
export ACTIVATOR_HOME=/Users/tasyrkin/Development/activator-1.3.2
export PATH=~/openSource/whiskeysierra/dotfiles/repository/bin:~/ws/git/tasyrkin/return20-test/help_scripts:~/ws/git/tasyrkin/scripts/bin:~/bin:$SBT_HOME/bin:$SCALA_HOME/bin:$ACTIVATOR_HOME:~/programs/maven/bin:~/incident/scripts:~/ws/git/Platform/Database/db-utils:~/ws/reboot-tools/scripts/misc/tools:~/programs/sbt/bin:~/ws/git/Platform/Software/branch-creator:$PATH
echo $PATH

source ~/goto-config.sh

alias python-check-tabs='python -m tabnanny'

test -r /sw/bin/init.sh && . /sw/bin/init.sh
export PATH=/usr/local/sbin:/usr/local/bin:$PATH

source /usr/local/Cellar/git/2.0.0/etc/bash_completion.d/git-completion.bash

#git-prune-remite-and-local does the following:
# - 'git remote prune origin' - prunes all the remote referefences not found in the remote repository
# - 'git branch -r' - lists all remote branches
# - 'awk "{print $1}"' - extracts first string from every line, i.e. remote branch name
# - 'egrep -v -f /dev/fd/0 <(git branch -vv | grep gone)' - see below
# -- '<(git branch -vv | grep origin)' fetches all those branches which have the remote branch from origin and stores them in a file (like /dev/fd/<num>)
# -- 'egrep -v -f /dev/fd/0 /dev/fd/<num>' - see below
# --- -f /dev/fd/0 - takes matching patterns from stdin of egrep (output of the command 'git branch -r')
# --- -v - invert match: selected lines are those NOT matching of the specified patterns
# --- /dev/fd/<num> - remote branches which bound to local branches (some of them may already be 'gone')
# - 'awk "{print $1}"' - print the names of the branches
# - 'xargs git branch -d' - delete the selected branches passed via stdin with xargs
function git-remote-removed() {
  git branch -r | awk -F'.origin/' '{print $2}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}'
}
function git-prune-remote-and-local {
  git fetch && git remote prune origin && git-remote-removed | xargs git branch -d
}
alias git-show-graph='git log --pretty=oneline --graph --decorate --all'
