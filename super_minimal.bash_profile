
export TERM="xterm-color"

function parse_git {
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
        STAT=`parse_git`
        echo "[ ${BRANCH}${STAT} ]"
    else
        echo ""
    fi
}

green='\[\e[0;32m\]'
red='\[\e[0;31m\]'
blue='\[\e[0;34m\]'
cyan='\[\e[0;36m\]'
bold_blue='\[\e[1;34m\]'
bold_cyan='\[\e[1;36m\]'
bold_magenta='\[\e[1;35m\]'
reset_color='\[\e[0m\]'
new_line='\n'

PS1=${blue_blue}'Spaceship'${blue}' in'${green}'\h'${blue}' as '${red}'\u '${bold_magenta}\`parse_git_branch\`${reset_color}' '${cyan}'\w'${new_line}${green}'$ '${reset_color}
