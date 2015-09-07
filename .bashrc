#System-wide .bashrc file for interactive bash(1) shells.
if [ -z "$PS1" ]; then
   return
fi

export TERM="xterm-color"

parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# remains here for reference
#RED="\[\033[0;31m\]"
#YELLOW="\[\033[0;33m\]"
#GREEN="\[\033[0;32m\]"
#NO_COLOR="\[\033[0m\]"

PS1='\u@\h:\w\[\e[0;32m\]$(parse_git_branch)\[\e[0m\]\$ '

# Make bash check its window size after a process completes
shopt -s checkwinsize
# Tell the terminal about the working directory at each prompt.
if [ "$TERM_PROGRAM" == "Apple_Terminal" ] && [ -z "$INSIDE_EMACS" ]; then
    update_terminal_cwd() {
        # Identify the directory using a "file:" scheme URL,
        # including the host name to disambiguate local vs.
        # remote connections. Percent-escape spaces.
	local SEARCH=' '
	local REPLACE='%20'
	local PWD_URL="file://$HOSTNAME${PWD//$SEARCH/$REPLACE}"
	printf '\e]7;%s\a' "$PWD_URL"
    }
    PROMPT_COMMAND="update_terminal_cwd; $PROMPT_COMMAND"
fi

#export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_17.jdk/Contents/Home
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home
export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH
#. /sw/bin/init.sh

#alias python='python2.6'
#alias python_build='python setup.py sdist'
#alias python_install='python setup.py install'
alias appengine_cfg='appcfg.py'
alias appengine_start='dev_appserver.py'
#alias svn='svn17'
alias svnversion='svnversion17'
alias g++='my-g++'
alias updatedb='/usr/libexec/locate.updatedb'

export MAVEN_OPTS="-Xmx2g -Xms512m  -XX:MaxPermSize=512M -XX:+CMSClassUnloadingEnabled"

function psql_customerALL_local() {
  for SHARD in {1..8} ; do
    if [[ $@ == -f* ]] ; then
      local FILEPROC="$@"
    else
      local PARAMS="\"$@\""
    fi
    cmd="psql_customer${SHARD}_local $FILEPROC $PARAMS"
    eval "$cmd"
  done
}

export SVN_EDITOR=vim

#set -o vi


