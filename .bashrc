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

alias mvn-debug='MAVEN_OPTS="$MAVEN_OPTS -Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=8000" mvn -U'
alias mvn-integ-debug='MAVEN_OPTS="$MAVEN_OPTS -Xmx2048m -Xms256m" mvn clean verify -Dmaven.failsafe.debug -Pintegration-test'
alias mvn-integ='MAVEN_OPTS="$MAVEN_OPTS -Xmx2048m -Xms256m" mvn clean verify -Dunit.test.skip=true -Pintegration-test'
alias mvn-create-db='mvn clean process-test-resources -Pintegration-test'
alias mvn-unit-and-integ-tests='mvn clean verify -Dunit.testskip=false -Pintegration-test'
alias mvn-test='MAVEN_OPTS="$MAVEN_OPTS -Xmx2048m -Xms256m" mvn clean test -Dsurefire.useFile=false'
alias mvn-test-debug='MAVEN_OPTS="$MAVEN_OPTS -Xmx2048m -Xms256m" mvn clean -Dmaven.surefire.debug test'
alias mvn-install='mvn -D clean install'
alias mvn-tomcat-run='mvn clean -Dmaven.tomcat.port=8080 -Dmaven.test.skip=true tomcat:run-war'
alias mvn-all-tests='mvn-test&&mvn-integ'
alias psql-reminder='psql -h z-devdb01 -d integration_orderengine_db -U postgres -f'
alias mvn-gen-wsdl='mvn clean process-classes -Pgenerate-wsdl'
alias logaccess='ssh tasyrkin@logaccess.zalando'
alias gen-schema='java -jar ../schemaSpy_5.0.0.jar -t pgsql -host localhost:5432 -db local_customer1_db -u postgres -s zf_data -p postgres -dp ../ -o .'
alias svndiff='svn diff | colordiff | less -R'
alias deploy='ssh -A deployctl@deploy.zalando'
alias find-proc='lsof -w -n -i tcp:8080'
alias psql_customer1_local='psql -h localhost -p 5435 -d local_customer1_db -U postgres'
alias psql_customer2_local='psql -h localhost -p 5435 -d local_customer2_db -U postgres'
alias psql_customer3_local='psql -h localhost -p 5435 -d local_customer3_db -U postgres'
alias psql_customer4_local='psql -h localhost -p 5435 -d local_customer4_db -U postgres'
alias psql_customer5_local='psql -h localhost -p 5435 -d local_customer5_db -U postgres'
alias psql_customer6_local='psql -h localhost -p 5435 -d local_customer6_db -U postgres'
alias psql_customer7_local='psql -h localhost -p 5435 -d local_customer7_db -U postgres'
alias psql_customer8_local='psql -h localhost -p 5435 -d local_customer8_db -U postgres'
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
alias psql_customeridx_local='psql -h localhost -p 5435 -d local_customeridx_db -U postgres'
alias psql_orderengine_local='psql -h localhost -p 5433 -d local_orderengine_db -U postgres'
alias psql_config_local='psql -h localhost -d local_config_db -U postgres -p 5434'
alias psql_stock1_local='psql -h localhost -d local_stock1_db -p 5433 -U postgres'
alias psql_stock2_local='psql -h localhost -d local_stock2_db -p 5433 -U postgres'
alias psql_stock3_local='psql -h localhost -d local_stock3_db -p 5433 -U postgres'
alias psql_stock4_local='psql -h localhost -d local_stock4_db -p 5433 -U postgres'
alias psql_opdwh_LIVE='psql -h dwh-opdb.zalando -d prod_dwhop_db'
alias logs='cd /data/server-logs/server'
alias doc='cd /data/zalando/docdata/live/logistics'
alias mvn-get-artifact='mvn org.apache.maven.plugins:maven-dependency-plugin:2.1:get -Dartifact=<groupId>:<artifactId>:<version> -DrepoUrl=https://maven.zalando.de/'
alias rdesktop='rdesktop -d CORP -u tasyrkin z-wnterminal01'

export SVN_EDITOR=vim

#set -o vi


