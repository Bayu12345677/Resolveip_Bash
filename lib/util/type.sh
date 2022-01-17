Bash.import: text_display/string

sys::var:(){
    local status argv
    argv="$1"
    target_argv="$2"
    local deference=${3:-true}

    if [[ $argv == "n"* ]]; then
        flag_type=$(Tulis.strN reference)
    elif [[ $argv == "a"* ]]; then                                                    
     flag_type=$(Tulis.strN array)
    elif [[ $argv == "A"* ]]; then                                                                      
      flag_type=$(Tulis.strN map)
    elif [[ $argv == "i"* ]]; then
        flag_type=$(Tulis.strN integer)
    elif [[ $argv == "ai"* ]]; then
        flag_type=$(Tulis.strN integerArray)
    elif [[ $argv == "Ai"* ]]; then
        flag_type=$(Tulis.strN integerMap)
    else
        flag_type=$(Tulis.strN string)
    fi

#   eval $argv>/dev/null 2>&1

#if [[ $? == 0 ]]; then
#      s=$(eval "$argv")
#      printf ${s:-None}
#      return $?
# else
#      shift $((1+1))
#      [ -n "${argv}" ] && { return $?; }
# fi

#   argv_defined=$(declare -p $argv 2> /dev/null || true)

   local regex_array="declare -([a-zA-Z-]+) $argv='(.*)'"
   local regex="declare -([a-zA-Z-]+) $argv=\"(.*)\""
   local regex_bash4="declare -([a-zA-Z-+]) $argv=(.*)"

   local escape="'\\\'"
   local escapeQuest='\\"'
   local singleslash='\'

   argv_definitation=$(declare -p $argv 2>/dev/null || true)

   [[ -z "$argv_definitation" ]] && { printf "\e[91m➥\e[00;97m Variable not defined\e[00m"; return 2; }

   if [[ "$argv_definitation" =~ $regex_array ]]; then
         deklarasi="${BASH_REMATCH[2]//$escape/}"
                                                                                       # semuanya: apakah transformasi ini di butuhkan ?
   elif [[ "$argv_definitation" =~ $regex ]]; then
        deklarasi="${BASH_REMATCH[2]//$escape/}"
        deklarasi="${deklarasi//$escapeQuest/$singleslash}"
        deklarasi="${deklarasi//$escapeQuest/$sintleslash}"
   elif [[ "$argv_definitation" =~ $regex_bash4 ]]; then
        deklarasi="${BASH_REMATCH[2]}"
   fi

   local variabeltype

   DEBUG "Variable is $argv = $argv_definitation ==== ${BASH_REMATCH[1]}"

   local primitType=${BASH_REMATCH[1]}
   local objektipelangsungke="$argv[__object_type]"

   if [[ "$primitType" =~ [A] && ! -z "${objektipelangsungke}" ]]; then
       DEBUG Log "Object Type $argv[__object_type] = ${!objektipelangsungke}"
       variabeltipe="${!objektipelangsungke}"
   else
        variabeltype=$(Tulis.strN ${flag_type})
        DEBUG "Variable $argv is type of $variabletype"
   fi
}

###############
# return mode #
###############

@return:(){
        local argv="$1"
        local deference="${2:-true}"

    local deklarasi
        sys::var: "$argv"
        echo "$deklarasi"
}
