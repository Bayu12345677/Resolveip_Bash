#!/bin/bash

app_name=${BASH_SOURCE[0]#*/}

#how to use it is very easy the first step you have to create a file containing a bunch of domain instances domain.txt
#You can also use option by typing bash Main.sh -? or --help
#if you use --file option then there should be --output option

#########################
#   code by polygon     #
#########################

# percuma kalo gua encode ama jaa gak bisa di git pull
# tinggal make susah amat
# noh wa w : 6285731184377
# chat aja

source $(cd "$(dirname $0)" && pwd)/lib/moduler.sh

Bash.import: text_display/string text_display/colorama
Bash.import: util/type

b=$(mode.bold: biru)     cy=$(mode.bold: cyan)
ij=$(mode.bold: hijau)   un=$(mode.bold: ungu)
me=$(mode.bold: merah)   pu=$(mode.bold: putih)
ku=$(mode.bold: kuning)  st=$(default.color)
m=$(mode.bold: pink)

# color translator
##############################################
# ungu = violet
# putih = white
# biru = blue
# hijau = green
# kuning = yellow
# merah = red
##############################################

# to validate the package if the package is not installed it will install it otamtis
if ! command -v resolveip>/dev/null 2>&1; then begin:
    apt-get --fix-missing install mariadb>/dev/null 2>&1 || begin:
         Tulis.strN "Please turn on your internet (Tolong nyalakan internet anda)"
   __bash__
__bash__
fi    

DEBUG "if the resolveip package is not found it will automatically install the package but if the install fails it will stop and give a message to turn on the internet"

##################
# valiadasi file #
##################
file:(){
	local file=$1; # arguments
    # verify the file exists or not if it won't send you a message (memverifikasikan file ada atau tidak jika ada maka akan menmapilkan pesan)
  if [[ ! -f "$file" ]]; then
      Tulis.strN "${bi}»${ku} File not found ${me}!${st}"
      exit 5
   fi

   e=$(cat $file | wc -l)
    # e=$(wc -l $file | cut -d ' ' -f1)
}

resolve.list:(){
	local list=${1:-Notfound}
	local get
	if [[ $list == Notfound ]]; then
	    Tulis.strN ${list}
	   exit 2
	 fi

    file: ${1}
      list_dom=$(cat $list)
	for get in `cat "$list"`; do
	     resolveip "$get"
#	     if [[ $count -eq $e ]]; then
#	        break
#	     fi
	 done
	     # local count
	        # for((count = 2; count <= $e; count ++)); do
	            # result=$(cat deb.tmp | tail +$count | head -1)
	         # done
	         # @return: result
	  return 1
}

show.list:(){
	local run="$1"
    local found=$e
    i=0
	[[ -z "$run" ]] && { return 2; }
   s=$(echo "$1" | wc -l)
   while ((i<=100)); do
     sleep 0.1
      reparse=$(echo "$run" | sort -n)
      ((i++))
   if [[ $i -eq $s ]]; then
       break
    fi
   done

   @return: reparse
}

trap "rm -rf deb.tmp;tput cnorm;tput sgr0; exit $?" SIGINT INT
Main.scrap(){
[[ -z "$1" ]] && { usage;exit 4; }
tput civis
rep=$(resolve.list: "$1")
slot=$(show.list: "$rep")
count=$(echo "${slot:-None}" | wc -l)
Tulis.strN "\e[90m-------------------------------${me}[\e[90mAuthor : polygon${me}]\e[90m---------------------------------${st}"
for ((i=0; i<=$count; i++)); do
    sleep 0.1s
    Tulis.str "${b}[${ij}$(date +%H:%M:%S)${b}]${ku} [${un}Result${ku}]${me}-${ij}>${pu} "
    printf "$slot" | tail +$i | head -1
    Tulis.str "${st}"
 done

if [[ -z "$2" ]]; then
  Tulis.strN "Author : Bayu riski (Polygon)
tool: draw ip from domain list (menggambil ip dari beberapa domain list)
data: $(date)
list: $1
__________________________________\n">found.txt
else
  Tulis.strN "Author : Bayu riski (Polygon)
tool: draw ip from domain list (menggambil ip dari beberapa domain list)
data: $(date)
list: $1
__________________________________\n">$2
fi

if [[ -z "$2" ]]; then
    lokal_found="found.txt"
 else
    lokal_found="$2"
fi
      Tulis.strN "${slot}"> deb.tmp
      [[ ! -f $lokal_found ]] && begin: tput cnorm;tput sgr0;return 2; __bash__
      [[ -z "$2" ]] && { Tulis.strN "\n\n${cy}[${ku}$(date)${cy}]${pu} Found ${me}$(cat deb.tmp | wc -l) ${pu}File${me}:${pu} Found.txt"; } || { Tulis.strN "\n\n${cy}[${ku}$(date)${cy}]${pu} Found ${me}$(cat deb.tmp | wc -l) ${pu}File${me}:${pu} $2"; }
      [[ -z "$2" ]] && { cat deb.tmp>>found.txt; } || { cat deb.tmp>>$2; }
   rm -rf deb.tmp
   tput cnorm; tput sgr0
}

usage(){
Tulis.strN "usage : bash $(basename $0).sh list.txt [option]
\e[90m---------------------------------------------${st}
-f, --file       File
-o, --output     save domain result to file (menyimpan hasil domain ke file)
-?, --help       display help (menampilkan bantuan)
\e[90m---------------------------------------------${st}
"
  exit $?
}

if [[ "$1" == "--file" || "$1" == "-f" ]]; then
   [[ -z "$2" ]] && { usage; exit 2; }
    domain_list="$2"
fi
if [[ "$3" == "--output" || "$3" == "-o" ]]; then
      [[ -z "$4" ]] && { usage; exit 3; }
     Main.scrap "$domain_list" "$4"
     exit 0
elif [[ "$1" == "-?" || "$1" == "--help" ]]; then
     echo
     usage
     echo
    exit 0
elif [[ ! -z "$1" ]]; then
     Main.scrap "$1"
     exit
else
     echo
     usage
     echo
     exit 5
fi
