############ some shortcuts to remember

#### getting lighteing setup
# git clone git@172.16.100.217:irz-config/lightening-setup.git



#### Navigation
# bin		: go to bin directory and list files
# ui		: go to ui directory and list files
# scr		: go to scripts directory and list files
# logs		: go to today's logs directory and list files
# logs DATE	: go to ~/prod/logs/DATE directory and list files
# logs -1	: go to previous day directory, typing it further moves you one day back 
# treee		: lists directory structure like tree



#### Helper functions
# sorted <filelist>		: sorts and merges files by tstamp in first column
# 						: cat strategy-* | sorted
# pid command			: to print pid, core, cpu% etc for all subprocesses and threads of the command

# tabular				: show comma separated test as table
# openfix <fixfile>		: translates '\1' character to '|' for viewing fix files
# tailfix <fixfile>		: tails given fix files highlighting important tags

# viewfix <fixfile>		: print fixfile on terminal after highlighting and modify important fields for viewing
# 						  - you don't need to remember tags, it converts messages your you
# 						  color coding
#      					  - Incoming              -> bold_green
#      					  - Outgoing              -> bold_yellow
#      					  - Login, Logout         -> magenta
#      					  - Price, Sz             -> bold_cyan
#      					  - Clid, OrdId, ExchId   -> bold_blue
#      					  - Others                -> red



#### Statistic tools
# dist					: print distribution of sequence of numbers
# 						  - printf "1 \n 2 \n 3 \n 4" | dist | tabular

# perf_num				: print performance number  distribution from strategy logs
# 						- perf_num 		-> print perf for today for strategy*
# 						- perf_num DATE -> print perf for DATE  for strategy*
# 						- perf_num -1	-> print perf for yesterday for strategy*
# 						- perf_num strategy-*101*		-> print perf for today for strategy*101*
# 						- perf_num DATE strategy-*101*	-> print perf for DATE for strategy*101*

# ack_num				: print ack number distribution from strategy logs
# 						- ack_num 		-> print perf for today for strategy*
# 						- ack_num DATE 	-> print perf for DATE  for strategy*
# 						- ack_num -1	-> print perf for yesterday for strategy*
# 						- ack_num strategy-*101*		-> print perf for today for strategy*101*
# 						- ack_num DATE strategy-*101*	-> print perf for DATE for strategy*101*

# orders                : print order details exchange-session wise
#                       - filename         tords  new  rpl  cxl  buyqty    sellqty   lots      ott
# 						- orders 		-> print perf for today for strategy*
# 						- orders DATE 	-> print perf for DATE  for strategy*
# 						- orders -1	-> print perf for yesterday for strategy*
# 						- orders strategy-*101*		-> print perf for today for strategy*101*
# 						- orders DATE strategy-*101*	-> print perf for DATE for strategy*101*

# sym_orders            : print order details symbols-wise
#                       - symname         tords  new  rpl  cxl  buyqty    sellqty   lots      ott
# 						- sym_orders 		-> print perf for today for strategy*
# 						- sym_orders DATE 	-> print perf for DATE  for strategy*
# 						- sym_orders -1	-> print perf for yesterday for strategy*
# 						- sym_orders strategy-*101*		-> print perf for today for strategy*101*
# 						- sym_orders DATE strategy-*101*	-> print perf for DATE for strategy*101*

# out_orders

# trade_acks

# parsefix

# fix_reject_codes

# ops_check
# cat 201*/*fix | egrep '35=[DFG]' | cut -d. -f1 | sort | uniq -c | tr -s " " | sed -e 's/^[ \t]*//' | tr " " ","

# send_email

# csv_to_html



#### Miscellaneous
# echo $binary 		  : prints current running binary
# echo $blotter 	  : prints current running blotter
# l					  : ls -trlh -> list file by time sorted; Directly use `l`
# egrep 			  : egrep highlights grepped part; don't ever redirect it to a file
# 						- while redirecting to file, use \egrep 'pattern' > filename 

# PS1 (prompt) 		  :	USER_NAME@ IP_ADDR: CURR_DIRECTORY DATE TIME (GIT_BRANCH)
# 						- You can directly copy user_name and ip_addr anytime from cmd prompt
# 						- Date and Time are updated everytime 
# 						- If you are in any git repo, branch is display [* shows some local changes]

# $PATH variable	  : All executable in ~/prod/scripts can be accessed from anywhere;
# 						- You don't have to give directory to scripts ~/prod/script/my_script.sh

# history:			  :	Last 10000 commands are stored in history with date and time
# ulimit -c unlimted  :	Core size limit is unlimited

# colors			  : bold, underline, blick, red, green, yellow, blue, magenta, cyan, white
# 					  : bold_<color> to bold any test with color

# ignore_nse_holidays : checks if input date is present in nse_holiday list and returns prev date to it
#                     : ignore_nse_holidays DATE

# get_prev_workday    : returns previous working day excluding saturday and sunday
#                     : get_prev_workday $dt

############ 

# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

#_______________________ HISTORY ____________

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000
export HISTTIMEFORMAT="[%F %T] "

#_______________________ MISC ____________

ulimit -c unlimited
export EDITOR=vim
export TERM=xterm-256color
PATH=$PATH:~/prod/scripts/
export AWKPATH=$AWKPATH:~/prod/scripts/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

# golang setting
export GOROOT=$HOME/lang-go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin:$GOROOT/bin
export GOBIN=$GOPATH/bin

#_______________________ ALIASES ____________

alias l='ls -trlh --color=auto'
alias ls='ls --color=auto'
alias less='less -R'
alias egrep='egrep --color=auto'
alias grep='grep --color=auto'
alias stub='cd ~/prod/stub'

#_______________________ HELPER FUNCTIONS  ____________

if tty > /dev/null; then
    function bold()         { tput bold && printf "$@" && tput sgr0; }
    function underline()    { tput smul && printf "$@" && tput rmul; }
    function blink()        { tput blink && printf "$@" && tput sgr0; }
    function rev()          { tput rev  && printf "$@" && tput sgr0; }
    function black()        { tput setaf 0 && printf "$@" && tput sgr0; }
    function red()          { tput setaf 1 && printf "$@" && tput sgr0; }
    function green()        { tput setaf 2 && printf "$@" && tput sgr0; }
    function yellow()       { tput setaf 3 && printf "$@" && tput sgr0; }
    function blue()         { tput setaf 4 && printf "$@" && tput sgr0; }
    function magenta()      { tput setaf 5 && printf "$@" && tput sgr0; }
    function cyan()         { tput setaf 6 && printf "$@" && tput sgr0; }
    function white()        { tput setaf 7 && printf "$@" && tput sgr0; }
    function bold_black()   { tput bold && tput setaf 0 && printf "$@" && tput sgr0; }
    function bold_red()     { tput bold && tput setaf 1 && printf "$@" && tput sgr0; }
    function bold_green()   { tput bold && tput setaf 2 && printf "$@" && tput sgr0; }
    function bold_yellow()  { tput bold && tput setaf 3 && printf "$@" && tput sgr0; }
    function bold_blue()    { tput bold && tput setaf 4 && printf "$@" && tput sgr0; }
    function bold_magenta() { tput bold && tput setaf 5 && printf "$@" && tput sgr0; }
    function bold_cyan()    { tput bold && tput setaf 6 && printf "$@" && tput sgr0; }
    function bold_white()   { tput bold && tput setaf 7 && printf "$@" && tput sgr0; }

    function check_prod_variables() {
    #: "${prod_dir:? $( yellow $(bold  'WARNING, prod_dir')  $(yellow "environment variable is not set in ~/.bashrc file. scripts may not work")) }"
    #: "${bin_dir:?  $( yellow $(bold  'WARNING, bin_dir')   $(yellow "environment variable is not set in ~/.bashrc file. scripts may not work")) }"
    #: "${ui_dir:?   $( yellow $(bold  'WARNING, ui_dir')    $(yellow "environment variable is not set in ~/.bashrc file. scripts may not work")) }"
    #: "${bcp_dir:?  $( yellow $(bold  'WARNING, bcp_dir')   $(yellow "environment variable is not set in ~/.bashrc file. scripts may not work")) }"
    #: "${scripts_dir:? $( yellow $(bold  'WARNING, scripts_dir') $(yellow "environment variable is not set in ~/.bashrc file. scripts may not work")) }"

    [ -z "$prod_dir"    ] && echo $(yellow $(bold  'WARNING, prod_dir') $(yellow "environment variable is not set in ~/.bashrc file. scripts may not work"))
    [ -z "$bin_dir"     ] && echo $(yellow $(bold  'WARNING, bin_dir')  $(yellow "environment variable is not set in ~/.bashrc file. scripts may not work"))
    [ -z "$ui_dir"      ] && echo $(yellow $(bold  'WARNING, ui_dir')   $(yellow "environment variable is not set in ~/.bashrc file. scripts may not work")) 
    [ -z "$bcp_dir"     ] && echo $(yellow $(bold  'WARNING, bcp_dir')  $(yellow "environment variable is not set in ~/.bashrc file. scripts may not work")) 
    [ -z "$scripts_dir" ] && echo $(yellow $(bold  'WARNING, scripts_dir') $(yellow "environment variable is not set in ~/.bashrc file. scripts may not work"))
    [ -z "$MCXini"      ] && echo $(yellow $(bold  'WARNING, MCXini') $(yellow "environment variable is not set in ~/.bashrc file. scripts may not work"))

    # Check mandatory files
    [ ! -f "$MCXini"            ] && echo $(red $(bold "ERROR, $MCXini")            $(red " file not found"))
    [ ! -f $bin_script          ] && echo $(red $(bold "ERROR, $bin_script")        $(red " file not found"))
    [ ! -f "$bin_dir/$binary"   ] && echo $(red $(bold "ERROR, $bin_dir/$binary")   $(red " file not found"))
    [ ! -f $ui_script           ] && echo $(red $(bold "ERROR, $ui_script")         $(red " file not found"))
    [ ! -f ${ui_dir}/$blotter   ] && echo $(red $(bold "ERROR, $ui_dir/$blotter")   $(red " file not found"))

    }

fi

function get_ipaddr() {
	ips="\h"
	if type ip &> /dev/null; then
		ips=$(ip -4 a show | grep 'inet' | grep -v '127.0.0.' | awk '{print $2}' | cut -d/ -f1)
	elif type ifconfig &> /dev/null; then
		ips=$(ifconfig | egrep 'inet' | grep -v '127.0.0.' | awk '{print $2}')
	elif type /sbin/ifconfig &> /dev/null; then
		ips=$(/sbin/ifconfig | egrep 'inet' | grep -v '127.0.0.' | awk '{print $2}')
	fi

    echo "$ips" | awk '{ 
        currip=$0; 
        if (ipaddr != "") next; 
        if (match($0, "172.22.") > 0 || match($0, "192.168.") > 0 || match($0, "172.16") > 0) {
            ipaddr=$0; 
        }
    } 
    END { if (ipaddr == "") ipaddr=currip; print ipaddr;}
    '
}

if tty > /dev/null; then
    # THEIP=$(ifconfig | egrep 'inet' | egrep '172.16.100.223|192.168.' | awk '{print $2}' | tail -n 1)
    THEIP=$(get_ipaddr)
else
    THEIP="\h"
fi

# PS1, Bash prompt
. ~/.git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
#PS1+="$(__git_ps1 " (%s)")"
#export PS1='\w$(__git_ps1 " (%s)")\$ '

function timer_start {
  timer=${timer:-$SECONDS}
}

function timer_stop {
  timer_show=$(($SECONDS - $timer))
  unset timer
}

function display_time() {
	awk -v secs=$timer_show '
	function human_time_sec(t) {
		if (t < 60) { return sprintf("%0.0fs", t) }

		t /= 60;
		if (t < 60) { return sprintf("%0.2fmin", t) }

		t /= 60;

		return sprintf("%0.2fh", t);
	}

	END {
		if (secs > 5) {
			printf " %s", human_time_sec(secs);
		}
	}
	' /dev/null
}

PROMPT_COMMAND="timer_stop; history -a; $PROMPT_COMMAND"
if tty > /dev/null; then
	# for removing ~0 0~ characters from terminal
	printf "\e[?2004l"
fi

#PS1="\[\033[01;31m\]\u@ ${THEIP}: \[\033[01;33m\]$(__git_ps1 "(%s)")\[\033[00m\] \w $ ";
USERNAME="\[\033[01;31m\]\u"
CWD="\[\033[00m\]\w"
DATE_TIME="\033[0;36m\$(date +'%Y%m%d %-I:%M:%S%P')"
DISPLAY_TIME="\[\033[00m\]\$(display_time)"
GIT_BRANCH="\[\033[01;33m\]\$(__git_ps1)"
DOLLAR="\[\033[00m\]\n$"
PS1="${USERNAME}@ ${THEIP}: ${CWD} ${DATE_TIME}${DISPLAY_TIME}${GIT_BRANCH}${DOLLAR} ";


# Git Completion
source ~/.git-completion.bash
GIT_PROMPT_ONLY_IN_REPO=1

function tmx() { if [ $# == 0 ]; then tmux -u att -t 0; else tmux -u att -t $1; fi; }

function tabular() {
    cat $1 | column -s, -t | egrep '^|50%|avg'
}

function openfix() {

    if [ $# -eq 1 ]; then
        cat $1 | tr '\1' '|' | less
    else 
        if [ $# -eq 2 ]; then
        cat $1 | tr '\1' '|' | awk -F' ' '{ 
            micros = int( ($1 - int($1)) * 1000000 );
            printf "%s%06d, %s\n", strftime("%H:%M:%S.", $1), micros, $0;
        }' | less
        else 
			fixfiles=`ls *fix 2> /dev/null| head -1`
            cat $fixfiles | tr '\1' '|' | less
        fi
    fi
}

function tailfix() {
    # 35= MsgType (D-New,G-Replace,F-Cancel)
    # 39= Execution Type (35=8, 39= 0->NewAck, 5->RplAck, 4->Cxld, 9,8->Rej, 1-> partial fill, 2->FullFill
    # 44= Order Price
    # 38= Order Quantity
    # 11= Client Id
    # 41= Order Id
    # 54= Order Side
    if [ $# -eq 0 ]; then
    	tail -f *.fix | stdbuf -o 0 tr '\1' '|' | stdbuf -o 0 egrep --color=auto '^|35=|39=|44=|38=|11=|54='
	else
    	tail -f $@ | stdbuf -o 0 tr '\1' '|' | stdbuf -o 0 egrep --color=auto '^|35=|39=|44=|38=|11=|54='
	fi
}

function taillogs() {
    tail -f strategy*.log | stdbuf -o 0 egrep --color=auto 'NEW|RPL|CXL|CXD|ACK|REJ|EXC|$1'
}

function viewfix() {
#     cat $1 | stdbuf -o 0 tr '\1' '|' | stdbuf -o 0 egrep --color=auto '^|35=|39=|44=|38=|11=|54=' | sed -e "s/34=/$( bold $(red 'SeqNo') )=/" | less

    # Incoming              -> bold_green
    # Outgoing              -> bold_yellow
    # Login, Logout         -> magenta
    # Price, Sz             -> bold_cyan
    # Clid, OrdId, ExchId   -> bold_blue
    # Others                -> red

    if [ $# -eq 0 ]; then
		# fixfiles=`ls *fix 2> /dev/null| head -1`
		fixfiles="-"
	else
		fixfiles=$@
	fi

	if [ ! "$fixfiles" ]; then
		echo "no *fix file"
		return
	fi	

    cat $fixfiles | stdbuf -o 0 tr '\1' '|' | stdbuf -o 0 sed \
        -e 's/'"|34=\([0-9]*\)"'/'"$(red '|seqno=\\1')"'/g' \
        -e 's/'"|44=\([.0-9]*\)"'/'"$(bold_cyan '|ordpx=\\1')"'/g' \
        -e 's/'"|38=\([-\.0-9]*\)"'/'"$(bold_cyan '|ordsz=\\1')"'/g' \
        -e 's/'"|31=\([-\.0-9]*\)"'/'"$(bold_cyan '|fillpx=\\1')"'/g' \
        -e 's/'"|32=\([-\.0-9]*\)"'/'"$(bold_cyan '|fillsz=\\1')"'/g' \
        -e 's/'"|54=\(1\)"'/'"$(bold_cyan '|side=buy')"'/g' \
        -e 's/'"|54=\(2\)"'/'"$(bold_cyan '|side=sell')"'/g' \
        -e 's/'"|11=\([0-9]*\)"'/'"$(bold_magenta '|clid=\\1')"'/g' \
        -e 's/'"|41=\([0-9]*\)"'/'"$(bold_magenta '|ordid=\\1')"'/g' \
        -e 's/'"|48=\([0-9]*\)"'/'"$(bold_magenta '|symid=\\1')"'/g' \
        -e 's/'"|37=\([0-9A-Za-z]*\)"'/'"$(bold_magenta '|exchid=\\1')"'/g' \
        -e 's/'"|35=\(0\)"'/'"$(red '|beat=\\1')"'/g' \
        -e 's/'"|35=\(A\)"'/'"$(bold_blue '|logon=\\1')"'/g' \
        -e 's/'"|35=\(5\)"'/'"$(bold_blue '|logout=\\1')"'/g' \
        -e 's/'"|35=\(D\)"'/'"$(bold_yellow '|NEW=\\1')"'/g' \
        -e 's/'"|35=\(F\)"'/'"$(bold_yellow '|CXL=\\1')"'/g' \
        -e 's/'"|35=\(G\)"'/'"$(bold_yellow '|RPL=\\1')"'/g' \
        -e 's/'"|35=\(U14\)"'/'"$(bold_yellow '|IOC=\\1')"'/g' \
        -e 's/'"\(|35=8.*\)|39=\(0\)"'/'"\1$(bold_green '|ACK=\\2')"'/g' \
        -e 's/'"\(|35=8.*\)|39=\(5\)"'/'"\1$(bold_green '|R_ACK=\\2')"'/g' \
        -e 's/'"\(|35=8.*\)|39=\(8\)"'/'"\1$(bold_green '|REJ=\\2')"'/g' \
        -e 's/'"\(|35=9.*\)|39=\(9\)"'/'"\1$(bold_green '|REJ=\\2')"'/g' \
        -e 's/'"\(|35=8.*\)|39=\(4\)"'/'"\1$(bold_green '|CXD=\\2')"'/g' \
        -e 's/'"\(|35=8.*\)|39=\(1\)"'/'"\1$(bold_green '|PART_EXC=\\2')"'/g' \
        -e 's/'"\(|35=8.*\)|39=\(2\)"'/'"\1$(bold_green '|FULL_EXC=\\2')"'/g' 
#         | less

# same color
#     cat $1 | stdbuf -o 0 tr '\1' '|' | stdbuf -o 0 sed \
#         -e 's/'"34="'/'"$(bold_red 'SeqNo=')"'/g' \
#         -e 's/'"44="'/'"$(bold_red 'OrdPx=')"'/g' \
#         -e 's/'"38="'/'"$(bold_red 'OrdSz=')"'/g' \
#         -e 's/'"11="'/'"$(bold_red 'Clid=')"'/g' \
#         -e 's/'"41="'/'"$(bold_red 'Ordid=')"'/g' \
#         -e 's/'"54="'/'"$(bold_red 'Side=')"'/g' \
#         -e 's/'"31="'/'"$(bold_red 'FillPx=')"'/g' \
#         -e 's/'"32="'/'"$(bold_red 'FillSz=')"'/g' \
#         -e 's/'"48="'/'"$(bold_red 'SymId=')"'/g' \
#         -e 's/'"37="'/'"$(bold_red 'ExchId=')"'/g' \
#         -e 's/'"35=\(0\)"'/'"$(bold_red 'Beat=\\1')"'/g' \
#         -e 's/'"35=\(A\)"'/'"$(bold_red 'LogOn=\\1')"'/g' \
#         -e 's/'"35=\(5\)"'/'"$(bold_red 'LogOut=\\1')"'/g' \
#         -e 's/'"35=\(D\)"'/'"$(bold_red 'NEW=\\1')"'/g' \
#         -e 's/'"35=\(F\)"'/'"$(bold_red 'CXL=\\1')"'/g' \
#         -e 's/'"35=\(G\)"'/'"$(bold_red 'RPL=\\1')"'/g' \
#         -e 's/'"35=\(U14\)"'/'"$(bold_red 'IOC=\\1')"'/g' \
#         -e 's/'"\(35=8.*\)39=\(0\)"'/'"\1$(bold_red 'ACK=\\2')"'/g' \
#         -e 's/'"\(35=8.*\)39=\(5\)"'/'"\1$(bold_red 'R_ACK=\\2')"'/g' \
#         -e 's/'"\(35=8.*\)39=\(8\)"'/'"\1$(bold_red 'REJ=\\2')"'/g' \
#         -e 's/'"\(35=9.*\)39=\(9\)"'/'"\1$(bold_red 'REJ=\\2')"'/g' \
#         -e 's/'"\(35=8.*\)39=\(4\)"'/'"\1$(bold_red 'CXD=\\2')"'/g' \
#         -e 's/'"\(35=8.*\)39=\(1\)"'/'"\1$(bold_red 'PART_EXC=\\2')"'/g' \
#         -e 's/'"\(35=8.*\)39=\(2\)"'/'"\1$(bold_red 'FULL_EXC=\\2')"'/g' \
#         | less


# partial coloring
#     cat $1 | stdbuf -o 0 tr '\1' '|' | stdbuf -o 0 sed \
#         -e 's/'"34="'/'"$(red 'seqno=')"'/g' \
#         -e 's/'"44="'/'"$(bold_cyan 'ordpx=')"'/g' \
#         -e 's/'"38="'/'"$(bold_cyan 'ordsz=')"'/g' \
#         -e 's/'"31="'/'"$(bold_cyan 'fillpx=')"'/g' \
#         -e 's/'"32="'/'"$(bold_cyan 'fillsz=')"'/g' \
#         -e 's/'"54="'/'"$(bold_cyan 'side=')"'/g' \
#         -e 's/'"11="'/'"$(bold_magenta 'clid=')"'/g' \
#         -e 's/'"41="'/'"$(bold_magenta 'ordid=')"'/g' \
#         -e 's/'"48="'/'"$(bold_magenta 'symid=')"'/g' \
#         -e 's/'"37="'/'"$(bold_magenta 'exchid=')"'/g' \
#         -e 's/'"35=\(0\)"'/'"$(red 'beat=\\1')"'/g' \
#         -e 's/'"35=\(A\)"'/'"$(bold_blue 'logon=\\1')"'/g' \
#         -e 's/'"35=\(5\)"'/'"$(bold_blue 'logout=\\1')"'/g' \
#         -e 's/'"35=\(D\)"'/'"$(bold_yellow 'NEW=\\1')"'/g' \
#         -e 's/'"35=\(F\)"'/'"$(bold_yellow 'CXL=\\1')"'/g' \
#         -e 's/'"35=\(G\)"'/'"$(bold_yellow 'RPL=\\1')"'/g' \
#         -e 's/'"35=\(U14\)"'/'"$(bold_yellow 'IOC=\\1')"'/g' \
#         -e 's/'"\(35=8.*\)39=\(0\)"'/'"\1$(bold_green 'ACK=\\2')"'/g' \
#         -e 's/'"\(35=8.*\)39=\(5\)"'/'"\1$(bold_green 'R_ACK=\\2')"'/g' \
#         -e 's/'"\(35=8.*\)39=\(8\)"'/'"\1$(bold_green 'REJ=\\2')"'/g' \
#         -e 's/'"\(35=9.*\)39=\(9\)"'/'"\1$(bold_green 'REJ=\\2')"'/g' \
#         -e 's/'"\(35=8.*\)39=\(4\)"'/'"\1$(bold_green 'CXD=\\2')"'/g' \
#         -e 's/'"\(35=8.*\)39=\(1\)"'/'"\1$(bold_green 'PART_EXC=\\2')"'/g' \
#         -e 's/'"\(35=8.*\)39=\(2\)"'/'"\1$(bold_green 'FULL_EXC=\\2')"'/g' \
#         | less
}

# Instead made good tbt visualization (I know you can do it in python over console very easily)
#function opentbt() {
#    column -s, -t < $1 | less -#5 -N -S
#}

function today() {
    dt=`date +"%Y%m%d"`
    cd ~/prod/logs/$dt/ && ls -trlh;
}

function scr() {
    cd ~/prod/scripts && ls -trlh;
}

function treee() {
    if [ $# -eq 1 ]; then
        ls -R $1 | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'
    else 
        ls -R .  | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'
    fi
}

function sorted() {
    cat $@ | sort -nk1 -t, 
}


function get_prev_workday() {
    if [ ! $# -eq 1 ]; then
        echo "Usage: ${FUNCNAME[0]} date"
        echo "returns previous working day excluding saturday and sunday"
        return
    fi
    dt=$1
    weekday=0
    # ignore Sun=0 and Sat=6
    while [ "$weekday" == "0" ] || [ "$weekday" == "6" ]; do
        dt=$(date +'%Y%m%d' -d "$dt - 1 day")
        weekday=`date +%w -d $dt`
    done
    #   echo `date +%c -d $dt`
    echo $dt
}

 # recursively going back in date and modifying same dt variable
nse_holidays=" 26-01-2017 21-02-2017 24-02-2017 13-03-2017 28-03-2017 04-04-2017 14-04-2017 01-05-2017 10-05-2017 26-06-2017 15-08-2017 17-08-2017 25-08-2017 04-09-2017 05-09-2017 06-09-2017 07-09-2017 02-10-2017 19-10-2017 20-10-2017 01-12-2017 25-12-2017"

function ignore_nse_holidays() {
    if [ ! $# -eq 1 ]; then
        echo "Usage: ${FUNCNAME[0]} date"
        echo "checks if input date is in nse_holiday list and returns prev date to it"
        return
    fi
    dt=$1
    new_dt=`date +%d-%m-%Y -d $dt`
    for holiday in $nse_holidays; do
        if [ "$holiday" == "$new_dt" ]; then
            dt=`get_prev_day $dt`
            dt=`ignore_nse_holidays $dt`
        fi
    done
    echo $dt
}


# # pidof alert_server_single_line -> get pid of running program (requires program name)
# # TODO, display names also (drawback) doesn't show threads and tid)
# function getcpid() {
#     # pgrep 
#     # -l -> list-name
#     # -a -> list-full
#     # -w -> show thread id
#     cpids=`pgrep -P $1 | xargs`
# #    echo "cpids=$cpids"
#     for cpid in $cpids;
#     do
#         echo "$cpid"
#         getcpid $cpid
#     done
# }
# 
# function pid() {
#     ppid=`pgrep -f $1 | tail -n 1 2> /dev/null`
#     echo $ppid
#     getcpid $ppid
# }

function getcpid() {
   cpids=`pgrep -P $1 | xargs`
    for cpid in $cpids;
    do
        if [ $cpid == $$ ]; then continue; fi # self pid
        ps -L -o user,pid,comm,pri,nice,lwp,pcpu,cmd --width 80 -p $cpid | egrep -v 'PID'
        getcpid $cpid
    done
}

function pid() {
    pids=`pgrep -f $1`
    for pid in $pids; do
        if [ $pid == $$ ]; then continue; fi # self pid
        echo
        echo "THREADS $pid"
        # username, pid, process_name, priority, niceness, threadid, cpu%, psr, cmdline
        ps -L -o user,pid,comm,pri,nice,lwp,pcpu,psr,cmd --width 80 -p $pid | egrep -v 'PID'
        echo "SUBPROCESS $pid"
        getcpid $pid
        echo "__________________________________"
    done
}

function dist() {
    delim=","
    field=1
    file="-"

    if [ $# -eq 1 ]; then
        field=$1
    elif [ $# -eq 2 ]; then
        file=$1
        field=$2
    fi

    # Skips empty lines
    cat $file | cut -d$delim -f$field | sort -n | egrep -v "^ *$|[a-zA-Z]" | awk -F, '

    function percentile(arr, idx, len) {
        idx = int(idx * len / 100.0);
        if (idx == 0) idx = 1;
        # print len, idx, arr[idx];
        return arr[idx];
    }

    function avg99(arr, len) {
        sum99 = 0;
        len99 = int(len * 0.99);
        for (i=1; i <= len99; i++) {
            sum99 += arr[i];
        }
        if (len99 == 0) return arr[1];
        avg = (sum99 * 1.0)/len99;
        return avg;
    }

    BEGIN {
        print FILENAME;
        print "cnt,avg,std,min,5%,25%,50%,75%,90%,99%,max,avg99";
    }

    {
        sum += $1;
        sum_squares += $1*$1;
        sorted_arr[NR] = $1;
    }

    END {
        OFS=",";
        OFMT="%0.2f";
        #for (i in sorted_arr) print i, sorted_arr[i];
        len = length(sorted_arr);

        if (NR > 0) {
            avg = (sum * 1.0)/NR
            print NR, 
                 avg,
                 sqrt((sum_squares*1.0)/NR - avg * avg),
                 percentile(sorted_arr, 0, len),
                 percentile(sorted_arr, 5, len),
                 percentile(sorted_arr, 25, len),
                 percentile(sorted_arr, 50, len),
                 percentile(sorted_arr, 75, len),
                 percentile(sorted_arr, 90, len),
                 percentile(sorted_arr, 99, len),
                 percentile(sorted_arr, 100, len),
                 avg99(sorted_arr, len);
        }
    }' # | column -s, -t | egrep --color=auto "^|avg|50%"
}

function get_date_and_stratlogs() {
    dt=`date +"%Y%m%d"`;
    logfiles=$logs_dir/$dt/strategy*
    if [ $# -eq 1 ]; then
        if [ "$1" == "-1"  ]; then
            dt=$(date +'%Y%m%d' -d "$dt - 1 day") #-1 means takes previous day's date(-1) is passed in the scripts
            logfiles=$logs_dir/$dt/strategy*
        else
            date -d $1 &> /dev/null;
            is_valid_date=$?
            if [ "$is_valid_date" -eq "0" ]; then
                dt=$1;
                logfiles=$logs_dir/$dt/strategy*
            else
                logfiles=$@
            fi
        fi
    elif [ $# -ge 2 ]; then
        date -d $1 &> /dev/null;
        is_valid_date=$?
        if [ "$is_valid_date" -eq "0" ]; then
            dt=$1
            shift; # shift arguments
        fi
        logfiles=$@
    fi  
}

function get_date_and_fixlogs() {
    dt=`date +"%Y%m%d"`;
    logfiles=$logs_dir/$dt/*fix
    if [ $# -eq 1 ]; then
        if [ "$1" == "-1"  ]; then
            dt=$(date +'%Y%m%d' -d "$dt - 1 day") #-1 means takes previous day's date(-1) is passed in the scripts
            logfiles=$logs_dir/$dt/*fix
        else
            date -d $1 &> /dev/null;
            is_valid_date=$?
            if [ "$is_valid_date" -eq "0" ]; then
                dt=$1;
                logfiles=$logs_dir/$dt/*fix
            else
                logfiles=$@
            fi
        fi
    elif [ $# -ge 2 ]; then
        date -d $1 &> /dev/null;
        is_valid_date=$?
        if [ "$is_valid_date" -eq "0" ]; then
            dt=$1
            shift; # shift arguments
        fi
        logfiles=$@
    fi  
}

function perf_num() {
    # all works with zip files
    get_date_and_stratlogs $@;
    
    if ! ls $logfiles &> /dev/null; then
        echo "$logfiles doesn't exist"
        return
    fi

    num_orders_list=`cat $logfiles | zegrep -a ',PRF,' | awk -F, '{print $10;}' | sort -n | uniq`
#     echo "$num_orders_list";
    for num_order in $num_orders_list; do
        # echo $num_order;
        echo ""
        echo "OMD${num_order}_$dt"
        cat $logfiles | zegrep -a ',PRF,' | awk -F, -v numord=$num_order '{ if ($10 == numord) print $5; }' | dist
    done

    # ADPT to STRAT time
    echo ""
    echo "ADPT-STRAT_$dt"
    cat $logfiles | zegrep -a PRF | awk -F, '{ print $6; }' | dist

    # TODO, portfolio-wise perf numbers
}

function ack_num() {
    # all works with zip files
    get_date_and_stratlogs $@;
    
    if ! ls $logfiles &> /dev/null; then
        echo "$logfiles doesn't exist"
        return
    fi

    echo ""
    echo "ACK_$dt"
    cat $logfiles | zegrep -a ',ACK,' | cut -d, -f11 | dist
    # TODO, portfolio-wise ack numbers
}

function orders() {
    # print fix files wise order details
    get_date_and_fixlogs $@;

    if ! ls $logfiles &> /dev/null; then
        echo "$logfiles doesn't exist"
        return
    fi

    echo "filename,tords,new,rpl,cxl,buyqty,sellqty,lots,ott"

    for file in $logfiles; do 
        basefile="${file##*/}"
#         echo $basefile
        awk -v basefile=$basefile '
        BEGIN {
        tords = new = rpl = cxl = buyqty = sellqty = 0;
        }

        /35=D/{
            new++;
            tords++;
        }

        /35=F/{
            cxl++;
            tords++;
        }

        /35=G/{
            rpl++;
            tords++;
        }

        /35=U14/{
            new++;
            tords++;
        }

        /35=8.*39=[12]/{
            match($0, "32=[0-9]+");
            fillqty=substr($0, RSTART+3, RLENGTH -3);
            if (match($0, "54=1")) {
                buyqty += fillqty;
            }
            else if (match($0, "54=2")) {
                sellqty += fillqty;
            }
        }

        END {
            if (tords + new + rpl + cxl + buyqty + sellqty == 0) {
                exit;
            }
                
            OFS=",";
            OFMT="%0.2f";
            lots = buyqty + sellqty;
            if (lots) {
                ott = tords/lots
            }
            else {
                ott = tords;
            }
            print basefile, tords, new, rpl, cxl, buyqty, sellqty, lots, ott;
        }
    ' $file
    done
}

function sym_orders() {
    # print symbol wise order details
    get_date_and_fixlogs $@;

    if ! ls $logfiles &> /dev/null; then
        echo "$logfiles doesn't exist"
        return
    fi

    syminfofile=~/prod/bin/syminfo.csv

    echo "symname,tords,new,rpl,cxl,buyqty,sellqty,lots,ott"

    awk -F, '
        BEGIN {
        total_orders = total_new = total_rpl = total_cxl = total_buyqty = total_sellqty = total_lots = total_ott = 0;
        }

        function getfixtag(line, tag) {
            if (match(line, tag"=[-0-9a-zA-Z\\.]+")) {
                patlen = length(tag) + 1;
                return substr(line, RSTART + patlen, RLENGTH - patlen);
            }
            return 0;
        }

        function getsymname(line) {
            symid = getfixtag(line, 48);
            symname=""
            if (symid == 0) {
                underlying = getfixtag(line, 55);
                symname = underlying;
            }
            else if (symid in syminfomap) {
                symname = syminfomap[symid];
            }
            return symname;
        }

        FILENAME ~ /syminfo.csv/ {
            syminfomap[$1] = $16;
        }

        /35=D/{
            symname = getsymname($0);
            new[symname]++;
            tords[symname]++;
        }

        /35=F/{
            symname = getsymname($0);
            cxl[symname]++;
            tords[symname]++;
        }

        /35=G/{
            symname = getsymname($0);
            rpl[symname]++;
            tords[symname]++;
        }

        /35=U14/{
            symname = getsymname($0);
            new[symname]++;
            tords[symname]++;
        }

        /35=8.*39=[12]/{
            symname = getsymname($0);
            fillqty=getfixtag($0, 32);
            if (match($0, "54=1")) {
                buyqty[symname] += fillqty;
            }
            else if (match($0, "54=2")) {
                sellqty[symname] += fillqty;
            }
        }

        END {
            for (symname in new) {
                tords1      = (symname in tords)   ? tords[symname] : 0;
                new1        = (symname in new)     ? new[symname] : 0;
                rpl1        = (symname in rpl)     ? rpl[symname] : 0;
                cxl1        = (symname in cxl)     ? cxl[symname] : 0;
                buyqty1     = (symname in buyqty)  ? buyqty[symname] : 0;
                sellqty1    = (symname in sellqty) ? sellqty[symname] : 0;

                if (tords1 + new1 + rpl1 + cxl1 + buyqty1 + sellqty1 == 0) {
                    continue;
                }
                    
                OFS=",";
                OFMT="%0.2f";
                lots = buyqty1 + sellqty1;
                if (lots) {
                    ott = tords1/lots
                }
                else {
                    ott = tords1;
                }

                total_orders += tords1;
                total_new += new1;
                total_rpl += rpl1;
                total_cxl += cxl1;
                total_buyqty += buyqty1;
                total_sellqty += sellqty1;
                total_lots += lots;
                total_ott += 0;

                print symname, tords1, new1, rpl1, cxl1, buyqty1, sellqty1, lots, ott;
            }
            if (total_orders + total_new + total_rpl + total_cxl + total_buyqty + total_sellqty + total_lots + total_ott != 0) {
                print "Total", total_orders, total_new, total_rpl, total_cxl, total_buyqty, total_sellqty, total_lots, total_ott;
            }
        }
    ' $syminfofile $logfiles
}

function out_orders() {
    echo "number of outstanding orders"
    get_date_and_fixlogs $@;
 awk '
 /35=8.*39=0/ {
     orders++;

     match($0, "37=[0-9]+");
     exchid=substr($0, RSTART, RLENGTH);

     match($0, "42=[0-9]+");
     tstamp=substr($0, RSTART, RLENGTH);
     if(int(tstamp)<int(1184148000)) {

     match($0, "48=[0-9]+");
     symid=substr($0, RSTART, RLENGTH);

     match($0, "11=[0-9]+");
     clid=substr($0, RSTART, RLENGTH);

     match($0, "54=[0-9]+");
     side=substr($0, RSTART, RLENGTH);

     out_orders[clid]++;
     exchids[clid]=exchid;
     tstamps[clid]=tstamp;
     symids[clid]=symid;
     sides[clid]=side;
 }

 }

 /35=8.*39=[24]/{
     orders--;
     match($0, "11=[0-9]+");
     clid=substr($0, RSTART, RLENGTH);
     out_orders[clid]--;
 }

 END{
     for (i in out_orders) {
         if (out_orders[i]!=0) {
             print i, exchids[i], tstamps[i], symids[i], sides[i];

 }
     }
     #print "outstandingorders",orders;
 }' $1 # | tr '=' ' ' | cut -d' ' -f2,4,6,8,10

}


function make_vnc() {
	vncserver :$1  -geometry 1280x1024 --alwaysshared 
}


function trade_acks() {
    echo "trade acks"
}

function parsefix() {
    echo "print fix in standard csv format"
}

function fix_rejects_codes() {
    echo "print all fix reject codes"
}

function ops_check() {
    echo "print order per second in decreasing orders"
}

function send_email() {
    echo "function to send mail"
}

function csv_to_html() {
    echo "function to convert csv to html"
}

function python_test() {
PYTHON_ARG="$@" python - << END
import sys
# print sys.path
# cmd_args = int(os.environ['PYTHON_ARG'])
print sys.argv
END
}

function python_test2() {
export bashvar=100

python_file=~/.pyscript.py

cat << EOF > $python_file
#!/usr/bin/env python
import subprocess, sys

print 'Hello python'
print sys.argv
subprocess.call(["echo","$bashvar"])
EOF

chmod +x $python_file

$python_file $@
}

#if tty > /dev/null; then check_prod_variables; fi

# otherwise scp and ssh gives errors
if tty > /dev/null; then
	trap 'if ls ~/prod/config_prod.sh &> /dev/null; then source ~/prod/config_prod.sh; fi; timer_start' DEBUG
fi


# if [ -f ~/.bash-preexec.sh ]; then
	# . ~/.bash-preexec.sh;
# fi

# preexec() {
	# echo "prehello"
	# export hello="!!2"
	# echo $hello
# }
# 
# precmd() {
	# echo "after cmd"
# }

# # Load prod config
# if [ -f ~/config_prod.sh ]; then
    # . ~/config_prod.sh
# fi

# export vivek=VIVEK3
# PROMPT_COMMAND="export vivek='VIVEK4'; echo $vivek"
# echo $vivek


# Load my bash config
if [ -f ~/.my_configs.bash ]; then
	. ~/.my_configs.bash;
fi

# Load error codes
if [ -f ~/.error_codes.sh ]; then
	. ~/.error_codes.sh
fi
export logs_dir=~/prod/logs

alias 14='ssh -Y piyush.v@172.16.100.14'
alias 223='ssh -Y piyush.v@172.16.100.223 -X'
