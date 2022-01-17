#!/bin/bash

ll_ij="\e[92m"
ll_bi="\e[94m"
ll_me="\e[91m"
ll_ku="\e[94m"
ll_cy="\e[96m"
ll_st="\e[00m"
sys::@file(){
	local __ll__str_arg="$(pwd)/lib/$1"

#    local patch__ll__=$( cd "$(pwd)/${BASH_SOURCE[0]%/*}" )

#	if [[ ! -f "${__ll__str_arg}" ]]; then
#	   echo "[**] Sepertinya tidak ada module $1"
#	   exit 1
#	 fi

   for file in $(echo "$__ll__str_arg" | sed -e 's/.sh/''/g'); do
     if [[ ! -f "${file}.sh" ]]; then
        echo "[**] Sepertinya tidak ada module $@"
        exit 2
    fi
       file=$(echo "${file}.sh")
	 source "$file" "$@">/dev/null 2>&1 || {
	 	echo -e "[**] Error\n\t<Source Not found>\n\t<Source no indetifikasi>\n[ErrorSource]> sepertinya library tidak cocok dengan bash"
	 	exit 44
	 }

	 builtin source "$file" "$@"
  done
	 __ll__str_arg=(${__ll__str_arg})
}

shopt -s expand_aliases

Exception::key::sys(){
    echo "
[**] Signal sigint triger

           <Keyboard exit>
           <keyboard Signal SIGINT>
           <Keyboard SIGNAL INT>
           
[KeyboardSignal]"
  exit $?
}

Exception::err(){
	echo -e "${ll_bi}[${ll_me}/${ll_me}/${ll_bi}]${ll_st} ErrorSyntax\n\n\t${ll_me}➥\e[00m ErrorLine ${ll_me}:${ll_st} $lineno\n\t${ll_ku}➥${ll_st} ${ll_cy}Source    ${ll_me}:${ll_st} ${source}\n\t${ll_ij}➥${ll_st} ErrorSyntax${ll_ij}[${ll_me}${lineno}${ll_ij}]\n\t${ll_cy}➥${ll_st} ${ll_me}<${ll_st}Error_syntax${ll_me}>\n\t${ll_me}➥${ll_st} \e[91m[\e[97mundentified_object\e[91m]\e[92m> \e[00m${unfined}"
}
trap "Exception::key::sys" INT SIGINT
#trap "Exception::err;echo;echo;/data/data/com.termux/files/usr/libexec/termux/command-not-found \"$1\"" ERR

#if [[ -x /data/data/com.termux/files/usr/libexec/termux/command-not-found ]]; then
@system::require(){
	local file_patch="$1"

	if [[ -d "$file_patch" ]]; then
	    if [[ ${reloading} != true ]] && [[ ! -z "${file_patch}" ]] && builtin source "$file_patch" || { echo "Nothing"; exit 5; }; then
	       return 2
	    fi
	  else
	      source $(pwd)/${file_patch}
	   fi
}
        command_not_found_handle(){
             local lineno="${BASH_LINENO[0]}"
             local source="${0}"
             local unfined="$*"
             echo
             echo
             Exception::err
            echo -e "\e[91m====================================\e[00m"
        	#/data/data/com.termux/files/usr/libexec/termux/command-not-found "$1"
        	   echo
        	  exit $?
        }
#fi

system::import(){
	local libpatch

	for libpatch in $@; do
	   sys::@file "$libpatch"
  done
}

alias Bash.import:="system::import"
alias @require="reloading=true @system::require"
alias begin:="{"
alias __bash__="};"
alias DEBUG=": #"
alias DEBUG=": "
