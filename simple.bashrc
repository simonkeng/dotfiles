# Ultra simple bash config for working on remote 
# machines (that you don't plan to use for long).
# Usage:
# Clone or copy this file to your $HOME directory 
# and rename it ".bashrc", then run:
# source .bashrc

export TERM="xterm-color"

function parse_git_dirty {
    status=`git status 2>&1 | tee`
    dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
    untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
    ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
    newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
    renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
    deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
    bits=''
    if [ "${renamed}" == "0" ]; then
        bits=">${bits}"
    fi
    if [ "${ahead}" == "0" ]; then
        bits="*${bits}"
    fi
    if [ "${newfile}" == "0" ]; then
        bits="+${bits}"
    fi
    if [ "${untracked}" == "0" ]; then
        bits="?${bits}"
    fi
    if [ "${deleted}" == "0" ]; then
        bits="x${bits}"
    fi
    if [ "${dirty}" == "0" ]; then
        bits="!${bits}"
    fi
    if [ ! "${bits}" == "" ]; then
        echo " ${bits}"
    else
        echo ""
    fi
}

function parse_git_branch() {
    BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    if [ ! "${BRANCH}" == "" ]
    then
        STAT=`parse_git_dirty`
        echo "{${BRANCH}${STAT}}"
    else
        echo ""
    fi
}

byel='\[\033[01;33m\]' # Bold Yellow
txtred='\[\e[0;31m\]' # Text Red
txtgrn='\[\e[0;32m\]' # Text Green
txtblu='\[\e[0;34m\]' # Text Blue
bldblu='\[\e[1;34m\]' # Bold Blue
txtrst='\[\e[0m\]'    # Text Reset
nln='\n'

PS1=${bldblu}'[$(hostname)] '${txtred}\`parse_git_branch\`'\[\e[0m\] '${txtgrn}'\w'${nln}${txtgrn}'$ '${txtrst}