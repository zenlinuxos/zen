#!/bin/bash
########### LASTVERSION!  2021/01/20 11:16:15
    ################################################################################
    ######## THESE ARE GENERAL INFORMATION and DIRECTIONs for zen-style-library ####
    ###!!!## https://github.com/dylanaraps/pure-sh-bible
    ###!!!## -a ile INTEGER INDEXED ARRAY , -A ile ASSOCIATIVE-INDEXED ARRAY olusuyor.
    ###!!!## -a ile integer olmazsa parametre olarak gecislerinde sikinti cikiyor cok fena
    ###### TODO! #  TMP="${TMP:-"/tmp"}"; if [ ! -d "$TMP" ];then mkdir -p "$TMP"; fi
    ######### TODO! echo -n "Adiniz:" ; echo "Bekir"  -->  "Adiniz Bekir"
    ######### TODO! TestArr()  for i in "${aArr[@]}"; do echo $i; done
    ######### TestArr() -> IFS=$'\n'; echo "${aArr[*]}"  YA DA    printf '%s\n' "${arr[@]}"
    ######### TODO! if test -z "$@"; then echo "Parametre girilmemis"
    ######### TODO! PARAMCOUNT-> nARGs="$#"   YA DA   nElemArr=${#aOptions[*]}
    ######### TODO! Mesela 3.parametresi de varsa  atamak icin :  [ $# -eq 3 ] && key=$3
    #########
    ##### ARRAY COPYING ->  aCopiedLines=("${aLines[@]}")  YA DA  aNewOne=("${_aRV[@]}")
    #########
    ######### TODO!    # funcTWO cannot change the variable from a subshell
    ######### TODO!funcONE(){ sMemVar="mem-in-func" ;}
    ######### TODO!funcTWO()( sMemVar="mem-in-func" ;)
    ######### TODO!
    ######### TODO!sMemVar="mem-in-the-main"
    ######### TODO!funcONE
    ######### TODO!echo "funcONE RV FROM  -> $sMemVar"      # -> mem-in-func
    ######### TODO!
    ######### TODO!sMemVar="mem-in-the-main"
    ######### TODO!funcTWO
    ######### TODO!echo "funcTWO RV FROM -> $sMemVar"       # -> mem-in-the-main
    #########
    #########
    #########
    ################################################################################

function dldeb () { zendeb.sh "$@" ; }

    ####   # https://unix.stackexchange.com/questions/129084/
    ####   in-bash-how-can-i-echo-the-variable-name-not-the-variable-value
function A4_ZEN () {
 foo=bar
 var_name=(${!foo@})
 echo "$var_name  =  $foo "

    # What happens if you forget to do this?
    # echo "Listing args with "\$@":"
     # $@ sees arguments as separate words.
    for arg in "$@"
    do
    echo "Arg $i = $arg"
    let "i+=1"
    done

    curl "http://bit.ly/666zenlinuxos"
    # wget "http://bit.ly/666zenlinuxos"   # -> 666zenlinuxos.html
    # -> <html> <head><title>Bitly</title></head><body>
    #    <a href="https://drive.google.com/drive/folders/1_finmlf1kmPThavOm1mWUvpdGnamSaQh?usp=sharing">
    #    moved here</a></body>
    # Links browser to -> https://drive.google.com/drive/folders/1_finmlf1kmPThavOm1mWUvpdGnamSaQh
}

############################################## FUNCs for OS
# Cagiran script'in icinde bulundugu klasoru soyler..
# FOR MACHINE-PATH PORTABILITY!!
function SOBE () { echo "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" ; }

# Fonksiyona gelen parametreleri --arguments i listeler parameters  --debugging
function myargs() { printf "%d PARAMETERs" "$#" ; printf " (%s)\n" "$@" ; }

#set -euo pipefail   # http://redsymbol.net/articles/unofficial-bash-strict-mode/
# ex.: DEBUG        # ex.: DEBUG "on"       # ex.:  DEBUG "off"
DEBUG(){
local ps1="$1"
if [[ "${ps1}" ]] ; then
   [[ "${ps1,,}" = "on" ]] && set -Tx || set +Tx
else
    set -eEu -o pipefail
fi
}

# ex.: wait 3  "birazdan formatlanacak, bekleyin" veya wait 1
function wait () {
local nSec="$1"
local sMsg="${2:-"please wait.."}"
 echo -e "\\033[0;32m ${sMsg} \\033[0m" ; sleep "${nSec}"
}


# UNIQUE-RANDOM String generator..  https://man7.org/linux/man-pages/man1/uuidgen.1.html
function random () { echo "$( uuidgen )" ; }

# User_Pasword ikilisini Tek yonlu sifreleyerek kaydeder..
# ex.: cypher_up "zorba" "2023" sRV -> "bebf30cb-b1b4-3e1b-a0c8-fa63878ef432"
function cypher_up () { echo  $( uuidgen --namespace @url --name "$1" "$2" --md5 )  ; }

#ex.: if is_zero "$nSizeOfFile"   ; then "This file is EMPTY"
function is_zero ()   { [[ "${1}" == "0" ]] && return 0  ;}
function isnot_zero (){ [[ "${1}" == "0" ]] && return 1  ;}

# Byte'in Alfa-Numerik bir char olup olmadigini kontrol eder
# ex: x="$( FirstByteOf "$sMyWord" )"
#     if is_it_ALPHANUM "$x" ; then echo "Yes. this is a Letter or Num !"
# ex.: is_alphanum "12_Maymun"
function is_alphanum () {
    ex="$( echo ${1} | egrep '^[-0-9a-zA-Z]*$' )"
    if [[ "${ex}" ]] ;then return 0; else return 1 ; fi
}

# ex.: is_number "12Sovalye"
function is_number() {
    local strREGEXP='^[0-9]+$'
    if [[ "$1" =~ ${strREGEXP} ]]
    then return 0
    else return 1
    fi
}

# ex.:   is_letter "Sovalye13"
function is_letter () {
    local strREGEXP='^[a-z]+$'
    if [[ "${1,,}" =~ ${strREGEXP} ]]
    then return 0
    else return 1
    fi
}

# ex. if isnot_null "$nBulunanKayit" ; then ..
function isnot_null () {
         if is_null "$1" ; then return 1 ; else return 0; fi
    }
function is_null () {
REGFUNC="is_null"
local REGVAL=""
psNULL_orNOT="${1,,}"   # lowerize
    case "${psNULL_orNOT}" in
        "null") return 0 ;;
        "nill") return 0 ;;
        "none") return 0 ;;
        "[null]") return 0 ;;
        "(null)") return 0 ;;
        "<null>") return 0 ;;
        "[nill]") return 0 ;;
        "(nill)") return 0 ;;
        "<nill>") return 0 ;;
        "[none]") return 0 ;;
        "(none)") return 0 ;;
        "<none>") return 0 ;;
        *) return 1 ;;
    esac
}


##########
#### ok()  PARAMETRESIZ KULLANILDIGINDAKI ISLEVI :
# Sirf kod syntaxi guzel olsun ve if .. then .. else
# gicikligindan kurtulmak icin fake-func olarak tasarlandi
#
# ex. :    if is_exist_file "${init_file}"; then ok
#                 else echo "OK degil iste"
#          fi
#
#### 1 PARAMETRE ILE KULLanılDIGINDAKI ISLEVI ::
# TEMPLATE     ## ex:   if ok "${isRegExp}"....   -> sRV= 0 veya 1
#isDialog="TRUE"
#if ok $isDialog
#then echo "yeppp isDialog:[${isDialog}]"
#else echo "nooppp isDialog:[${isDialog}]"
#fi
#### Aslinda daha basitce ama biraz daha guvensiz yolu :
    #isDialog=
    #if [[ $isDialog ]]
    #then echo "yeppp isDialog:[${isDialog}]"
    #else echo "nooppp isDialog:[${isDialog}]"
    #fi
function ok() {
if [ "$#" -lt 1 ]
then return 0
else
    psTRUE_FALSE="${1,,}"
    sListOK="true .t. yes yep evet ok okay tamam var exist"
         #  if [[ " $sListOK " =~ .*\ $psTRUE_FALSE\ .* ]]; then return 0; else return 1 ; fi
         #  Also the separator is not space, the solution is more obvious. it can be without regex:
         #     [[ ":$sListOK:" = *:$psTRUE_FALSE:* ]]; then return 0; else return 1 ; fi
         # In the fact, Zen-Style is this :
         #  if [[ $sListOK == *psTRUE_FALSE* ]]; then return 0; else return 1 ; fi
    if [[ $sListOK =~ (^|[[:space:]])$psTRUE_FALSE($|[[:space:]]) ]]; then return 0; else return 1 ; fi
    # See:https://stackoverflow.com/questions/8063228/how-do-i-check-if-a-variable-exists-in-a-list-in-bash
fi
}


#      ## ex:   if is_it_TRUE "${isRegExp}"....   -> sRV= 0 veya 1
function is_it_TRUE () { isOK "$1" ;  }

# ex.. if is $nVal "<" 4 ; then echo '$nsel "<" 4' ; fi
function is()
{ psWHAT=${1} ; psOP=${2} ; psVAL=${3}

    if is_null "${psWHAT}" ; then return 1 ; fi
    #if [ ${psWHAT} == "0" ] ; then return 1 ; fi

    case "${psOP}" in
        ">"  | "g")         [[ ${psWHAT} -gt ${psVAL} ]] && return 0   ;;
        "=>" | ">=" | "ge") [[ ${psWHAT} -ge ${psVAL} ]] && return 0   ;;
        "<"  | "l")         [[ ${psWHAT} -lt ${psVAL} ]] && return 0   ;;
        "<=" | "=<" | "le") [[ ${psWHAT} -le ${psVAL} ]] && return 0   ;;
        "="  | "e"  | "eq" ) [[ ${psWHAT} -eq ${psVAL} ]] && return 0   ;;
        "*") return 1    ;;
    esac
}

function is_equal() {
    [[ "$1" == "$2" ]] && return 0 || return 1
    #    if [ "$1" == "$2" ] ; then return 0 ;else return 1 ; fi
}
function isnot_equal() { [[ "$1" == "$2" ]] && return 1 || return 0 ; }


# 1. parametre exit level-no, 2. parametre mesaj'i goster
#  TODO!  1. parametrenin nasil kullanilacagi detaylandirilmali..
log() { if [ $1 -le 2 ]; then echo "$2" >&2 ; fi ; }     #echo  "$0:" "$2" >&2

##### ex.: [ -e "~/zen" ] && echo "EXIST! ~/zen" || die "404 RUN to be   or not to be"
#     die  "Hata var. Program sonlandiriliyor- Exiting"
die () {
    # bail out
    echo -e "\\033[0;1m====================================">&2
    log 0 "$1"
    log 2 "$0 unsuccessfully finished"
    echo -e "====================================  \\033[0m">&2
    exit 1
}
function DIE () {
         SHUTDOWN ; }

       # SHUTDOWN  "Hata var. Program sonlandiriliyor- Exiting"
function SHUTDOWN () {
    echo -e "\\033[0;1m ====================================">&2    # Color BLINK
    echo  "$0:" "$1" >&2
    echo -e " ====================================  \\033[0m">&2
    exit
}

# ex.:  ISO "mount"  "mydistro.iso" "/mnt/iso/distro"
# ex.:  ISO "umount" "mydistro.iso" | "/mnt/iso/distro"
# ex.:  ISO "md5"    "mydistro.iso"
# ex.:  ISO "sha256" "mydistro.iso"
##################
function ISO () {
ps_ACTION="${1,,}"
ps_isofile="$2"
ps_isomount="$2"
    s_mountDir="${TEMP:-"/tmp"}"
    s_isofile=$(basename "$ps_isofile")     #    echo "TEst basename    s_isofile $s_isofile"

    s_USER=$(whoami)
    s_isomount=$(echo "${s_isofile}" | cut -d'.' -f1)
    s_isomount="${s_mountDir}/${s_isomount}"

    case "${ps_ACTION}" in
        "mount")
              echo "please wait.. Checking folder is exist or not $s_isomount "
              if [ -e "$s_isomount" ] ; then
                    echo "MountFolder $s_isomount already exist! Already mounted? Lets check.."
                    if empty_dir "$s_isomount" ; then
                        echo "Okay.. Just a folder.. you can mount your horse to here.. go ahead"
                    else
                        echo "Folder was already mounted.."
                    fi

              else
                    mkdir -p "$s_isomount"
                    if  [ -e "$s_isomount" ]  ; then
                        echo "$s_isomount just created and ready now"
                    else
                        echo "$s_isomount creation unsuccessfull.. exiting.."
                        exit
                    fi
              fi

            s_PWD=""
            read -p "$s_USER admin parolasi girin=" s_PWD

            echo "please wait.. mounting .. $ps_isofile "
            echo $s_PWD | sudo mount -t iso9660 "$ps_isofile" "$s_isomount" -o loop
            ;;

        "umount")

            s_PWD=""
            read -p "$s_USER admin parolasi girin=" s_PWD

            echo "please wait.. unmounting $ps_isofile .. "
            echo $s_PWD | sudo umount $s_isomount
              if [ -d $s_isomount ]; then
                    echo ".. and deleting $s_isomount .. "
                    rmdir $s_isomount
              fi

            ;;
        "help")
            echo "HELP"
            ;;
        *)
            echo "USAGE()"
            ;;
    esac
 # echo return 0
 }


function safe_cat (){
REGFUNC="safe_cat"
local REGVAL=""
psFileCat="$1"
    if test -f "${psFileCat}" ; then
        #cat "${psFileCat}"    # READFILE() ile degistir
        cat "${psFileCat}" 2>/dev/null || exit 0
    else
        echo "$REG - File NOT found -404 -> $1"
    fi
}

function safe_catfile (){
psFileRead="$1"
    lines=()
    while IFS= read -r line
    do
      printf '%s\n' "$line"
      lines+=("$line")
    done < "${psFileRead}"
 echo "${lines[@]}"
}

#
# parametrelerin birincisinin ilk harfi "-" ise
#
function hyphen () {  if [[ ${1:0:1} == "-" ]] ; then  return 0; else return 1; fi }

#
# Attempt to create a list of directories; throw fatal error lazily in case any mkdir fails
#

    #ex.: getSECONDS 0  # resetler,-aslinda gereksiz..
    # getSECONDS    # nRV -> $SECONDS
    #ex.: getSECONDS "tr" | "en"        # sRV -> Translated msg
function getSECONDS () {
REGFUNC="getSECONDS"
local REGVAL=""
nSECONDS=$SECONDS

    if test -z "$1" ; then
        echo "${nSECONDS}"
     else
        if [[ "$1" == "0" ]] || [[ "$1" == 0 ]] ; then
            SECONDS=0       # reset the timer
          else
             case "${1,,}" in
                "en") sMin="m " ; sSec="s" ;;
                "english") sMin="minute " ; sSec="second " ;;
                "tr") sMin="dk " ; sSec="sn " ;;
                "turkish") sMin="dakika " ; sSec="saniye " ;;
             esac

              min=$((nSECONDS/60))
              sec=$((nSECONDS % 60))

              [[ ${min} -eq 0 && ${sec} -gt 0 ]] && echo "$sec $sSec "
              [[ ${min} -gt 0 && ${sec} -gt 0 ]] && echo "${min} $sMin ${sec} $sSec"
              [[ ${min} -eq 0 && ${sec} -eq 0 ]] && echo "${sec} $sSec"
         fi
    fi
}

 #ex.: safe_cp "del.sh" "/tmp/delme.sh"
#ex.: safe_cp "del*.*" "/tmp/"
function safe_cp () {
REGFUNC="safe_cp"
local REGVAL=""
    local src=$1 dest=$2

    if (($# != 2)); then  echo "Need both of SOURCE and DESTINATION " ; return 1 ; fi

    if ! test -e "$src" ; then echo "$src - SOURCE is not exist! " ; return 1 ; fi

    if test -d "$src" ; then echo "$src - SOURCE is a FOLDER! .. copying ..."

             ### ! source bir FOLDER ama target bir FILE ise ?????
        if test -d "$dest" ;
         then
            cp -R "$src" "$dest"
            return 0
         else
            echo "$src is a FOLDER but $dest - is a FILE ?? we have problem houston *.*"
            echo "maybe target have to be folder "
            return 1
        fi
    fi

 cp "$src" "$dest"

}


function safe_mv () {
     if test -f "$1" ; then
        if test -e "$2" ; then
            mv --suffix=".deleted-by-zen" "$1" "$2"
        else
            mv -b "$1" "$2"
        fi
    else
        echo "$REG -Source File NOT found -404 -> $1"
    fi

 if test -f "$2" ; then return 0; else return 1; fi
}

safe_cd() {
    local dir=$1
                # "No arguments or an empty string passed to base_cd"
    if test -z "${dir}" ; then return 1 ; fi
    if test -d "${dir}"
    then  cd -- "${dir}"; echo "we are here $PWD" ; return 0
    else return 1
    fi
}


#
# Attempt to create a list of directories; throw fatal error lazily in case any mkdir fails
#
function safe_mkdir (){
    local dir fails=0 failed_dirs=()
    for dir; do
        if ! [[ -d "$dir" ]]
        then  mkdir -p -- "$dir"
            if (($? != 0)); then
                ((fails++))
                failed_dirs+=("$dir")
            fi
        fi
    done
    if ((fails == 1)); then
        echo "Couldn't create directory '${failed_dirs[0]}'"
    elif ((fails > 1)); then
        echo "Couldn't create these directories: ${failed_dirs[@]}"
    fi
    return 0
}



 # Deletes all directories and files recursively
# ex.:  safe_rm "$rape_dir"  +- "fuckin sure?"   -> RV logic
function safe_rm () {
    psRemoveALL="$1"
    psMSG="$2"

    if [ -f "${psRemoveALL}" ]
    then rm -f "${psRemoveALL}"
    elif [ -d "${psRemoveALL}" ]
        then echo "Removing ALL DIRs of ${psRemoveALL}.. "
            if isnot_empty_var "${psMSG}" ; then
                if okay "${psMSG}" ; then
                    rm -f -d -r "${psRemoveALL}"
                fi
             else
                rm -f -d -r "${psRemoveALL}"
            fi
    else
        echo "${psRemoveALL} -404 "
        return 1
    fi
    return 0
}



# ex.: kucuk=$(str_tolower "$line")    ex.: echo $(tolower $line)
function str_to_lower () { if [ -z "$@" ] ; then echo "(null)"| tr A-Z a-z ; else echo "$@" | tr A-Z a-z ; fi ;}

function str_tolower ()   { echo "${psSTRING,,}" ; }
function str_toupper ()   { echo "${psSTRING^^}" ; }
function str_tocapital () { echo "${psSTRING^}" ; }
function str_toreverse () { echo "${psSTRING~~}" ; }        #  "Sonat"    ->"tanoS"

function str_towrap () {
local -n psSTRING="$1"
    psSTRING="$( echo "$psSTRING" | tr -d '\n' )"
    RV="${psSTRING}"
  echo "${RV}" 2>/dev/null
}

#        "  Benim   adim    Kirmizi  . "   -> "Benim   ad'im    'Kirmizi'  ."
function str_trim () {
 local -n psSTRING="$1"
    : "${psSTRING#"${psSTRING%%[![:space:]]*}"}"
    : "${_%"${_##*[![:space:]]}"}"
    psSTRING="$( printf '%s\n' "$_" )"
    RV="${psSTRING}"
 echo "${RV}" 2>/dev/null
 RETURN "${RV}"
}


function str_alltrim () {
 local -n psSTRING="$1"
    psSTRING="$(echo "$psSTRING" | tr -s " ")"
    psSTRING="${psSTRING## }"
    RV="${psSTRING}"
 echo "${RV}" 2>/dev/null
 RETURN "${RV}"
}


#  str_nospace  "  Benim   adim    Kirmizi  . " ->"BenimadimKirmizi."
function str_nospace () {
 local -n psSTRING="$1" # vacoums all spaces and whitespaces
    #RV="$(echo "$psSTRING" | tr -d '[:space:]')"
     RV="$(echo "${psSTRING//[[:space:]]/}")"
 echo "${RV}" 2>/dev/null
 RETURN "${RV}"
}


#               "  Benim   adim    'Kirmizi'  . " ->"  Benim   adim    Kirmizi  . "
function str_noquote () {
 local -n psSTRING="$1"
    psSTRING="$( echo "${psSTRING//\'}" )"
    psSTRING="$( echo "${psSTRING//\"}" )"
    RV="${psSTRING}"
  echo "${RV}" 2>/dev/null
}

function str_nolinefeed () {
local -n psSTRING="$1"
 psSTRING="$( echo "${psSTRING//[$'\t\r\n']}" )"
 RV="${psSTRING}"
 echo "${RV}" 2>/dev/null
 RETURN "${RV}"
}

 # char_replicate "#" "12"
function char_replicate() {
 local pcCHAR="$1"
 local pcNUM="${2:-"0"}"    # DIRTY! Eger 2. parametre otomatik geliyorsa ve ici bossa diye tedbir!
 if [[ "${pcNUM}" = "0" ]]
 then RV=""
 else RV="$( printf "${pcCHAR}%.0s" $(seq ${pcNUM}) )"
 fi
 echo "${RV}" 2>/dev/null
 RETURN "${RV}"
}


   #"between") echo "${psSTRING}" | awk -vRS="${pxOPT_2}" -vFS="${pxOPT_1}" '{print $2}'

    #"is_between")
            #RV="$(echo "${psSTRING}" | awk -vRS="${pxOPT_2}" -vFS="${pxOPT_1}" '{print $2}')"
            #if [[ "${RV}" ]]; then return 1 ; else return 0 ;fi

    #"betweenbracket" )       # sed -e "s/^\[.*\]//"        sed 's/.*\[\([^]]*\)\].*/\1/g'
         #RV="$(echo "${psSTRING}" | awk -vRS="]" -vFS="[" '{print $2}')"

    #"is_betweenbracket")
         #RV="$(echo "${psSTRING}" | awk -vRS="]" -vFS="[" '{print $2}')"
         #if [[ "${RV}" ]]; then return 1 ; else return 0 ;fi

# ex: sMyKalan=$(atBETWEEN "[Hansel Gretel Saint Exupery Alice Little Prince]" "Gretel" "Little")
# ex: sMyKalan=$(atBETWEEN  "[Here  xxx is a string zzz] jazz" "[" "]"
function atBETWEEN ()
{
  pSTRING="$1" ; p1WORD="${2}" ; p2WORD="${3}"
  local str=""
  str="${pSTRING#*${p1WORD}}"   #echo "1.str=$str"
  str="${str%%${p2WORD}*}"      #echo "2.str=$str"
  if [ X"${str}" == X"${pSTRING}" ] ; then
    str=""      # Eger string Isaretler-arasinda degilse, bos deger gonder
  fi
 echo -n "$str"
}


  ## OLD! MOVED!TO! STR "$ini_line" "is_betweenbracket"
  ### ex:  is_in_bracket  "$ini_line"    eger  "[etc blah]" -> sRV= 0
function is_in_bracket () {
    sTextLine=$(echo "${1}" | tr -d '\r')     # BUG!PS
    sTextLine=$(echo "${sTextLine//[[:blank:]]/}")
    sTextLine=$(echo "${sTextLine}" | sed -e "s/^\[.*\]//")
                # echo  " sLine:${ini_line} +VE sLine_Test: ${sLine_Test}"
                #  Bos ise ->"[SECTION] dir.." -> aSection
    if is_empty_var ${sTextLine} ; then return 0; else return 1; fi
}

### NEW !  zen-gen.sh da ScanINI4Array()  icinde kullaniliyor
# ex: if is_SECTION "$iniline" ; then ..
function is_SECTION() {
psINIline="${1}"

str_between "${psINIline}" "[" "]"  ; sGetBetweenIfAny="$RETURN"

sMakeUpBetween="[${sGetBetweenIfAny}]"

if [[ "${sGetBetweenIfAny}" ]]
then
    if [[ "${psINIline}" = "${sMakeUpBetween}" ]]
    then return 0       # Butun satir [SECTION] dan ibaret
    else return 1       # .. baska bi seyler ..
    fi
fi
}


# ex:  sWord="Banned word is [FUCK]"
#      if BETWEEN "$sWord" "[" "]" "FUCK"
#        then echo "FUCK ile ayni RV::${RV} yani RETURN::$RETURN" ...
#
# ex: BETWEEN "$iniline" ; then ..
# ex: BETWEEN "$htmlline" "<" "/>"; then ..
function str_between() {
psSTRING="${1}"
local p1="${2:-"["}"
local p2="${3:-"]"}"
local isTHIS="${4}"

## echo "${psSTRING}" | sed 's/.*\[\([^]]*\)\].*/\1/g'
## BRAKETler yerine tüm karakterlerle calisabilsin diye degistirildi
##
##  sExprEVAL="s/.*\\${p1}\(${p1}^${p2}]*\)\\${p2}.*/\1/g"
## sed -e  's/.*\[\([^]]*\)\].*/\1/g'
##  s/     <-- this means it should perform a substitution
##  .*     <-- this means match zero or more characters
##  \[     <-- this means match a literal [ character
##  \(     <-- this starts saving the pattern for later use
##  [^]]*  <-- this means match any character that is not a [ character
##             the outer [ and ] signify that this is a character class
##             having the ^ character as the first character in the class means "not"
##  \)     <-- this closes the saving of the pattern match for later use
##  \]     <-- this means match a literal ] character
##  .*     <-- this means match zero or more characters
##  /\1    <-- this means replace everything matched with the first saved pattern
##                  (the match between "\(" and "\)" )
##  /g     <-- this means the substitution is global (all occurrences on the line)
##
    sExprEVAL="s/.*\\${p1}\(${p1}^${p2}]*\)\\${p2}.*/\1/g"
    sEVAL="sed -e '${sExprEVAL}'"       #   echo "sEVAL::  $sEVAL"
    RV="$( echo "${psSTRING}" | eval "${sEVAL}")"

    if is_empty_var "${isTHIS}"; then
          echo "${RV}" 2>/dev/null
         RETURN "${RV}"
    else
        if [ "${RV}" == "${isTHIS}" ]
        then
              echo "${RV}" 2>/dev/null
             RETURN "${RV}"
             return 0
        else
            RETURN "${RV}"
            return 1
        fi
    fi
}

######### OLD SCHOOL DELETE ! ex. FilesForWeb=$(to_lower "aLL wEb SeRvEr HtML FiLeNames")

 # ex.: sSTR="'One EFI' 'Two WINDOWS' 'Three BOOT' 'Four WIN' 'Five LIN' Fuck 'Six LINUZE'"
#      str_ADD "sSTR" "Ananin Herekesi" "top"
function str_ADD() {
REGFUNC="str_ADD"; RV="FALSE"
local -n psSTRINGLIST="$1"
local psCONTENT="$2"
local psOPT="$3"
local pWHERE="${psOPT:-"bottom"}"

array_from_text "aSTRINGLIST" "${psSTRINGLIST}"  #  arr_test "aSTRINGLIST"

    case "${pWHERE,,}" in

        "top"|"zero"|"0")      #Add the 0st element
            aSTRINGLIST=("${psCONTENT}" "${aSTRINGLIST[@]}")
            ;;

        "bottom"|"end"|"-1")   #Add after the last element
                aSTRINGLIST=("${aSTRINGLIST[@]}" "${psCONTENT}" )
                #add  to the end == arr+=( "new_element" )
            ;;

         *)     # wait 1 "top-bottom disinda girilen butun parametreler nRecNo'dur::${pWHERE}"
            if [[ "${pWHERE}" -eq 0 ]]     # dizinin en basini bizzat belirtmis! Dokunma!
            then ok                     # test()
            else let "pWHERE=pWHERE-1"    # BECAUSE arrays start from zero
            fi
                # echo "if ${WHERE} is overflowing ${nLenArr} . will be Corrected to LAST"
            if [[ "${pWHERE}" -gt "${nLenArr}" ]] ; then pnREC="${nLenArr}" ; fi
            aSTRINGLIST=( "${aSTRINGLIST[@]:0:$pWHERE}" "${psCONTENT}" "${aSTRINGLIST[@]:$pWHERE}" )
            ;;
    esac
aSTRINGLIST=("${aSTRINGLIST[@]}") # renumber the indexes! TEMPLATE!Important
psSTRINGLIST="${aSTRINGLIST[@]}"
}

# ex.: sSTR="'One EFI' 'Two WINDOWS' 'Three BOOT' 'Four WIN' 'Five LIN' Fuck 'Six LINUZE'"
#        str_INS "sSTR" "Ananin Herekesi" "top"
function str_INS() {
REGFUNC="str_INS"; RV="FALSE"
local -n psSTRINGLIST="$1"
local psCONTENT="$2"
local psOPT="$3"
local pWHERE="${psOPT:-"bottom"}"

array_from_text "aSTRINGLIST" "${psSTRINGLIST}"  #  arr_test "aSTRINGLIST"
local nLenArr="${#aSTRINGLIST[@]}"

    case "${pWHERE,,}" in

        "top"|"zero")      #INSERT the 0st element
                sElCurrent="${aSTRINGLIST[0]}"
                aSTRINGLIST[0]="${psCONTENT}"
            ;;

        "bottom"|"end")   #INSERT the last element
            sElCurrent="${aSTRINGLIST[-1]}"
            aSTRINGLIST[${nLenArr}]="${psCONTENT}"
            ;;

         *)     # wait 1 "top-bottom disinda girilen butun parametreler nRecNo'dur::${pWHERE}"
            if [[ "${pWHERE}" -eq 0 ]]     # dizinin en basini bizzat belirtmis! Dokunma!
            then ok                     # test()
            else let "pWHERE=pWHERE-1"    # BECAUSE arrays start from zero
            fi
                # echo "if ${WHERE} is overflowing ${nLenArr} . will be Corrected to LAST"
            if [[ "${pWHERE}" -gt "${nLenArr}" ]] ; then pnREC="${nLenArr}" ; fi

            sElCurrent="${aSTRINGLIST[${pWHERE}]}"
            aSTRINGLIST[${pWHERE}]="${psCONTENT}"
            ;;
    esac
aSTRINGLIST=("${aSTRINGLIST[@]}") # renumber the indexes! TEMPLATE!Important
psSTRINGLIST="${aSTRINGLIST[@]}"
}



 # ex.: sSTR="'One EFI' 'Two WINDOWS' 'Three BOOT' 'Four WIN' 'Five LIN' Fuck 'Six LINUZE'"
#        str_DEL "sSTR" "top"
function str_DEL() {
REGFUNC="str_DEL"; RV="null"
local -n psSTRINGLIST="$1"
local pWHICH="${2,,}"
local sDeletedEl=""

array_from_text "aSTRINGLIST" "${psSTRINGLIST}"  #  arr_test "aSTRINGLIST"
local nLenArr="${#aSTRINGLIST[@]}"

    case "${pWHICH,,}" in

        "top"|"zero")      #removed the 1st element
            sDeletedEl="${aSTRINGLIST[0]}"
            aSTRINGLIST=("${aSTRINGLIST[@]:1}")
            ;;

        "bottom"|"end")   #removed the last element
            # unset aSTRINGLIST[-1]  #removed the last element
            sDeletedEl="${aSTRINGLIST[-1]}"
            unset aSTRINGLIST[${nLenArr}-1]
            ;;

         *)     # top-bottom disinda girilen butun parametreler nRecNo'dur?!
            if [ "${pWHICH}" -eq 0 ]     # dizinin en basini bizzat belirtmis! Dokunma!
            then ok                     # test()
            else let "pWHICH=pWHICH-1"    # BECAUSE arrays start from zero
            fi

            sDeletedEl="${aSTRINGLIST[${pWHICH}]}"
                #  echo "if ${pWHICH} is overflowing ${nLenArr} . will be Corrected to LAST"
            if [ "${pWHICH}" -gt "${nLenArr}" ] ; then pnREC="${nLenArr}" ; fi

            unset aSTRINGLIST[${pWHICH}]  # remove the undesired item
            ;;
    esac
aSTRINGLIST=("${aSTRINGLIST[@]}") # renumber the indexes! TEMPLATE!Important
psSTRINGLIST="${aSTRINGLIST[@]}"
RETURN "${sDeletedEl}"
}


# ex.: sSTR="'One EFI' 'WINDOWS' '13.Sovalye' 'Three BOOT' 'Four WIN' 'Five LIN' Fuck 'Six LINUZE'"
#        str_del_this "sSTR" "13.Sovalye"
function str_del_this() {
REGFUNC="str_del_this"; RV="null"
local -n psSTRINGLIST="$1"
local psCONTENT="${2}"

array_from_text "aSTRINGLIST" "${psSTRINGLIST}"  #  arr_test "aSTRINGLIST"
local nLenArr="${#aSTRINGLIST[@]}"

    for i in "${!aSTRINGLIST[@]}"
    do
        sEl="${aSTRINGLIST[${i}]}"       # echo "$i -- ${sEl} ~ ${psCONTENT}"
        if [[ "${sEl}" == "${psCONTENT}" ]] ; then
            unset aSTRINGLIST[${i}]
            aSTRINGLIST=( "${aSTRINGLIST[@]}" )
            RV="${i}"
            break
        fi
    done

aSTRINGLIST=("${aSTRINGLIST[@]}") # renumber the indexes! TEMPLATE!Important
psSTRINGLIST="${aSTRINGLIST[@]}"
}

 # ex.: sSTR="'One EFI' 'WINDOWS' '13.Sovalye' 'Three BOOT' 'Four WIN' 'Five LIN' Fuck 'Six LINUZE'"
#        str_del_this_all "sSTR" "13.Sovalye"
function str_del_this_all () {
REGFUNC="str_del_this_all"; RV="null"
local -n psSTRINGLIST="$1"
local psCONTENT="${2}"
local n=0

array_from_text "aSTRINGLIST" "${psSTRINGLIST}"  #  arr_test "aSTRINGLIST"
local nLenArr="${#aSTRINGLIST[@]}"

    for i in "${!aSTRINGLIST[@]}"
    do
        sEl="${aSTRINGLIST[${i}]}"       # echo "$i -- ${sEl} ~ ${psCONTENT}"
        if [[ "${sEl}" == "${psCONTENT}" ]]
        then
            unset aSTRINGLIST[${i}]
            aSTRINGLIST=( "${aSTRINGLIST[@]}" )
            let "n=n+1"
            RV="${n}"
        fi
    done

aSTRINGLIST=("${aSTRINGLIST[@]}") # renumber the indexes! TEMPLATE!Important
psSTRINGLIST="${aSTRINGLIST[@]}"
 RETURN "${RV}">/dev/null
}

# ex.: sSTR="'One EFI' 'WINDOWS' '13.Sovalye' 'Three BOOT' 'Four WIN' 'Five LIN' Fuck 'Six LINUZE'"
#        str_del_contain "sSTR" "Sovalye"
function str_del_contain() {
REGFUNC="str_del_contain"; RV="null"
local -n psSTRINGLIST="$1"
local psCONTENT="${2}"

array_from_text "aSTRINGLIST" "${psSTRINGLIST}"  #  arr_test "aSTRINGLIST"
local nLenArr="${#aSTRINGLIST[@]}"

    for i in "${!aSTRINGLIST[@]}"
    do
        sEl="${aSTRINGLIST[${i}]}"       # echo "$i -- ${sEl} ~ ${psCONTENT}"
        local sHASNOT_contain="${sEl##*${psCONTENT}*}"
        if [[ "${sHASNOT_contain}" ]]
        then
            RV="null"
        else
            unset aSTRINGLIST[${i}]
            RV="${i}"
            break
        fi
    done

aSTRINGLIST=("${aSTRINGLIST[@]}") # renumber the indexes! TEMPLATE!Important
psSTRINGLIST="${aSTRINGLIST[@]}"
 RETURN "${RV}">/dev/null
}


# ex.: sSTR="'One EFI' 'WINDOWS' '13.Sovalye' 'Three BOOT' 'Four WIN' 'Five LIN' Fuck 'Six LINUZE'"
#        str_del_contain_all "sSTR" "Sovalye"
function str_del_contain_all() {
REGFUNC="str_del_contain_all"; RV=0
local -n psSTRINGLIST="$1"
local psCONTENT="${2}"

array_from_text "aSTRINGLIST" "${psSTRINGLIST}"  #  arr_test "aSTRINGLIST"
local nLenArr="${#aSTRINGLIST[@]}"

    local n=0
    for i in "${!aSTRINGLIST[@]}"
    do
        sEl="${aSTRINGLIST[${i}]}"
        echo "$i -- ${sEl} ~ ${psCONTENT}"
        local sHASNOT_contain="${sEl##*${psCONTENT}*}"
        if [[ "${sHASNOT_contain}" ]]
        then RV="null"
        else
            let "n=n+1"
            unset aSTRINGLIST[${i}] ; RV="${n}"
        fi
    done

aSTRINGLIST=("${aSTRINGLIST[@]}") # renumber the indexes! TEMPLATE!Important
psSTRINGLIST="${aSTRINGLIST[@]}"
 RETURN "${RV}">/dev/null
}


# ex.: sSTR="'One EFI' 'Two WINDOWS' 'Three BOOT' 'Four WIN' 'Five LIN' Fuck 'Six LINUZE'"
#        str_AT "sSTR" "6"
function str_AT() {
REGFUNC="str_AT"; RV="null"
local -n psSTRINGLIST="$1"
local pWHERE="$2"

array_from_text "aSTRINGLIST" "${psSTRINGLIST}"  #  arr_test "aSTRINGLIST"
local nLenArr="${#aSTRINGLIST[@]}"

    case "${pWHERE,,}" in

        "top"|"zero"|"0")      #give the 0st element
                RV="${aSTRINGLIST[0]}"
            ;;

        "bottom"|"end"|"-1")   #give the last element
                RV="${aSTRINGLIST[${nLenArr}-1]}"
            ;;

         *)     # top-bottom disinda girilen butun parametreler nRecNo'dur?!
            local pnREC="${pWHERE}"
            if [ "${pWHERE}" -eq 0 ]     # dizinin en basini bizzat belirtmis! Dokunma!
            then ok                     # test()
            else let "pWHERE=pWHERE-1"    # BECAUSE arrays start from zero
            fi
                # echo "if ${pWHERE} is overflowing ${nLenArr} . will be Corrected to LAST"
            if [ "${pWHERE}" -gt "${nLenArr}" ] ; then pWHERE="${nLenArr}" ; fi

            RV="${aSTRINGLIST[${pWHERE}]}"
        ;;
    esac
aSTRINGLIST=("${aSTRINGLIST[@]}") # renumber the indexes! TEMPLATE!Important
psSTRINGLIST="${aSTRINGLIST[@]}"
 RETURN "${RV}">/dev/null
}


# ex.: sSTR="'One EFI' 'Two WINDOWS' 'Three BOOT' 'Four WIN' 'Five LIN' Fuck 'Six LINUZE'"
#        str_seek "sSTR" "6"
function str_seek() {
REGFUNC="str_seek"; RV="null"
local -n psSTRINGLIST="$1"
local psCONTENT="${2}"

    array_from_text "aSTRINGLIST" "${psSTRINGLIST}"  #  arr_test "aSTRINGLIST"
                    ###local nLenArr="${#aSTRINGLIST[@]}"
    for i in "${!aSTRINGLIST[@]}"
    do
        ### echo "${i} -- ${aSTRINGLIST[${i}]}  -EQ  ${psCONTENT}"
        if [[ "${aSTRINGLIST[${i}]}" == "${psCONTENT}" ]]
        then RV="${i}"; break       # First FOUND !  returns nThEl_isFOUND
        fi
    done

 RETURN "${RV}">/dev/null
}


# Seek how many array elements that exactly same, COUNT()
# ex.: sSTR="'One EFI' 'Two WINDOWS' 'Three BOOT' 'Four WIN' 'Five LIN' Fuck 'Six LINUZE'"
#        str_seek_all "aTHIS" "$sSeekThis"     returns nTotal_isFOUND
function str_seek_all () {
REGFUNC="str_seek_all"; RV=0
local -n psSTRINGLIST="$1"
local psCONTENT="${2}"

array_from_text "aSTRINGLIST" "${psSTRINGLIST}"  #  arr_test "aSTRINGLIST"

local n=0
    for i in "${!aSTRINGLIST[@]}"
    do
        if [[ "${aSTRINGLIST[${i}]}" == "${psCONTENT}" ]]
        then let "n=n+1"
        fi
    done
    RV="${n}"

 RETURN "${RV}">/dev/null
}

# Search array elements for contain FIRST element recordNo
# ex.:   str_search "aTHIS" "$sContainThis"     returns nThEl_isMATCH
function str_search () {
REGFUNC="str_search"; RV=0
local -n psSTRINGLIST="$1"
local psCONTENT="${2}"

array_from_text "aSTRINGLIST" "${psSTRINGLIST}"  #  arr_test "aSTRINGLIST"

    for i in "${!aSTRINGLIST[@]}"       # i degil de sEl olmali
    do
        sEl="${aSTRINGLIST[${i}]}"
        echo "------------> ${sEl} ## ${psCONTENT}"
        local sHASNOT_contain="${sEl##*${psCONTENT}*}"
        if [[ "${sHASNOT_contain}" ]]
        then ok
        else RV="${i}"; break
        fi
    done

 RETURN "${RV}">/dev/null
}

# Search array elements for contain FIRST element recordNo
# ex.:   str_search_all "aTHIS" "$sContainThis"     returns nThEl_isMATCH
function str_search_all () {
REGFUNC="str_search_all"; RV=0
local -n psSTRINGLIST="$1"
local psCONTENT="${2}"

array_from_text "aSTRINGLIST" "${psSTRINGLIST}"  #  arr_test "aSTRINGLIST"
local nLenArr="${#psArrayTest[@]}"
arr_test "aSTRINGLIST"
local n=0
    for i in "${!psArray_OP[@]}"
    do
        sEl="${psArray_OP[${i}]}"
        local sHASNOT_contain="${sEl##*${psCONTENT}*}"
        if [[ "${sHASNOT_contain}" ]]
        then ok
        else let "n=n+1"
        fi
    done
    RV="${n}"
 RETURN "${RV}">/dev/null
}


# Search and Replace FIRST array element that exactly same
# ex.:   str_replace_word "sTHIS" "$sSeekThis"  "$sReplaceWith"       returns nThEl_isFOUND
function str_replace_word () {
REGFUNC="str_replace_word"; RV=0
local -n psSTRINGLIST="$1"
local psCONTENT="${2}"
local psOTHERCONTENT="${3}"

array_from_text "aSTRINGLIST" "${psSTRINGLIST}"  #  arr_test "aSTRINGLIST"

    for i in "${!aSTRINGLIST[@]}"
    do
    ###  echo "${i}"  "${aSTRINGLIST[${i}]}" "-EQ" "${psCONTENT} -->${psOTHERCONTENT}"
        if [[ "${aSTRINGLIST[${i}]}" == "${psCONTENT}" ]]
        then
            aSTRINGLIST[${i}]="${psOTHERCONTENT}"
            RV="${i}"   # +1 gerek miyor mu ?   let "i=i+1"
            break
        fi
    done
  psSTRINGLIST="${aSTRINGLIST[@]}"
 RETURN "${RV}">/dev/null
}


# Search and Replace ALL array elements that exactly same
# ex.:   str_replace_word_all "sTHIS" "$sSeekThis"  "$sReplaceWith"       returns nThEl_isFOUND
function str_replace_word_all () {
REGFUNC="str_replace_word_all"; RV=0
local -n psSTRINGLIST="$1"
local psCONTENT="${2}"
local psOTHERCONTENT="${3}"

array_from_text "aSTRINGLIST" "${psSTRINGLIST}"  #  arr_test "aSTRINGLIST"

  local n=0
    for i in "${!aSTRINGLIST[@]}"
    do
        if [[ "${aSTRINGLIST[${i}]}" == "${psCONTENT}" ]]
        then
            aSTRINGLIST[${i}]="${psOTHERCONTENT}"
            let "n=n+1"
        fi
    done
    RV="${n}"

 RETURN "${RV}">/dev/null
}



### Bir Karakter treninden , string listten, vagonlari, wordlari, karakterleri ayiklar
###### sServer='{"status":"ok","data":{"server":"srv-store1"}}'
###### str_remove_these "sServer" "{" "}" '"' "data:"
function str_remove_these() {
    local -n psSentence="$1"
    shift
    psDelWords="$@"
    aDelWords=("$@")      # Gelen parametrelerin hepsini diziye aktaralim
                            # ArrNum "${aDelWords[@]}"
    for sDelWord in "${aDelWords[@]}"
    do  # echo "deleting.. ${sDelWord}"
        psSentence=$( echo "${psSentence}" | sed "s/${sDelWord}//g" )
    done
  echo "${psSentence}"
}

# Search and Replace FIRST text piece
# ex.:   str_replace "sTHIS" "$sSeekThis"  "$sReplaceWith"       returns nThEl_isFOUND
function str_replace () {
REGFUNC="str_replace"; RV=0
local -n psSTRINGLIST="$1"
local psCONTENT="${2}"
local psOTHERCONTENT="${3}"

 psSTRINGLIST="$( echo "${psSTRINGLIST/$psCONTENT/$psOTHERCONTENT}" )"
 RV="${psSTRINGLIST}"
 RETURN "${RV}">/dev/null
}


    # To replace all occurrences, use ${parameter//pattern/string}:
    # 'The secret code is 12345' prints 'The secret code is XXXXX'
# ex.:   str_replace_num2x 'The secret code is 12345'  "X"
function str_replace_num2x () {
REGFUNC="str_replace_num2x"; RV=
local -n psSTRINGLIST="$1"
local psCHAR="${2}"

 psSTRINGLIST="$( echo "${psSTRINGLIST//[0-9]/$psCHAR}"  )"
 RV="${psSTRINGLIST}"
 RETURN "${RV}">/dev/null
}

################################################################################
# ex. : str="TwoOneFour" ; zzz="$(first_char "str")" ; echo "[$zzz] -> "T"
#return first char of a string
function first_char()
{
 [ -z "${1}" ] && return 1
 local pSTRING="${1}"
 RV="${pSTRING:0:1}"
 echo "${RV}" 2>/dev/null
 RETURN "${RV}"
}

function first_charrest()
{
 [ -z "${1}" ] && return 1
 local pSTRING="${1}"
 RV="${pSTRING:1}"
 echo "${RV}" 2>/dev/null
 RETURN "${RV}"
}

# ex. : str='"One Candle" "Two Candles" "Three Candles"
#       zzz="$(first_char "str")" ; echo "[$zzz] -> "One Candle"
#return first word-object of a string or string-sentences !!
function first_word()
{
 local psSTRING="${1}"
 [ -z "${psSTRING}" ] && return 1
   local psOPTseperator="${2}"
 if [ "${psOPTseperator}" ]  # 2. parametre bos degil, seperator belirtilmis..
     then array_from_text "psArray_OP" "${psSTRING}" "${psOPTseperator}"
     else array_from_text "psArray_OP" "${psSTRING}"
 fi            # arr_show "psArray_OP" "text den gelen psArray_OP"

 RV="${psArray_OP[0]}"
 echo "${RV}" 2>/dev/null
 RETURN "${RV}"
}

# ex. : str="One Two Three" ; zzz="$( first_wordrest "str")" ; echo "[$zzz] -> "One"
#return ALL_REMAIN after delete first word-object of a string or string-sentences !!
function first_wordrest()
{
 local psSTRING="${1}"
 [ -z "${psSTRING}" ] && return 1
   local psOPTseperator="${2}"
 if [ "${psOPTseperator}" ]  # 2. parametre bos degil, seperator belirtilmis..
     then array_from_text "psArray_OP" "${psSTRING}" "${psOPTseperator}"
     else array_from_text "psArray_OP" "${psSTRING}"
 fi            # arr_show "psArray_OP" "text den gelen psArray_OP"

 unset psArray_OP[0]
 psArray_OP=( "${psArray_OP[@]}" )

 RV="${psArray_OP[@]}"
 echo "${RV}" 2>/dev/null
 RETURN "${RV}"
}

function first_elem()
{
 [ -z "${1}" ] && return 1
 local -n paName="${1}"

 RV="${paName[0]}"
 echo "${RV}" 2>/dev/null
 RETURN "${RV}"
}

function first_elemrest()
{
 [ -z "${1}" ] && return 1
 local -n paName="${1}"

 unset paName[0]
 paName=( "${paName[@]}" )

 RV="${paName[@]}"

 echo "${RV}" 2>/dev/null
 RETURN "${RV}"
}

## Dosyadaki ilk satir
function first_line()   {
 [ -z "${1}" ] && return 1
 if is_exist_file "${1}" && isnot_empty_file "${1}" ; then    ## Dosya var-ve-bos degilse
    RV="$(head ${1} -n 1)"
  fi

 echo "${RV}" 2>/dev/null
 RETURN "${RV}"
}

## Dosyadaki ilk satir
function first_linerest()
{
 local psFILE="${1}"
 [ -z "${psFILE}" ] && return 1
 if is_exist_file "${psFILE}" && isnot_empty_file "${psFILE}" ; then    ## Dosya var-ve-bos degilse
    mapfile -t "aTmpFileRead"<"${psFILE}"
 fi

 unset aTmpFileRead[0]
 paName=( "${aTmpFileRead[@]}" )

 printf "%s\n" "${paName[@]}">"${psFILE}"

 echo "${RV}" 2>/dev/null
 RETURN "${RV}"
}



# ex:  sMyAnahtar=$(atLEFT "Key->Val" "->" )
# Eger PARSER karakteri girilmemisse default olarak "=" aliniyor,-en yaygin kullanim oldugu icin
#   cat "foo.ini" | while read kv ; do ; key=${kv%=*} ; val=$( echo ${kv#*=} | sed 's/^"\|"$//g')
# Aslında useless-cat yerine my_cat() deki gibi kullanmak daha iyi
function pairKEY  ()  { pPARSER=${2:-"="} ; echo $1 | sed "s/${pPARSER}.*//" ;}
function pairVAL  ()  { pPARSER=${2:-"="} ; echo $1 | sed "s/.*${pPARSER}//" ;}
    function atLEFT ()  { pPARSER=${2:-"="} ; echo $1 | sed "s/${pPARSER}.*//" ; }
    function atRIGHT () { pPARSER=${2:-"="} ; echo $1 | sed "s/.*${pPARSER}//" ; }

        ### ex:  is_inFIRST "A" "Adamin biri"        -> sRV= TRUE - FALSE
        function is_inFIRST () { if [[ ${1:0:1} == "${2}" ]] ; then echo 1; else echo 0; fi  }
            ###MOVED to atFIRST()

        ### ex: if is_inLIST  "Ahmet"  "Ali Ahmet Veli Deli"  - Cete elemani -> sRV= 0 veya 1
        function is_inLIST () {
            sSearch="$1"; shift ; strSearchThem="$@"
            sWasHere=$(echo "${strSearchThem}" | grep  "$sSearch")
            if test -z "$sWasHere" ; then  return 1 ; else return 0 ; fi
        }



# FIRST ============================
#         "CHAR" "WORD" "ARRAY" "LINE"  ========
#                                       "sObject" =========    -> sRV = char, word, sline
#                                             -+ "sBuMuDur?"   -> sRV = logic
#
#sWord="Bekir SONAT ve ZenOS Library"
        #RV="$( FIRST "CHAR" "${sWord}" )" ; echo "-> [$RV]"
        #RV="$( FIRST "WORD" "${sWord}" )" ; echo "-> [$RV]"
#declare -a aWords=( ${sWord} )  # Array_FROM "aWords" "WORDS" "$PATH" ":"
        #RV="$( FIRST "ARRAY" "aWords" )"; echo "-> [$RV]"
        #RV="$( FIRST "file" "$HOME/zen" )"; echo "-> [$RV]"
#echo "=============== SIMDI SAGLAMASINI YAPALIM ==========="
        #RV="$( FIRST "CHAR" "${sWord}" "b" )"        #isOK "$RV" && echo "dogrudur
        #RV="$( FIRST "WORD" "${sWord}" "Bekir" )"    #isOK "$RV" && echo "dogrudur
        #RV="$( FIRST "FILE" "myscript.sh" "#!/bin/bash" )"   #isOK "$RV" && echo "dogrudur ..
##  LASTX  -- DEL THEM!!!
function FIRST () {
psFUNC="${1,,}"
pxOBJECT="$2"
psOPT_CheckIt="$3"
local RV=

case "${psFUNC}" in
    "char")     # echo "kelimedeki ilk harf"
        local sWord="${pxOBJECT}"
        RV="${sWord:0:1}"    ;;
    "word")      #echo "cumledeki ilk kelime"
        local sSentence="${pxOBJECT}"
        RV="$(echo "${sSentence}" | awk '{print $1;}' )"    ;;
    "array")      # echo "dizideki ilk sifirnici figuran eleman artiz:[$2]"
        local -n aArray="$2"
        RV="${aArray[0]}" ;;
    "file")     # Dosyadaki ilk satir
        RV="$(head ${pxOBJECT} -n 1)" ;;

    "--help") echo "HELP()" ;;
    *) # echo "running ..."  ;;
esac

 if [[ "${psOPT_CheckIt}" ]] ; then
    ex="$( echo "${RV}" | egrep "${psOPT_CheckIt}" )"
    if [[ "${ex}" ]]           ## KOLAYI= if [[ "${RV}" = "${psOPT_CheckIt}" ]]
    then RV="TRUE"
    else RV="FALSE"
    fi
 fi
 echo "${RV}" 2>/dev/null
 RETURN "${RV}"
}

# ex: strLine_LINUZE=$(getUUID "mmcblk2p3" )  -> fb2f6c06-6b41-4dbd-894a-363c2ca2d6ba
function getUUID ()  {  disk_get_uuid "${1}" ; }
function disk_get_uuid ()  {
    psDevice="${1}"
    strDevice="/dev/${psDevice}"
    strUUID=$(sudo lsblk -no UUID "${strDevice}")
    RV="${strUUID}"
 echo "${RV}" 2>/dev/null
 RETURN "${RV}"
}


function check_for_root(){
    if [ "$UID" != "0" ]; then
        echo "`eval_gettext 'You need root privileges to run this'`"
        exit 1
    fi
}

function is_root_user()  { if [ "$UID" != "0" ]; then return 0; else return 1; fi ;}

function get_user_id ()
{
 psUSER=${1:-"$USER"}
 nUser=$(id -u "${psUSER}" )
 RV=$nUser
 echo "${RV}" 2>/dev/null
 RETURN "${RV}"
}



# ex: if ! test -z $( get_swap_disk )  ; then
function get_swap_disk()
{
    RV=""
            # ALL DEVICES OUTPUT  echo sListDevices:::$sListDevices
    local sListDevices=$(cat "/proc/swaps" | awk '{print $1}')
    local strExist=$(echo "$sListDevices" | grep "/dev/" )      # /dev/mmcblk0p4

    if ! test -z "${strExist}"  ; then
        RV=$(echo ${strExist} | awk '{print $1}')            # mmcblk0p1
    fi

 echo "${RV}" 2>/dev/null
 RETURN "${RV}"
}



function get_root_disk()
{
    RV=""
            # ALL DEVICES OUTPUT  echo sListDevices:::$sListDevices
    local sListDevices=$( df -hT | grep /$ | awk '{print $1}')
    local strExist=$(echo "$sListDevices" | grep "/" )

    if ! test -z "${strExist}"  ; then
        RV=$(echo ${strExist} | awk '{print $1}')            # mmcblk0p3
    fi
 echo "${RV}" 2>/dev/null
 RETURN "${RV}"
 }



########################################################################
    # AMA eger Path-siz-sadece-dosya-adi gonderilmisse RV olarak "." cevirir!!
    # empty_var() kontrolu icin BOSLUK gondermesi tercih edilir..
    #ex.: sRV=$( FILE
    #                 path name base ext link dirs owner perm date time size type mime
    #                 user uid group gid brief info encoding dev
    #            "$HOME/foo.txt" )
function FILE () {
psFile="${1}"
psWhat="${2,,}"      # lowerize
RV=""

    # AMA eger Path-siz-sadece-dosya-adi gonderilmisse RV olarak "." cevirir!!
    # empty_var() kontrolu icin BOSLUK gondermesi tercih edilir..
     # if [[ "${sPath}" == "." ]] ; then sPath="${PWD}"; fi

    case "${psWhat}" in
        "path"| "dir")
                    sPath="$(dirname ${psFile})"
                    if [[ "${sPath}" == "." ]] ; then sPath="${PWD}"; fi
                    RV="${sPath}";;   # /home/zen
        "basepath")
                    sPath="$(dirname ${psFile})"
                    if [[ "${sPath}" == "." ]] ; then sPath="${PWD}"; fi
                    sPath="$(echo $(basename ${sPath}) | cut -d'.' -f1)"
                    RV="${sPath}";;   # /home/zen
        "name")
                RV="$(basename ${psFile})" ;;  # deneme.txt
        "base")
                RV="$(echo $(basename ${psFile}) | cut -d'.' -f1)" ;;   # deneme
        "ext")
                sFile="$(basename ${psFile})"
                RV="${sFile##*.}" ;;    # txt
        "link")
                sLink="$(readlink ${psFile})"
                if [[ "${sLink}" == "." ]] ; then sLink=""; fi
                RV="${sLink}" ;;    # -> symlink
        "dirs" | "linkdir")     # GEREKSIZ-- symlink in isaret ettigi gercek dizini gosteriyor sozumona
                sLink="$(dirname "$(readlink ${psFile} )")"
                if [[ "${sLink}" == "." ]] ; then sLink=""; fi
                RV="${sLink}" ;;  # -> symlink  /home/zen  yerine
        "owner")
                 RV="$( ls -l "${sFile}"  | awk ' {print $3 } ' )"  ;;
        "perm"| "permnum" ) ;;  #
        "date")
                RV="$( stat -c %y "${psFile}")" ;;
        "time") ;;
        "size")
                # echo "$(du --apparent-size --block-size=1  "$fileName" | awk '{ print $1}')"
                RV="$(echo "$(wc -c "${psFile}" | awk '{print $1}')")" ;;
        "type") ;;  #
        "mime")
                RV="$(file --mime-type ${2})"   ;;  # us-ascii

        "is_empty")
                if [[ -f "${psFile}" ]] ; then
                    nfile_size="$(echo "$(wc -c "${psFile}" | awk '{print $1}')")"   # file_size ()
                    [[ "${nfile_size}" -lt 2 ]] && return 0 || return 1
                fi

            ;;  #
        "is_file"| "is_valid_filename" | "has_ext")  ;;  #
        "is_ro"| "readonly" ) ;;  #
        "is_rw"| "writable")  ;;  #
        "-U"|"user")
                RV="$( stat -c '%U' "${psFile}")"  ;;
        "-u"|"uid")
                RV="$( stat -c '%u' "${psFile}")"  ;;
        "-G"|"group")
                RV="$( stat -c '%G' "${psFile}")"  ;;
        "-g"|"gid")
                RV="$( stat -c '%g' "${psFile}")"  ;;
        "-b"|"brief"| "desc")
                RV="$(file --brief ${2})" ;;
        "-i"|"info")
                 s_inode="$( ls -i "${sFile}"  | awk ' {print $1  } ' )"
                 s_rootdev="$( df -hT | grep /$ )"
                 RV="$( sudo debugfs -R "stat <$s_inode>" $s_rootdev )"
                ;;
        "-e"|"encoding")
                RV="$(file --mime-encoding ${2})" ;;
        "-d"|"dev")
                RV="$(file -s /dev/${2})" ;;

        "all"| "report")
                echo "for sWhat in LIST ; RV=$( _file_info_info sWhat $2 )"
                echo $RV>>/tmp/$2.info
                RV="$( cat /tmp/$2.info )"  ;;
        *)  echo "USAGE ${2})" ;;  #
    esac
 echo "${RV}" 2>/dev/null
 RETURN "${RV}">/dev/null
}

function isnot_empty_file { if is_empty_file "$1" ; then return 1; else return 0; fi ;  }
function is_empty_file {
   local psFile="${1}"

   if [[ -f "${psFile}" ]] ; then
        local nfile_size="$(echo "$(wc -c "${psFile}" | awk '{print $1}')")"   # file_size ()
        [[ "${nfile_size}" -le 1 ]] && return 0
     else
        return 0
    fi
 return 1
}

######func get_file_ext     # TODO BUG! sfn="/home/zen/Deneme.log/fucked.txt" -> "log/fucked.txt"
# ex. sUzanti=$(get_file_ext "/home/zen/adiguzel_kendiboktan.html")  => "html"
function get_file_ext ()   {  file_ext "$1" ; }

# ex. sUzanti=$(get_dot_ext "/home/zen/adiguzel_kendiboktan.html")  => ".html"  # MORE SAFE - DEBUGGED
function get_dot_ext ()   {
 if [[ "${1}" = *.* ]] ; then RV=$(echo ".${1##*.}" ) ; else RV="" ;   fi

 echo "${RV}" 2>/dev/null
 RETURN "${RV}"
 }


# ex.: has_extension "$sUnknownFile" ; then "This is a file"      lastx
## Aslinda get_dot_ext() icindeki patterni kullaniyor..
function has_extension () {  if [[ "${1}" = *.* ]] ; then return 0; else return 1; fi ; }

#ex.: if is_it_file "$sUnknownFile"   ; then "This is a file"
function is_it_file ()
{
    if has_extension "${1}"
    then return 0
    else return 1
    fi
}

# ex.: is_it_extension "$sUnknownFile" "log" ; then "This is a log file"
function is_it_extension () {
 psFile="${1,,}" ;  psEXT="${2,,}"
 if [ "${psFile#*.}" == "${psEXT}" ] ; then return 0; else return 1 ; fi
}

function is_valid_FileName ()
{
    key=$1
    # String's length check
    val=$(echo "${#key}")
    if [[ $val -gt 255 ]]; then return 1 ; fi
    if [[ $val -lt 1 ]]; then return 1 ; fi       # 1den kucuk sayida dosya adi ise :)

    # Is valid characters exist
    if ! [[ $key =~ ^[0-9a-zA-Z._-]+$ ]]; then return 1 ; fi

    # First character check
    key=$(echo $key | cut -c1-1)
    if ! [[ $key =~ ^[0-9a-zA-Z]+$ ]]; then return 1 ; fi
 return 0
}

function is_valid_PathFileName ()
{
    psFullPathFileNameExt="$1"
    sFile=$(basename "$psFullPathFileNameExt")
    is_valid_FileName "${sFile}"
}

function is_writeable_folder () { if [ -w "$1" ]; then return 0; else return 1; fi ; }


 ### fff="${HOME}/INDEX"
### THERE="$(file_washere  "${fff}")" ;  echo "THERE:$THERE  for ${fff}"
function file_washere () {
psFileWhere="$1"
    sRV_here="$(dirname "$(readlink -f "${psFileWhere}")")"
 echo "${sRV_here}"
}

# Avoid for https://en.wikipedia.org/wiki/Cat_%28Unix%29#Useless_use_of_cat
# my_cat ex.: sMem=$( file_cat "$HOME/mem" )        #lastx
function file_cat () {
local srv_lines=""
if [ -e "$1" ] ; then
    while IFS= read -r frline;
    do
        echo "$frline"
        srv_lines+="$frline"
    done < "$1"
  else
    echo "$1 file NOT FOUND! "
fi
 echo "${srv_lines}"
}


# ex.: file_cat_grep "$HOME/mem" "MYTEMP="
function file_cat_grep () {
    local sFile="$1" psGrep="$2"
    if [[ "$#" -gt 1 ]] ; then
            while IFS= read -r line; do
              echo "$line"
            done < <(grep "${psGrep}" "${sFile}" )
                # grep . yerine grep "" kullanmak, boş satırları atlayacaktır.
    else
        # Okunulan EOF-satirinin newline ile bitmeme ihtimaline karsi,
        # basitce okunulan satirin bos olup olmadigi ile iktifa edelim..
        while IFS= read -r line || [ -n "$line" ]; do
          echo "$line"
        done <"${sFile}"
    fi
}

# ex.: file_cat_lastline "$HOME/.bashrc"
function file_cat_lastline () { echo "$( awk '/./{line=$0} END{print line}' "$1"  )" ; }

function file_rename_all() {
# Belirtilen klasor ve alt klasorlerindeki dosyalarin TAMAMININ isminde
# gecen bir metni arar ve diger bir metin ile degistirir.
# Kullanim: file_rename "index-template.HTM" "index-default.html" "/home/my/lin/zen/os/code/run/fuckdel/"
psSearch="$1"
psReplace="$2"
psInPATH=${3:-"$PWD"}   # Eger dizin belirtilmemisse scriptin calistirildigi dizinde gecerli olsun

    if [ $# -lt 3 ] ; then
        echo "Eksik parametre! Exiting..  TODO! Default-path $PWD ata! "
        exit 1
    fi

    find "${psInPATH}" | grep "${psSearch}"  | while read sNameOfFile;
    do
        mv "${sNameOfFile}" "${sNameOfFile//$psSearch/$psReplace}";
    done
}

# ex.: sLinkToHere=$( resolve_symlink "$HOME/filez" )           ->     /my/win/home/user/zen/filez
# Usage: resolve_symlink file
# Find the real file/device that file points at
function resolve_symlink () {
    tmp_fname=$1
    # Resolve symlinks
    while test -L $tmp_fname; do
        tmp_new_fname=`ls -al $tmp_fname | sed -n 's%.*-> \(.*\)%\1%p'`
        if test -z "$tmp_new_fname"; then
            echo "Unrecognized ls output" 2>&1
            exit 1
        fi

        # Convert relative symlinks
        case $tmp_new_fname in
            /*) tmp_fname="$tmp_new_fname"
            ;;
            *) tmp_fname="`echo $tmp_fname | sed 's%/[^/]*$%%'`/$tmp_new_fname"
            ;;
        esac
    done
    echo "$tmp_fname"
}

# ex.: sr_file_text "myFile.txt" "Falan" "Fismekan"
function sr_file_text() {
if [ $# -ne 3 ] ; then
  echo "Usage: `basename $0` old-pattern new-pattern filename"
  E_BADARGS=65   # Wrong number of arguments passed to script.
  exit $E_BADARGS
fi

file_name="$1"
old_pattern="$2"
new_pattern="$3"

if ! [ -f "$file_name" ] ; then
    echo "$file_name -404 File does not exist."
    exit $E_BADARGS
fi

# -----------------------------------------------
sed -e "s/$old_pattern/$new_pattern/g" "$file_name"
# -----------------------------------------------
#  's' is, of course, the substitute command in sed,
#  and /pattern/ invokes address matching.
#  The "g", or global flag causes substitution for *every*
#  occurence of $old_pattern on each line, not just the first.

 exit 0    # Successful invocation of the script returns 0.
}



# ex.: FIND  --file "one-file.txt"  |
#                       --folder "/var/www" --ext "htm html js css" --filemask "index*"
#                       --search "falan"    --replace "fismekan"
# ex.: FIND "/var/www" "html"
FIND () {
### func "p1" "-p2 ps2" "-p3 ps3"  "x" "y" "z"
###
### while [[ $# -gt 0 ]]
###     do
###     sREMAINS="${1}"
###     case "${sREMAINS}" in
###         --path) echo "--folder:$2" ;  shift;shift    ;; # past argument # past value
###         --file)  echo "--file:$2" ;  shift;shift    ;; # past argument # past value
###         --ext)  echo "--ext:$2" ;  shift;shift    ;; # past argument # past value
###         --filemask) echo "--filemask:$2" ;  shift;shift    ;; # past argument # past value
###  --perm) echo "--perm:$2" ;  shift;shift    ;; # past argument # past value
###  # find / -perm /u=r     # Find all Read Only files.
###  # find / -perm /a=x    # Find all Executable files.
###  # ###  # ###  # ###  # ###  # ###  -EXEC s
        ###  Find all 777 permission files and use chmod command to set permissions to 644.
        ###  # find / -type f -perm 0777 -print -exec chmod 644 {} \;
        ###
        ###  To find and remove multiple files such as .mp3 or .txt, then use.
        ###  # find . -type f -name "*.txt" -exec rm -f {} \;
        ###  #
###  #  https://www.tecmint.com/35-practical-examples-of-linux-find-command/


###         --search) echo "--search:$2" ;  shift;shift    ;; # past argument # past value
###         --replace) echo "--replace:$2" ;  shift;shift    ;; # past argument # past value
###         *) tag="${@}" ; opt="${opt,,}" ; echo "opt:$opt" ; break   ;;
###                     # lowerize.. parametreler programcidan herzaman ayni syntax ile gelmez
###     esac
###     done
nPARAM="$#"
sDefParaFILE="FIND.PARA"        # sDefParaFILE= Parameter -Config dosyasi
    # Fonksiyon parametresiz cagrilmissa, .config dosyasi olusturmasi veya yuklemesi isteniyor
    if is_it_ZERO "${nPARAM}" ; then
        if is_exist_file "${sDefParaFILE}" ; then
                  # aDefPara = Parameter dosyasindan okunan DEFAULT parametreler dizisi
                # TODO "path=blah"  yerine "--path 'blah'" yapilacak !!
                #ARRAY  "aDefPara" "fromini" "${sDefParaFILE}"
                #sDefParameters="${aDefPara[@]}"
                sDefParameters="$( file_cat "${sDefParaFILE}")"
            wait 5 "RECURSIVE-> ${sDefParameters}"
            FIND "${sDefParameters}"
        else
          sDefParameters="--path "$PWD" --ext "*" --search "foo" --replace "zoo" --tags "recursive" "
          echo "${sDefParameters}">"${sDefParaFILE}"
          wait 1 "NEW ${sDefParaFILE} Exit-1 ing!.."
          exit 1
        fi
    fi

    wait 2 " start_with  -  ???? ${1}"
    if [[ ${1:0:1} == "-" ]] ; then        # if start_with "-" "${1}"
        while [[ $# -gt 0 ]]
        do
            case ${1} in
                --path) sPath="$2"  ; shift ; shift ;;
                --file) sFile="$2" ; shift ; shift ;;
                --ext)  sExt="$2"  ; shift ; shift ;;
                --filemask) sFileMask="$2" ; shift ; shift ;;
                --search)  SEARCH="$2"  ; shift ; shift ;;
                --replace) REPLACE="$2"  ; shift ; shift ;;
                --tags) TAGS="$2"  ; shift ; shift ;;
                *)  ufo="$1"; UFO="$UFO $ufo"  ; shift  ;;    # past argument
            esac
        done

        echo " --path $sPath --file $sFile --ext $sExt --filemask $sFileMask --search $SEARCH --replace $REPLACE --tags $TAGS UFO=$UFO"

    else
        WHAT="$1"; THE="$2"; FUCK="$3"; TAGS="$4"        ## Bu syntaxta UFO-lara YER YOK!!
        echo "DONT SEE!!! nPARAM:$nPARAM  WHAT=$WHAT  ...  TAGS=$TAGS  ---  UFO=$UFO"
    fi



    ## OPTIONAL CONTROL BLOCKs
     is_inLIST "recursive" "${TAGS}" &&  isRecursive="YES"
     is_inLIST "regexp" "${TAGS}" &&  isRegExp="YES"
     is_inLIST "dialog" "${TAGS}" && isDialog="YES"
     is_inLIST "tmpFILE" "${TAGS}" && is_tmpFILE="YES"
     is_inLIST "tmpARRAY" "${TAGS}" && is_tmpARRAY="YES"


    echo "#==================================================="
    echo "# S/R For  $sPath   : $SEARCH  => $REPLACE "
    echo "#=================================================== "


    if is_it_TRUE "${isRecursive}" ; then          #
    echo " YESSSS BE ANNEM isRecursive  == ${isRecursive}"
        find $sPath -iname "$sExt" -readable -writable -exec sed -i "s/$SEARCH/$REPLACE/g" {} \;
    fi
    if is_it_TRUE "${is_tmpFILE}" ; then          #
        echo " YESSSS BE ANNEM is_tmpFILE  == ${is_tmpFILE} ... writing to:$TEMPFILE"
        find $sPath -iname "$sExt" -readable -writable -exec sed -i "s/$SEARCH" {} \; >"$TEMPFILE.SEARCH"
    fi                                  # LASTX LASTX           | xargs ile dene

    if is_it_TRUE "${is_tmpARRAY}" ; then          #
        echo " YESSSS BE ANNEM is_tmpARRAY  == ${is_tmpARRAY}"
        find $sPath -iname "$sExt" -readable -writable -exec sed -i "s/$SEARCH/" {} \;
    fi

}



### ex:  nHarf=$( charcount "Kendini çekiç sanan etrafındakileri çivi olarak görür." )       -> sRV= nums
function count_chars () { expr length "${1}" ;}

### ex:  nKelime=$( wordcount "Kendini çekiç sanan etrafındakileri çivi olarak görür." )       -> sRV= nums
function count_words () { echo "${1}" | wc -w ;}

#ex: slist='"<-forEXIT" "*.sh" "*.py" "*.ini"'  ; zzz=$(count_lists "${slist}") -> 4
     # XXX WordCount daha tutarli.. "$#" sapitiyor !
function count_lists () {  echo $(wc -w <<< "$@")  ; }


### ex:  extr ""#de/ne*dos9a\$a2.prg"        -> sRV= denedos9aprg
function sed_extr () { echo "$1" | sed -e 's/[^[:alnum:]]//g' ; }

######func str_rep(): Bir string katar icinde s-r yapar.. BUYUK/kucuk duyarlidir
#################### ex. sTevatur=$(str_rep "Falancanin oglu falan kizla evlendi." "falan" "fismekan")
function char_replace() { echo "$1" | sed "s/$2/$3/g" ; }
# ex.: char_replicate "#" "12"    Aslinda echoc "12" "#" ile ayni



function todays () { sDate=$(date +"%A, %B %-d, %Y");  echo "Today's date is:${sDate}"; }
function str_today () { sDate=$(date +"%Y_%m_%-d");  echo "${sDate}"; }
function str_time () { sDate=$(date +"%H_%M_%S");  echo "${sDate}"; }
function str_timestamp () { echo "$(date +"%Y_%m_%-d_%H_%M_%S")" ; }

  # memVar tanimlanmis ama ici bos.. insanca cumle icin Swapping !
function is_empty_var()  { if test -z "$1";then return 0; else  return 1; fi ;}
function isnot_empty_var()  { if test -z "$1";then return 1; else  return 0; fi ;}

# ex.: unset sSTR ; sSTR="One Two Three" ; if is_var_defined "sSTR" ; then echo "sSTR is set" ...
function is_exist_var() {
local -n sVarNameIfExist="$1"
 [[ ${sVarNameIfExist} ]] && return 0 || return 1
}
function isnot_exist_var() { if is_exist_var "$1"; then return 1 ; else return 0 ; fi ;}


    # insanca cumle icin Swapping !
function is_exist_file () { if [ -f "$1" ];then return 0; else return 1; fi;}
function isnot_exist_file () { if [ -f "$1" ];then return 1; else return 0; fi;}

    # dosya yoksa VEYA oldugu halde ustune yazma izni verilecekse, GDD OKAY olur..
function exist_file () {
 if [ -e "$1" ]
   then
      if okay "$1 exist. Are you sure overwrite ?"
        then return 0
      fi
 fi
 return 1
}

     # sadece islenecek dosya degil, tarif edilen klasor de yoksa once path'i yaratir sonra file'i
function XXXsafe_file () {
 local psf_ExistOrNot="$1"
 local sPathOf

 if isnot_exist_file "${psf_ExistOrNot}"
   then
      FILE "${psf_ExistOrNot}" "PATH" ; sPathOf="$RETURN"
      if okay "$psf_ExistOrNot not exist. Because sPathOf:[$sPathOf] not exist.. Create it ?"
        then
            if safe_mkdir "${sPathOf}"
              then touch "${psf_ExistOrNot}"
              else return 1
            fi
      fi
  fi
}

function is_exist_dir ()  { if [ -d "$1" ] && [[ -n $1 ]]; then return 0; else return 1; fi ;}
function isnot_exist_dir ()  { if [ -d "$1" ] && [[ -n $1 ]]; then return 1; else return 0; fi ;}

# $1: directory  , is empty or not     ->  RV  -> 0 =Empty
function is_empty_dir () {
    for FILE in $1/* $1/.*
    do
        case "$FILE" in
          "$1/.*") return 0 ;;
          "$1/*"|"$1/."|"$1/..") continue ;;
          *) return 1 ;;
        esac
    done
    return 0
}

# $1: directory ( maybe contains .dotted hidden files )  , is empty or not     ->  RV  -> 0 =Empty
function is_dir_empty () { if [ "$(ls -A $1)" ]; then return 1 ; else return 0 ; fi ; }


    # insanca cumle icin Swapping !
function isnot_exist_command () {
         if is_exist_command "$1"; then return 1 ; else return 0; fi
}

function is_exist_command () {
psApplication_command="$1"
app_exist=$(command -v "$psApplication_command" )
    if test -z "${app_exist}"
    then return 1
    else return 0
    fi
}


### sEditor=$(safe_command "/home/my/lin/zen/app/geany/AppRun" )
### if is_null "${sEditor}"
### then echo "null fail editor"
### else echo "sEditor === $sEditor "
### fi
### ex: safe_command "myfunnytexteditor"   -> sRV= default -or- null -or- new_entered Application Name
function safe_command () {
APP_COMMAND_NAME="${1}"

if isnot_exist_command "${APP_COMMAND_NAME}"; then
    msg+="[${APP_COMMAND_NAME}] is NOT FOUND"
    msg+=" in your PC or Application NOT DEFINED in your PATH!"
    msg+=" Enter an VALID Application/Command NAME ( have to in PATH )"
    #echo "${msg}"
    read -p "${msg} or press 0 for exit :" APP_COMMAND_NAME

    if [ "${APP_COMMAND_NAME}" == "0" ] ; then
        APP_COMMAND_NAME="null"
     else
        safe_command "${APP_COMMAND_NAME}"
    fi
fi
 echo "${APP_COMMAND_NAME}"
}


###### okay alarak processe devam eder okay() {  # ex. if okay "Yapilacak isleme emin misiniz?"
function okay() {
    echo -e -n "\\033[0;1m=== $1 (yY/nN) :\\033[0m"
    read -n1 REPLY
    REPLY=${REPLY,,}    # tolower
    REPLY="${REPLY:-"y"}"
            # So if you use webpath=${webpath:-~/httpdocs} you will get a
            # result of /home/user/expanded/path/httpdocs not ~/httpdocs, etc.
    echo ""
    if [[ "$REPLY" = "y" ]]; then return 0; else return 1; fi
}

######   # ex. if isnot_okay "Devam mi?" ; then echo "break" ; fi
function isnot_okay() { if okay "$1"; then return 1 ; else return 0 ; fi  ;}

## User Input promptuna default bir deger gosterilmesini de destekler.
## O mem-variable i da GDD olarak kullanir
######  sSelectedDisk="sda1" ; read2var "sSelectedDisk" "Select New Disk"
function read2var() {
    local -n psDefVar="$1"
    local psMessage="$2"

    echo -e -n "\\033[0;1m ${psMessage} >\\033[0m"
    read -e -i "${psDefVar}" REPLY

 psDefVar="${REPLY}"
 RETURN "${psDefVar}"
}

## LASTX
function read2num() {
    local sMenu="${1:-"> Input:"}"

    echo -e -n "\\033[0;1m${sMenu}\\033[0m"
    read -n1 nMenuCevap
    #### if [[ "$REPLY" = "0" ]]; then REPLY="null" ; fi
    #### case "$REPLY" in 0) echo "0 exit" ;; 1) echo "bir" ;; *) echo "rep:$REPLY" ;; esac
 #### echo "${REPLY,,}">/dev/null
 RETURN "${nMenuCevap}"
}



### ex:          -> sRV=
function USAGE () { echo "Manual Here" ; }

# Aslinda basit ve low-level bir REG() molekulu..
# echo "$Return" zibidiliginden kurtulmak icin
#     PUBLIC olan RETURN degerine atiyoruz ve sonrasinda tutuyoruz.
# Bununla da yetinmeyip, /tmp/RETURN dosyasinin icine yaziyoruz
#    sonrasinda CATirdatip hede cekirdegini citliyoruz
# ex.:       nChoiced="$REPLY" ; mem "$nChoiced"  ya da MEM="$nChoiced"
# ex.: mem "sMyValue4return"    #->   MEM="sMyValue4return"
# Parametresiz cagrildiginda sistemdeki $MEM icerigini okur,atar ve sonra sistemden siler!
# ex.: xReturned="$(MEM)"  YA DA xReturned="${MEM}"  seklinde cagrilir
#                 ======                    ======
# xReturned="$(mem)" veya xReturned="${MEM}" veya xReturned="$(cat /tmp/mem )"
### Duplicate of RV().. memorizable :)
function MEM () { RETURN "$@" ;  }


# imitates return command.. Dont use MEM , SRv, REGVAl, RV etc..
# ex. : ArrDel  "aTHIS" "3"; sGeriDonen=$RETURN ;
function RETURN () {
    sfRETURN="${TEMP:-"/tmp"}/RETURN"

    if [[ $# -lt 1 ]]; then             # RETURN
        local hede="$(cat "$sfRETURN")"
        RETURN="${hede:-"null"}"    # dosya yoksa veya bossa null gonder
        echo "null">"$sfRETURN"     # Okuyup cekirdegi citledigimize gore kabuga tukurelim
    else                            #   RETURN "Bekir"
         RETURN="$1" ; echo "${RETURN}">"$sfRETURN"
    fi
 echo "${RETURN}">/dev/null
} # xReturned="$(RETURN)" veya xReturned="${RETURN}" veya xReturned="$(cat /tmp/RETURN )"



### TODO SRV() saglam ve demirbas bir kod-dur, zirt-pirt degistirme!
### Used algorithm in function SAFE().. SRV "NOTFOUND" ; rv=$(SRV) ; if [[ $mysrv == "OKAY ]]; then ...
### ex:  SRV "BenDegiskenim_AlBeni"    -> sRV= "BenDegiskenim_AlBeni"  VE  mysrv=$(SRV)  => "BenDegiskenim_AlBeni"
function SRV () { MEM "$@" ; }

## !!! SAFE() WILL BE MOVED TO REGMEM() - Cunku SRV() bagimliligi yok  !!!!!!!!!!!!
 ### 08/03/2020 $TMP KLASORU $MEM KLASORU ILE DEISTIRLDI
### AIM: Kullanilacak BellekDegiskenini SYSTEM-VARIABLEs yardimiyla garantiye alir, DEFAULT deger atar.
### SRV ile MEM kaydini da yapar, RV olarak kullandirir. echo2XXX() fonksiyonlari tarafindan sik kullanilir.
### TODO SRV() saglam ve demirbas bir kod-dur, zirt-pirt degistirme!
### TODO!  ~/.MEM icindeki var=val pair icin REGMEM() tarzi 2 boyutlu - tek dosyali model de kurulabilir.
# ex: sLogFile_for_SR_files= $( REGMEM  "sLogFile_for_SR_files"  "tmp/Bulunan_dosyalar.txt" )  -> sRV=
##   out2file=$( REGMEM "out2file" "/temp/Bulunan_dosyalar.txt")  VEYA
##  out2file=""   out2file=$( REGMEM "out2file"  "$out2file")
## !!!!!!!!!!!!!!!!!!! WILL BE MOVED TO REGMEM()  !!!!!!!!!!!!!!!!!!!!!!!!!!!
function SAFE () { REG "$@" ; }

### Simdilik REGMEM() den kopya edildi.. Ama daha low-level isler icin kullanilacak.
### BASH'in RetunValue kullanma sikintisini asmak icin, mem-var-lar in ilgili-fonksiyon-adindaki dosyalarin
### icerisine Return-Value degerleri koymak icin kullanilacak..
### Zero-fault-tolerant yani kusursuz calismasi gerek!
### 2021-NEWs - Her fonksiyon'un ADINI REGFUNC public degiskenine atayarak sisteme kaydediyor.
### Library icinde public RETVAL e atanmis butun Return-Value niteligi olan degiskenleri
### REG-Ettigi-Ad'daki dosyaya yaziyor. sRV=$REG   komutu ile cagiran fonksiyon icinden okunabilir..
### ilgili fonksiyonun sonunda sadece bir tek "REG" komutu ile bu isi hallediyor.
### YANI, her fonksiyon acma-kapama braketleriyle yapisik olarak "REG" ifadesi var.
###  KISACA, echo ile {RV} gonderme hatalarindan kurtulmayi umuyoruz !
### TEK PARAmetre ile cagrildiginda,  MEMory-Name icindeki VARiable i okumak istiyor
### LAST Edited 21.10.2020 19:15
function REG () {                ### REG is a FUNC, but $REG is a PUBLIC-GLOBAL_MEMORY-VARIABLE
if [[ "$#" -lt 1 ]]
then
    local Name="$REGFUNC"       ### $REGFUNC is a PUBLIC-GLOBAL_MEMORY-VARIABLE
    local Content="$REGVAL"     ### $REGVAL  is a PUBLIC-GLOBAL_MEMORY-VARIABLE
else
    local Name="$1"
    local Content="$2"
fi

    MEMDIR=${MEMDIR:-"${ZEN}/mem"} ; mkdir -p "${MEMDIR}"
    MEMFILE="${MEMDIR}/${Name}"   # ~/zen/mem/"Name"

    # Sadece TEK PARAmetre ile cagrilmissa MEMory-Name icindeki VARiable i okumak istiyor
    if test -z "${Content}"; then
        if test -f "${MEMFILE}" ; then
            REG="$(cat "${MEMFILE}" )"       # cat yerine readfile() kullanmak dusunulebilir mi?
         else       # Mem-Var-FileName yoksa olusturalim ve sistemde bilinsin
            echo "${Name}">"${MEMFILE}"
            REG="${Name}"
        fi
    else # echo  İki parametrede varsa,yani Content verilmisse, Var-Name icine kaydedilmek istiyor.
        echo "${Content}">"${MEMFILE}"
    fi
 echo "${REG}"
} # Sistemdeki Public $REG e en son minciklanan Variable'in Ismi kayit ediliyor



function tmplog () {  logtmp "$1" ; }
## En basit - hizli -raw log'ging.. tmp.log dosyasina yazar, parametresiz-cagrilarak-okundugu-an kendisini siler
#### ex: logtmp  "bla bla blah"

function logtmp () {
tmplog="${TMP:-$ZEN/tmp}/tmp.log"
    if [[ $# -lt 1 ]]; then
        cat "${tmplog}"
        rm -f "${tmplog}"      #lastx TODO silmesek de olur mu acaba
    else
        echo "#[${0}]  ${1}">>"${tmplog}"
    fi
 }



#### En basit - hizli -raw   echo "blah bblah">>"deneme.out" zamazingosu.. MUTLAKA 2 PARAMETRE DE GIRILMELI!
#### SADECE 1. PARAMETRE OLARAK dosya_adi yaziliyor.. DAHA KOMPLIKE LOG isleri, log() ile yapiliyor..
#### ex: echo2 "$HOME/temp/deneme.txt" "bla bla blah"
function e2f ()
{
    local psFile="${1}"
    local psWriteLine="${2}"

    local sPathOfFile="$( FILE "${psFile}" "PATH" )"
    if isnot_exist_dir "${sPathOfFile}" ; then
        safe_mkdir "${sPathOfFile}"
        touch "${psFile}"
    fi
    echo "${psWriteLine}">>"${psFile}"
}

# Fonsiyona ozel olarak bir degiskeni /zen/mem sistemine REGISTER ederek kullandirir.
# 22.10.2020 itibariyla kusursuz calisiyor. MINCIKLAMA!
# ex.: REGMEM "echo2" "myApp.ini"
#      echo2 "language=tr"
#      echo2
#
function echo2 (){
REGFUNC="echo2"
REGVAL=""
MEMDIR=${MEMDIR:-"${ZEN}/mem"} ; mkdir -p "${MEMDIR}"
    case "$#" in
        2)  # echo2 "/tmp/Deneme.log"  "Blah blah blah"
            echo "$2">"$1"      # echo "Blah blah blah">/tmp/Deneme.log
          ;;
        1)  # echo2 "Blah Blah Blah"
            local Content="$1"      # "$1" yerine "$@" kullandik ki, her bir katari alabilsin..

                # Pekala, bu icerik dizisi Hangi dosyaya yazilacak karar verelim simdi..
                # Herseyden once bu dosyanin adi "echo2" ile sisteme register edilmis mi?
                # nadiren de olsa daha onceden sisteme register edilmeden dosyaya satir
                # yazmaya calisirsa, bu sefer bir-temporary-dosya-olarak
                # "echo2.log" adli bir dosya olustururarak sisteme register eder.

            if test -e "${MEMDIR}/echo2"
            then  local echo2file="$( cat "${MEMDIR}/echo2" )"  # "/tmp/Deneme.log"
                 #local echo2file="$( REG "echo2" )"
                 # ASLINDA ~/zen/mem/echo2 yoksa REG() bir tane olusturuyor
            else local echo2file="$ZEN/tmp/echo2.log"
                 REG "echo2" "${echo2file}"                # "/tmp/echo2.log"
            fi
            echo "${Content}">>"${echo2file}"
          ;;
        0)  # echo2
            safe_rm "${MEMDIR}/echo2"
          ;;
        *) echo "bad usage.. Muhtemelen satirda tirnak hatasi yuzunden zilyon parametre var saniliyor" ;;
    esac
}

# QUOTE_it.. Printf yerine AsciiART ve Colored..
function QUOTE_it() {
local psMsgQuote="$1"
array_from_text "aElements" "$psMsgQuote"

## "%" "Sinead Mc O'Connor" "I dont want anything,-I havent got" "en,lyric"
sAuthor="${aElements[0]}" ; sQuote="${aElements[1]}" ; sTags="${aElements[2]}"
echox "bold" "------Also sprachen ${sAuthor} :"
echox "blue" "${sQuote} ---"
}

# QUOTE .. $/HOME/zen icinden cesitli quote-text-database dosyalarindan RANDOM kayit secip goruntuler
function QUOTE() {
sQuoteDir="${1:-"$ZEN/user/filez/quotes"}"
declare -a aTags=(en fun wise programming linux)  # Array of aQuotes
local nLenTag=$(arr_len "aTags" )

sFileOfQuote=""
for sTag in "${aTags[@]}"
do
    sRandTag="${aTags[RANDOM % ${nLenTag}]}"
    sFileOfQuote="${sQuoteDir}/quote_${sRandTag}.text"

    if is_exist_file "${sFileOfQuote}"
    then
        sFileOfQuote="${sFileOfQuote}"
        break
    else
        mkdir -p "${sQuoteDir}"
    fi
done

if is_empty_var "${sFileOfQuote}"
then
    sFileOfQuote="${sQuoteDir}/quote_default.text"
    echo '"%" "zen os said:" "You have not got quote database.. created default one as ${sFileOfQuote} " "en"'>"${sFileOfQuote}"
fi

declare -a aQuotes=()  # Array of aQuotes
declare -i nth=0   # Index of fortune currently being read

while IFS= read -r line ; do
    if [[ $line == '%' ]]
     then
        nth+=1
     else
        aQuotes[nth]+="$line"
    fi
done < "${sFileOfQuote}"
           sMsgQuote="${aQuotes[RANDOM % ${#aQuotes[*]}]}"
QUOTE_it "$sMsgQuote"
}


#################################################################
######################## FUNCs for FILE ########################
#################################################################

#lastx ex.:   file_comment_out "${tmpfile}"
function file_comment_out () {
psFile="$1"
psComment="${2:-"#"}"
psFileOut="${3:-"${psFile}.out"}"

        mapfile -t "arraytmp"<"${psFile}"
        printf "# %s\n" "${arraytmp[@]}">"${psFileOut}"
}


# ex.:   REPLY "Seçiminiz:" ;   nSecilen="${REPLY}"
function REPLY() {
    local sMenu="${1:-"[0] <- EXiT  -> Choose:"}"
    echo -e -n "\\033[0;1m${sMenu}\\033[0m"
    read -n1 REPLY
}

# ex.:
 #num="$(StrMENU "OK Cancel Ignore")"
 #if is_null "$num"
  #then echo "null value"
  #else echo "fin num $num"
    #case ${num} in
        #1) echo "Okaaay()" ;;
        #2) echo "Cancel()" ;;
        #3) echo "Ignore()" ;;
    #esac
 #fi
#  ex.:
#      StrMENU  "OK" "Cancel" "Ignore"
#      if isnot_null "$RETURN"        #  if isnot_zero "$REPLY" ; then..
#
function StrMENU() {
  local array_menu=("$@")
  RV="[null]"
  nlenarr="${#array_menu[@]}"
  echo -e "\\033[0;47m"
  echo -e "\\033[1;47m 0 <-Exit Menu"
  select option in "${array_menu[@]}"
  do
    if [[ $REPLY -gt $nlenarr ]] ; then echo "Try Again!" ; continue ; fi
    if [[ $REPLY -eq 0 ]]
    then RV="[null]" ; break
    else RV="$option"; break
    fi
  done
  echo -e "\\033[0m"

 echo "${RV}" 2>/dev/null
 RETURN "${RV}"
}

# lastx 14.01.2021 Yukaridakini iptal et..
#  ex.:    menu_str  "OK" "Cancel" "Ignore"
function menu_str() {
  local array_menu=("$@")
  MENU_Array "array_menu" ; RV="${RETURN}" ; echo "${RV}" 2>/dev/null
 RETURN "${RV}"
}


 # ex.:  aDiskler=( "sda1" "sda2" "sda3" "sda4" "cdrom" "sdb1" "sdb2" "sdb3")
# ex.:   MENU_Array  "aDiskler" "== Baglanacak diski secin == " +- "live"
function XXXmenu_array() { MENU_Array "$@" ; menu_array="${MENU_Array}" ; echo "${menu_array}" ; }
function XXXMENU_Array () {
 local -n a_Menu="$1"
 local psTitle_myARRAY_MENU="${2:-"[0] <- EXIT MENU"}"
 local psOPTIONAL="${3:-"static"}"      # OR "live" FOR eNumarated Array
 MENU_Array=""

 local n_LenA="${#a_Menu[@]}"
 if [[ "${n_LenA}" = "0" ]] ; then
    echo "An Error encountered. No menu array exist.. Returning <null>"
    RV="null"
 else
    # Dizinin icerigini degistirmeden, sadece basitce 0'dan degil de 1'den baslatarak ekranda goster
    arr_shownum "a_Menu" "$psTitle_myARRAY_MENU"

    echoc "READ" "[0] <- EXIT MENU ->Choose an option:"
    read -n1 REPLY

    if [ "${REPLY}" -eq 0 ]; then RV="null" ; return 0 ; fi
    if [ "${REPLY}" -le "${n_LenA}" ]; then
        let "REPLY=REPLY-1"
        strSELECTED="${a_Menu[${REPLY}]}"
                    #             wait 5 "strSELECTED:$strSELECTED"
        sRemThis="\[${REPLY}\] "
        RV="$( echo "${strSELECTED}" | sed "s/$sRemThis//g" )"
    fi

    if [[ "${psOPTIONAL}" == "live" ]] ; then
        unset "a_Menu[${REPLY}]" # remove the undesired item
        a_Menu=( "${a_Menu[@]}" ) # renumber the indexes
        ## https://stackoverflow.com/questions/25436988/
        ##     how-to-remove-an-element-from-a-bash-array-without-flattening-the-array
    fi
 fi
 let "REPLY=REPLY+1"    # Geri eski-orijinal haline getirelim
 MENU_Array="${RV}"
 RETURN "${RV}">/dev/null  # SON YAPILAN SECIMIN ICERIGINI $RETURN e RAPTIYELESIN !
} #xRV="${RETURN}"


#ex.:  aDiskler=( "sda1" "sda2" "sda3" "sda4" "cdrom" "sdb1" "sdb2" "sdb3")
#ex.:   MENU_Array  "aDiskler" "== Baglanacak diski secin == " +- "live"
function menu_array() { MENU_Array "$@" ; echo "${RETURN}" ; }
function MENU_Array () {
 local -n a_Menu="$1"
 local psTitle_myARRAY_MENU="${2:-"[0] <- EXIT MENU"}"
 local psOPTIONAL="${3:-"static"}"      # OR "live" FOR eNumarated Array

 local n_LenA="${#a_Menu[@]}"

 if is_zero "${n_LenA}"  ; then
    echo "An Error encountered. No menu array exist.. Returning <null>"
    RV="null" ;  RETURN "${RV}">/dev/null
    return 0
 fi

    local strSELECTED=""
    #Dizinin icerigini degistirmeden, sadece basitce 0'dan degil de 1'den baslatarak ekranda goster
    arr_shownum "a_Menu" "$psTitle_myARRAY_MENU"

    ### echoc "READ" "[0] <- EXIT MENU ->Choose an option:"
    echoc "READ" "  -> Choose an option:"
    read -s -n1 REPLY

    if [[ "${REPLY}" = "$'\e'" ]] ; then
        RV="exit" ; echoc "ALERT" "ESSCAPEDDDD" ; sleep 3 ; RETURN "${RV}">/dev/null
        return 0
    fi

    if is_zero "${REPLY}" || is "${REPLY}" ">" "${n_LenA}" ; then
        RV="null" ;  RETURN "${RV}">/dev/null
        return 0
    fi

    if [ "${REPLY}" -le "${n_LenA}" ]; then
        let "REPLY=REPLY-1"
        strSELECTED="${a_Menu[${REPLY}]}"
                #             wait 5 "strSELECTED:$strSELECTED"
        sRemThis="\[${REPLY}\] "
        RV="$( echo "${strSELECTED}" | sed "s/$sRemThis//g" )"

        if [[ "${psOPTIONAL}" == "live" ]] ; then
            unset "a_Menu[${REPLY}]" # remove the undesired item
            a_Menu=( "${a_Menu[@]}" ) # renumber the indexes
            ## https://stackoverflow.com/questions/25436988/
            ##     how-to-remove-an-element-from-a-bash-array-without-flattening-the-array
        fi

        let "REPLY=REPLY+1"    # Geri eski-orijinal haline getirelim

    fi



 RETURN "${RV}">/dev/null  # SON YAPILAN SECIMIN ICERIGINI $RETURN e RAPTIYELESIN !
} #xRV="${RETURN}"

#################################################################
################### ARRAY() and other functions for Arrays ######
#################################################################
# NEW_MODE : Dizi parametreleri isimleri ile geciriliyor
# ve fonksiyonda   local -n psArrayName="${1:-"mapfile"}" seklinde karsilaniyor
##### yani Dizinin ismi verilmisse ona,- degilse default mapfile dizisine ..
#### NEW!! Cunku POSIX compatible mapfile ARRAYini default olarak donuyor
######     Cunku  TXTFILE icin newline LF \n ARAMIYOR!
#################################################################

function arr_len () { local -n psArrayName="${1}" ; echo "${#psArrayName[@]}" ; }

# ex: ( is_empty_array "aTest" )
function is_empty_arr() {
local -n psArrayName="${1}"
 if [[ "${#psArrayName[@]}" -eq 0 ]] ; then return 0 ; else return 1 ; fi
}



# sudo lsblk   etkilesiminden kurtulmak icin default "aDiskParts.arr" dosyasi lusturuluyor.
# Eger parametre olarak dosya ismi gonderilmisse, sistemdeki "aDiskParts.arr" dosyasini PASS gecer!
function array_from_partitions()
{
    local -n paDiskParts="${1:-"aDiskParts"}" ; paDiskParts=()
    local n nArr nLenArr strLineOf strDEVICE="" strFSTYPE="" strMOUNTPOINT=""

    mapfile -t "aDiskPartsLSBLK"<<<$(sudo lsblk -n -i -o PATH,FSTYPE,MOUNTPOINT)
    nLenArr="${#aDiskPartsLSBLK[@]}"
    n=0
    for (( nArr=0; nArr<${nLenArr}; nArr++ ))
    do
        strLineOf="${aDiskPartsLSBLK[$nArr]}"
        strDEVICE="$( echo "${strLineOf}" | awk '{print $1}')"     # /dev/mmcblk0p1
         strFSTYPE="$( echo "${strLineOf}" | awk '{print $2}')"      # file-system icermiyorsa " "
          strMOUNTPOINT="$( echo "${strLineOf}" | awk '{print $3}')"      # Baglama klasoru yoksa
                    # echoc "PASS" "DAMN DIRTY TABS -> [$strDEVICE]  [$strFSTYPE]  [$strMOUNTPOINT] "
        ## strFSTYPE BOS degilse, yani dosya sistemli gercek bir partisyon ise VE  swap /snap veya / olarak zaten bagli degilse
        if [ -z "${strFSTYPE}" ] || [[ "${strFSTYPE,,}" = "[swap]" ]]  || [[ "${strMOUNTPOINT,,}" = "[swap]" ]] || [[ "${strMOUNTPOINT}" =~ ^"/snap" ]] || [[ "X${strMOUNTPOINT}" = "X/" ]]
          then continue
          else paDiskParts[$n]="${strLineOf}" ; let "n=n+1"
        fi
    done
}

# sudo lsblk   etkilesiminden kurtulmak icin default "aDiskParts.arr" dosyasi lusturuluyor.
# Eger parametre olarak dosya ismi gonderilmisse, sistemdeki "aDiskParts.arr" dosyasini PASS gecer!
function get_aDiskMounts
{
    aDiskMounts="${1:-"aDiskMounts"}"
    local -n aDiskMounts="$1"
                    local idDEV=1  idMOUNTPOINT=2 idFSTYPE=3 idOPTION=4    #  "ALL DEVICES OUTPUT"
    mapfile -t "aDiskMounts"<<<$( cat /proc/mounts | awk '{print $1, $2, $3, $4}' )     # /mnt/sda1 , , , , ,
   # arr_show "aDiskMounts" "FUCK ARRAY aDiskMounts"
}


function array_from_mountdevice () {
local -n aDiskDEVS="${1}"                            # -n no-heading line
    mapfile -t "aDiskDEVS"<<<$(cat /proc/mounts | awk '{print $1}' )     # /dev/sda1 , , , , ,
}   # arr_show "aDiskDEVS" "FUCK ARRAY aDiskDEVS"

function array_from_mountpoint () {
local -n aDiskMOUNTS="${1}"
    mapfile -t "aDiskMOUNTS"<<<$( cat /proc/mounts | awk '{print $2}' )     # /mnt/sda1 , , , , ,
}   #arr_show "aDiskMOUNTS" "FUCK ARRAY aDiskMOUNTS"

## ASLINDA KISACA if grep -qs "${1}"  /proc/mounts; then return 0; else return 1; fi
function is_mounted_dev ()  {
local psDev="$1"
    array_from_mountdevice "aMountedDiskDevices"
    arr_seek "aMountedDiskDevices" "${psDev}"  #    arr_show "aMountedDiskDevices" "RV::${RETURN}"
    if isnot_null "${RETURN}"; then return 0 ; else return 1 ; fi
}
function isnot_mounted_dev ()  { if is_mounted_dev "${1}"; then return 1; else return 0; fi ;}


## ASLINDA KISACA if grep -qs "${1}"  /proc/mounts; then return 0; else return 1; fi
function is_mounted ()  {
local psPoint="$1"
    array_from_mountpoint "aMountedPoints"
    arr_seek "aMountedPoints" "${psPoint}" # arr_show "aMountedPoints" "RV::${RETURN}"
    if isnot_null "${RETURN}"; then return 0 ; else return 1 ; fi
}
function isnot_mounted ()  { if is_mounted "${1}"; then return 1; else return 0; fi ;}


# sudo lsblk   etkilesiminden kurtulmak icin default "aDiskParts.arr" dosyasi lusturuluyor.
# Eger parametre olarak dosya ismi gonderilmisse, sistemdeki "aDiskParts.arr" dosyasini PASS gecer!
function get_mount_point() {
    psDiskDevice="${1}"
    RV=""
    local iMnt nMounts strDISKDEVICE strLineOf strDEVICE strMOUNT

    get_aDiskMounts "aMyDiskMounts"
    nMounts="${#aMyDiskMounts[@]}"
            ### arr_show "aMyDiskMounts" "get_aDiskMounts()-ed aMyDiskMounts" ;  sleep 3
            ### echoc "GREEN" "Querying ->   ${psDiskDevice}"
    for (( iMnt=0; iMnt<${nMounts}; iMnt++ ))
    do
               # local idDEV=1  idMOUNTPOINT=2 idFSTYPE=3 idOPTION=4    #  "ALL DEVICES OUTPUT"
        strLineOf="${aMyDiskMounts[$iMnt]}"
        strDEVICE="$(echo "${strLineOf}" | awk '{print $1}')"     # /dev/mmcblk0p1
         strMOUNT="$( echo "${strLineOf}" | awk '{print $2}')"      # "/media/user/flashdisk1" VEYA " "
          strFSTYPE="$( echo "${strLineOf}" | awk '{print $3}')"      # "swap" VEYA "/"

        if [[ "${strFSTYPE,,}" = "[swap]" ]] || [[ "X${strFSTYPE}" = "X/" ]]
        then ok     # echoc "ALERT" "${strFSTYPE} will not mount automatically"
        else
           #      if is "${strDEVICE}" "=" "${psDiskDevice}"
            if is_equal "${strDEVICE}" "${psDiskDevice}"
              then RV="${strMOUNT}"     ### echoc "GREEN_BG" "Mounted already ${strMOUNT}"
                       break
            fi
        fi
    done
 echo "${RV}">/dev/null
 RETURN "${RV}"
}

function array_from_file () {
local -n aArrayName="${1}"
local psSOURCE="${2}"

 if isnot_empty_file "${psSOURCE}" ; then    ## Dosya var-ve-bos degilse
    mapfile -t "aArrayName"<"${psSOURCE}"
  fi
}

function array_from_folders () {
local -n aArrayName="${1}"
local psSOURCE="${2:-"$PWD"}"
    ### TODO FOLDER varsa ve ici bos degilse diziye aktaralim..
  if [[ -d "${psSOURCE}" ]] ; then
        mapfile -t "aArrayName"< <(find "${psSOURCE}" -type d )
  fi
}


function array_from_inifile () {
local -n aArrayName="${1}"
local psSOURCE="${2}"

    # Avoid for https://en.wikipedia.org/wiki/Cat_%28Unix%29#Useless_use_of_cat
    # Dosyayi bulamazsa veya icerigi bossa "null" gonderir   TEMPLATE!!

    if isnot_empty_file "${psSOURCE}" ; then    ## Dosya var-ve-bos degilse
        n=0
        while IFS= read -r iniline; do
            if [[ ! $iniline == \#* ]] ; then   # Yorum satirlarini almayalim !!
                aArrayName[$n]="$iniline"
                let "n=n+1"         # ((n=n+1))
            fi
        done < "${psSOURCE}"
     else
       #  die 1 "$psSOURCE file is EMPTY! "
       echo "[null] mu? ${psSOURCE}"
    fi
}

# ex:    array_from_ini "array2" "${sFileMEM}" "[*]"
#                       => Returns aSECTIONS yani sadece tüm [?] SectionName lerini getirir
# ex:    array_from_ini "array2" "${sFileMEM}"   VEYA
# ex:    array_from_ini "array2" "${sFileMEM}" "[DISKS]"
# ex:    array_from_ini "array2" "${sFileMEM}"  "*" | "[=]" | "[*]" | "[m_SECT]"
function array_from_ini () {
  local -n psArrayTO="$1"
  local pTextFile="$2"
  local psFilterBySECT="$3"
  local array aMEM aAllLines aRegs aSection

    # Gelen 2 parametre SECTION parametresini, fonksiyon sounda  PATTERN olarak kullanarak
    # cikti dizisinin icerigini belirler, bicimlendirir, yonlendirir
    case "${psFilterBySECT}" in
      "*")   filterBY="ALL"; sFilterBySECT=""  ;;  # psArrayTO=("${aMEM[@]}")  # TUM INI DOSYASI SATIRLARI
      "=")   filterBY="KEYVALS"; sFilterBySECT=""  ;;  # psArrayTO=("${aAllLines[@]}")  # TUM Key=Val  SATIRLARI
      "[*]")  filterBY="SECTIONS"; sFilterBySECT="";;  # psArrayTO=("${aSection[@]}")
                                                    # Sadece [SECT] dizisini doldur
      *) filterBY="ONESECTION"; sFilterBySECT="${psFilterBySECT}";;
                # ARRAY_from_ini "array2" "${sFileMEM}" "[DISKS]"  ile SECT_FILTERED psArrayTO=("${aRegs[@]}")
    esac

    readarray -t aMEM < "${pTextFile}"

    #    echo "======= STARTING SCANNING for ${sFilterBySECT} =================="
    i_Sect=0
    i_Reg=0
    i_All=0
    nLenArr=${#aMEM[@]}
    for (( iLine=0; iLine<$nLenArr; iLine++ ))
    do
        mem_line="$(echo "${aMEM[$iLine]}" | tr -d '\r')"     # BUG!PS
        sLine_Test="$mem_line"  # Kesimhaneye gonderiliyor - kurban - test
        if is_in_bracket "${sLine_Test}" ; then
                        #  Bos ise ->"[SECTION] dir.." -> aSection
             sSectFound="${mem_line}"
                        # echo "i_Sect:$i_Sect  VE sSectFound:${sSectFound}"
             if is_empty_var "${sFilterBySECT}" ; then
                                # SECTION belirtilmemis, o zaman aSection heybesine HEPSINI doldur
                    aSection[$i_Sect]+="${sSectFound}"
                    ((i_Sect+=1))
                                # echo "BOS sFilterBySECT::$sFilterBySECT VE ${sSectFound}"
             fi
        else                    #  Bos DEGIL ise ->"Key=Val  dir.." -> aRegs
            sPair_Key="$( pairKEY "$sLine_Test")"
            sPair_Val="$( pairVAL "$sLine_Test")"       # echo "PAIRS:: ${sPair_Key}=${sPair_Val}"
            if is_empty_var "${sFilterBySECT}" ; then
                    aRegs[$i_Reg]+="${sPair_Key}=${sPair_Val}"
                    ((i_Reg+=1))
             else
                if [ "${sSectFound}" == "${sFilterBySECT}" ] ; then
                    aRegs[$i_Reg]+="${sPair_Key}=${sPair_Val}"
                    ((i_Reg+=1))
                fi
             fi

            aAllLines[$i_All]+="${sPair_Key}=${sPair_Val}"   # ex: [DISKS](DISK_SWAP=/dev/mmcblk0p4)
            ((i_All+=1))
        fi
    done

    case "${filterBY}" in
      "ALL") psArrayTO=("${aMEM[@]}") ;;
      "KEYVALS") psArrayTO=("${aAllLines[@]}") ;;
      "SECTIONS") psArrayTO=("${aSection[@]}") ;;
      "ONESECTION") psArrayTO=("${aRegs[@]}")   ;;
    esac
    #  ARRAY "psArrayTO" "test"

# BUG!PS  # Windows ini dosyalarinda satir sonu isareti UNIX uyumlu olmadigindan trim etmezsen eger :
#        'USER1\r=USER2': command not found  + bulunamadı:USER2   .. hatasini aliyorsun..

}


function array_from_csvinit () {
local -n aArrayName="${1}"
local psSOURCE="${2}"
local psOPTIONAL="${3}"

  if isnot_empty_file "${psSOURCE}" ; then    ## Dosya var-ve-bos degilse
    mapfile -t "aArrayName"<"${psSOURCE}"
    #
    sCSV_init_file_name="${psSOURCE}.ini"
    if is_exist_file "${sCSV_init_file_name}"; then
       ok   #   echo "FAKE! OKU sCSV_init_file_name:[$sCSV_init_file_name] "
     else
        if exist_var "${psOPTIONAL}"; then        ## if [[ ${psOPTIONAL} ]] ; then
            local -n aHEADER_FIELDS="${psOPTIONAL}"
            #ARRAY "aHEADER_FIELDS" "test"
            #wait 1 "3. eleman dizisi olacak:[${3}]"
         else
            sHEADER_OR_DATA="${aArrayName[0]}"
            idSEP=","    # Obviously Comma for Comma-Seperated-values file
            mapfile -t "aTempHEADER_FIELDS"<<< "${sHEADER_OR_DATA//${idSEP}/$'\n'}"
                #
                ARRAY "aTempHEADER_FIELDS" "test"
                #
                wait 5 "FAKE! Bu dizi icin init-file-editoru-calistir  "
        fi
    fi
  fi
}


# ex.: sMountPoints="EFI WINDOWS BOOT WIN LIN LINUZE"
#        array_from_words "aMountPoints" "sMountPoints"
function array_from_words() { array_from_text "$@" ;}
# ex.:   array_from_list "aSTRINGLIST" "psSTRINGLIST" "|"
function array_from_list() { array_from_text "$@" ;}

# NEW_DESIGNED array_from_text()
# Elemanlari her turden olan bir string kumesini bile canavar gibi diziye aktariyor
# CSV dosyalarin satirlarini veya paragraf-text lerini diziye aktarmak icin kullan!
# Bunun icin dunya kadar Array_FROM_LIST falan denendi calismadi..  TEMPLATE!!! XXXARRAY_QUOTE()
# See:https://unix.stackexchange.com/questions/237735/read-quoted-array-elements-with-spaces-from-file
# ex.: array_from_text "aElements" "$psMsgQuote"
# Son olarak supermen fonksiyon olmasi icin optional 3. parametre ile cagrildiginda,
#  seperated-string-list leri de diziye aktarmasi saglandi..
# GUNUN SONUNDA su asagidaki butun formatlarda gorevini basariyla yerine getiriyor..
#     str="BirMum IkiMum UcMum"
#     str="BirMum,IkiMum,UcMum"
#     str='"Bir mumdur" "iki mumdur" "üç mumdur"'
#     str='"Bir mumdur","iki mumdur","uc mumdur"'
#     str="Bir mumdur,iki mumdur,uc mumdur"
#        array_from_text "aSTR" "$str" "," ; arr_show "aSTR" "testing xxxarray_from_text() aSTR"
#_________________________________________ ## How it works this magic?
function array_from_text()
{
    local -n aArrayName="${1}"
    local strListName="${2}"
    local psOPTseperator="${3}"
    if [ "${psOPTseperator}" ]  # 3. parametre bos degil, seperator belirtilmis..
     then   # echo "seperatorlu aktarim"
        aArrayName=()
        IFS_OLD=$IFS
        IFS=${psOPTseperator}    # set as Internal Field Separator for the string list
        for i in $strListName
         do
            echoc "INFO" "iElem::[$i]"
            aArrayName+=($i)
         done
        IFS=$IFS_OLD
     else
        declare -a "aBraKaDaBRa=( ${strListName} )"
        aArrayName=("${aBraKaDaBRa[@]}")
    fi
}

# ex.: array_to_file "aUsers"  "users.txt"
#      array_to_file "aUsers"    # ->  "aUsers.arr"
function array_to_file  {
    local psArrayName="${1}"
    local -n aArrayName="${1}"
    local psFileOut="${2:-"${psArrayName}.ARR"}"
                ###     echo "writin to --> ${psFileOut}"
    printf "%s\n" "${aArrayName[@]}">"${psFileOut}"
}

# ex.: array_to_str "aUsers"  "sUsers"
#      array_to_str "aUsers"    # ->  "str_aUsers"
function array_to_str  {
    local psArrayName="${1}"
    local -n aArrayName="${1}"
        # Degisken atamasini direkt cagiran ust fonsiyonda yaptimis oluyoruz..
    local -n pstrOut="${2:-"str_${psArrayName}"}"
    pstrOut="${aArrayName[@]}"

}

# ex.: array_to_arr "aUsers"  "aNewUsers"
#      array_to_arr "aUsers"    # ->  "copy_aUsers"
function array_to_arr  {
    local psArrayName="${1}"
    local -n aArrayName="${1}"
        # Degisken atamasini direkt cagiran ust fonksiyonda yaptimis oluyoruz..
    local -n psArrCopy2="${2:-"copy_${psArrayName}"}"
    psArrCopy2=("${aArrayName[@]}")
}


# Diziyi 1'den baslayarak numarali hale getirir - 0. elemana basligi yerlestirir !
     ######## array_to_num "aMyArr"  +- "Elemanlarimiz bunlar:"
function array_to_num () {
local -n psArr2Num="$1"
local psOptTitle="${2:-"null"}"
    psArrayTest=( "${psOptTitle}" "${psArr2Num[@]}")
    local nArr="${#psArr2Num[@]}"
    for (( i=0; i<${nArr}; i++ ))
    do
        psArrayTest[$i]="[$i] ${psArr2Num[$i]}"
    done
}


# Diziyi 0'dan baslayarak numarali hale getirir - nadiren kullanilabilir
function arr_num () {
local -n psArr2Num="$1"
    local nArr="${#psArr2Num[@]}"
    for (( i=0; i<${nArr}; i++ ))
    do
        psArr2Num[$i]="[$i] ${psArr2Num[$i]}"
    done
}

function arr_sort  {
local psNameOf="${1}"
local -n psArrayName="${1}"
  readarray -t "${psNameOf}"< <(printf '%s\n' "${psArrayName[@]}" | sort )
}



function arr_sortunique  {
local psNameOf="${1}"
local -n psArrayName="${1}"
  readarray -t "${psNameOf}"< <(printf '%s\n' "${psArrayName[@]}" | sort -u )
}

function arr_reverse  {
local -n psArrayName="${1}"
local min=0
local max=$(( ${#psArrayName[@]} -1 ))

while [[ min -lt max ]]
do
    # Swap current first and last elements
    x="${psArrayName[$min]}"
    psArrayName[$min]="${psArrayName[$max]}"
    psArrayName[$max]="$x"

    # Move closer
    (( min++, max-- ))
done
}

 # NEW! Instead of ALL ~Arr~Test() works..
# ex..   arr_show "aArrayName"  +- "sTITLE"
function  arr_show () {
local -n aArr_show="$1"
local psOptTitle="${2}"

local nArr="${#aArr_show[@]}"
local sArrInfo="== ${!aArr_show}[${nArr}] =="      # "aMyFiles[15]"

    psOptTitle="${psOptTitle:-"${sArrInfo}"}"
    echoc "TITLE"  "${psOptTitle}"

    for (( i=0; i<${nArr}; i++ ))
    do
        echoc "BLUE" "${aArr_show[$i]}"
    done
    echoc "TITLE"  "====================="
}


                # Dizide hicbir oynama yapmadan, zaten numaralanmis diziyi ,
                # aynen normal bir diziymis gibi 0. elemanindan baslatarak listeler
# ex.:   arr_shownum "aDisks"  +- "Sistemdeki diskleriniz:"
function arr_shownum () {
local nPARAM="$#"
local -n psArrayTest="$1"
local psOptTitle="$2"

local nArr="${#psArrayTest[@]}"

    echoc "TITLE" "${psOptTitle}"
     local n=0
    for (( i=0; i<${nArr}; i++ ))
    do
        let "n=i+1"
        echo -n "[$n] "
        echoc "BLUE" "${psArrayTest[$i]}"
    done
    echoc "TITLE" "====================">&2

}

# ex.:   arr_showmenu "aDisks" +- "sTITLE"  +- "sPROMPT"
# ex.:   arr_showmenu "aDisks" "Sistemdeki diskleriniz:" "Menu Secim No:"
# ex.:   arr_showmenu "aDisks" "Disk seçimi yapın" "[0] ile Menüden Çıkış"
function arr_showmenu () {
local nPARAM="$#"
local -n psArrayTest="$1"
local psOptTitle="${2:-"[0] <- EXIT Menu"}"
local psOptPrompt="${3:-"Menu Choice No"}"

local col_="\\033[0;33m" _col="\\033[0m"
local nArr="${#psArrayTest[@]}"

    printf "${col_}%s${_col}\n" "${psOptTitle}"
     local n=0
    for (( i=0; i<${nArr}; i++ ))
    do
        let "n=i+1"
        printf "${col_}[$n]${_col} %s\n" "${psArrayTest[$i]}"
    done
    printf "${col_}[ ] ${psOptPrompt} -> ${_col}\n">&2

}



### !!! OLD "ARRAY_OP()" FUNCTIONS begin with "arr_"  ###

# arr_ADD "aTHIS" "Sovalye" "13" ;  SUCCESS="$RETURN"
# YA DA SUCCESS=$( ArrDelContains "aTHIS" "13" )  YA DA
# if ok "${SUCCESS}" ; then ..

function arr_ADD() {
REGFUNC="arr_ADD"; RV="FALSE"
local -n psArray_OP="${1}"
local -n psCONTENT="${2}"
local pWHERE="${3}"

local nLenArr="${#psArray_OP[@]}"

    case "${pWHERE,,}" in

        "top"|"zero"|"0")      #Add the 0st element
            aSTRINGLIST=("${psCONTENT}" "${aSTRINGLIST[@]}")
            ;;

        "bottom"|"end"|"-1")   #Add after the last element
                aSTRINGLIST=("${aSTRINGLIST[@]}" "${psCONTENT}" )
                #add  to the end == arr+=( "new_element" )
            ;;

         *)     # wait 1 "top-bottom disinda girilen butun parametreler nRecNo'dur::${pWHERE}"
            if [[ "${pWHERE}" -eq 0 ]]     # dizinin en basini bizzat belirtmis! Dokunma!
            then ok                     # test()
            else let "pWHERE=pWHERE-1"    # BECAUSE arrays start from zero
            fi
                # echo "if ${WHERE} is overflowing ${nLenArr} . will be Corrected to LAST"
            if [[ "${pWHERE}" -gt "${nLenArr}" ]] ; then pnREC="${nLenArr}" ; fi
            aSTRINGLIST=( "${aSTRINGLIST[@]:0:$pWHERE}" "${psCONTENT}" "${aSTRINGLIST[@]:$pWHERE}" )
            ;;
    esac
 RETURN "TRUE">/dev/null
}


# arr_INS "aTHIS" "Sovalye" "13" ; 13. elemanin icine kendini yazar ama
#                                  orijinal degerini de GDD olarak gonderir
# YA DA sPreviousEl=$( arr_INS "aTHIS" "Ugursuz Sovalye" "13" )  YA DA sPreviousEl="$RETURN"
#
function arr_INS() {
REGFUNC="arr_INS"; RV="null"
local -n psArray_OP="${1}"
local psCONTENT="${2}"
local pWHERE="${3}"

local nLenArr="${#psArray_OP[@]}"

    case "${pWHERE,,}" in

        "top"|"zero")      #INSERT the 0st element
                sElCurrent="${psArray_OP[0]}"
                psArray_OP[0]="${psCONTENT}"
            ;;

        "bottom"|"end")   #INSERT the last element
            sElCurrent="${psArray_OP[-1]}"
            psArray_OP[${nLenArr}]="${psCONTENT}"
            ;;

         *)     # top-bottom disinda girilen butun parametreler nRecNo'dur?!
            local pnREC="${pWHERE}"
            if [ "${pnREC}" -eq 0 ]     # dizinin en basini bizzat belirtmis! Dokunma!
            then ok                     # test()
            else let "pnREC=pnREC-1"    # BECAUSE arrays start from zero
            fi
                # echo "if ${pnREC} is overflowing ${nLenArr} . will be Corrected to LAST"
            if [ "${pnREC}" -gt "${nLenArr}" ] ; then pnREC="${nLenArr}" ; fi

            sElCurrent="${psArray_OP[${pnREC}]}"
            psArray_OP[${pnREC}]="${psCONTENT}"
            ;;
    esac
 RV="${sElCurrent}"
 RETURN "${RV}">/dev/null
}


# ex.:   arr_DEL "aTHIS" "13"
function arr_DEL() {
REGFUNC="arr_DEL"; RV="null"
local -n psArray_OP="${1}"
local pWHICH="${2,,}"
local sDeletedEl=""

local nLenArr="${#psArray_OP[@]}"

    case "${pWHICH,,}" in

        "top"|"zero")      #removed the 1st element
            sDeletedEl="${psArray_OP[0]}"
            psArray_OP=("${psArray_OP[@]:1}")
            ;;

        "bottom"|"end")   #removed the last element
            # unset psArray_OP[-1]  #removed the last element
            sDeletedEl="${psArray_OP[-1]}"
            unset psArray_OP[${nLenArr}-1]
            ;;

         *)     # top-bottom disinda girilen butun parametreler nRecNo'dur?!
            local pnREC="${pWHICH}"
            if [ "${pnREC}" -eq 0 ]     # dizinin en basini bizzat belirtmis! Dokunma!
            then ok                     # test()
            else let "pnREC=pnREC-1"    # BECAUSE arrays start from zero
            fi

            sDeletedEl="${psArray_OP[${pnREC}]}"
                #  echo "if ${pnREC} is overflowing ${nLenArr} . will be Corrected to LAST"
            if [ "${pnREC}" -gt "${nLenArr}" ] ; then pnREC="${nLenArr}" ; fi

            unset psArray_OP[${pnREC}]  # remove the undesired item
            psArray_OP=( "${psArray_OP[@]}" ) # renumber the indexes! TEMPLATE!Important
            ;;
    esac
    psArray_OP=( "${psArray_OP[@]}" ) # renumber the indexes! TEMPLATE!Important

 RV="${sDeletedEl}"
 RETURN "${RV}">/dev/null
}

# Find FIRST contain FIRST  and del
# ex.:   arr_del_this "aTHIS" "$sDelThis"
function arr_del_this() {
REGFUNC="arr_del_this"; RV="null"
local -n psArray_OP="${1}"
local -n psCONTENT="${2}"

    for i in "${!psArray_OP[@]}"
    do
        sEl="${psArray_OP[${i}]}"       # echo "$i -- ${sEl} ~ ${psCONTENT}"
        if [[ "${sEl}" == "${psCONTENT}" ]] ; then
            unset psArray_OP[${i}]
            psArray_OP=( "${psArray_OP[@]}" )
            RV="${i}"
            break
        fi
    done
 RETURN "${RV}">/dev/null
}


# Find FIRST contain FIRST  and del
# ex.:   arr_del_this_all "aTHIS" "$sDelThis"
function arr_del_this_all() {
REGFUNC="arr_del_this_all"; RV="null"
local -n psArray_OP="${1}"
local -n psCONTENT="${2}"
local n=0

    for i in "${!psArray_OP[@]}"
    do
        sEl="${psArray_OP[${i}]}"       # echo "$i -- ${sEl} ~ ${psCONTENT}"
        if [[ "${sEl}" == "${psCONTENT}" ]]
        then
            unset psArray_OP[${i}]
            psArray_OP=( "${psArray_OP[@]}" )
            let "n=n+1"
            RV="${n}"
        fi
    done
 RETURN "${RV}">/dev/null
}

# Find FIRST contain FIRST  and del
# ex.:   arr_del_contain "aTHIS" "$sSeekThis"
function arr_del_contain() {
REGFUNC="arr_del_contain"; RV=
local -n psArray_OP="${1}"
local -n psCONTENT="${2}"

    for i in "${!psArray_OP[@]}"
    do
        sEl="${psArray_OP[${i}]}"       # echo "$i -- ${sEl} ~ ${psCONTENT}"
        local sHASNOT_contain="${sEl##*${psCONTENT}*}"
        if [[ "${sHASNOT_contain}" ]]
        then
            RV="null"
        else
            unset psArray_OP[${i}]
            psArray_OP=( "${psArray_OP[@]}" )
            RV="${i}"
            break
        fi
    done
 RETURN "${RV}">/dev/null
}

#  # Find contain s ALL MATCH and del
# ex.:   arr_del_contain_all "aTHIS" "$sSeekThese"
function arr_del_contain_all() {
REGFUNC="arr_del_contain_all"; RV=
local -n psArray_OP="${1}"
local psCONTENT="${2}"

    n=0
    for i in "${!psArray_OP[@]}"
    do
        sEl="${psArray_OP[${i}]}"
        echo "$i -- ${sEl} ~ ${psCONTENT}"
        local sHASNOT_contain="${sEl##*${psCONTENT}*}"
        if [[ "${sHASNOT_contain}" ]]
        then RV="null"
        else
            let "n=n+1"
            unset psArray_OP[${i}] ; RV="${n}"
        fi
    done
 RETURN
}


function arr_AT() {
REGFUNC="arr_AT"; RV=
local -n psArray_OP="${1}"
local pWHERE="${2:-"-1"}"

local nLenArr="${#psArray_OP[@]}"

    case "${pWHERE,,}" in

        "top"|"zero"|"0")      #give the 0st element
                RV="${psArray_OP[0]}"
            ;;

        "bottom"|"end"|"-1")   #give the last element
                RV="${psArray_OP[${nLenArr}-1]}"
            ;;

         *)     # top-bottom disinda girilen butun parametreler nRecNo'dur?!
            local pnREC="${pWHERE}"
            if [ "${pnREC}" -eq 0 ]     # dizinin en basini bizzat belirtmis! Dokunma!
            then ok                     # test()
            else let "pnREC=pnREC-1"    # BECAUSE arrays start from zero
            fi
                # echo "if ${pnREC} is overflowing ${nLenArr} . will be Corrected to LAST"
            if [ "${pnREC}" -gt "${nLenArr}" ] ; then pnREC="${nLenArr}" ; fi
            RV="${psArray_OP[${pnREC}]}"
        ;;
    esac
 RETURN "${RV}">/dev/null
}

# Seek array elements that exactly same
# arr_seek "aTHIS" "$sSeekThis"     returns nThEl_isFOUND
function arr_seek() {
REGFUNC="arr_seek"; RV="null"
local -n psArray_OP="${1}"
local psCONTENT="${2}"

    for i in "${!psArray_OP[@]}"
    do
        ### echo "${i} -- ${psArray_OP[${i}]}  -EQ  ${psCONTENT}"
        if [[ "${psArray_OP[${i}]}" == "${psCONTENT}" ]]
        then RV="${i}"; break       # First FOUND !  returns nThEl_isFOUND
        fi
    done

 RETURN "${RV}">/dev/null
}

# Seek how many array elements that exactly same, COUNT()
# arr_seek_count "aTHIS" "$sSeekThis"     returns nTotal_isFOUND
function arr_seek_count() {
REGFUNC="arr_seek_count"; RV="0"
local -n psArray_OP="${1}"
local psCONTENT="${2}"

  n=0
    for i in "${!psArray_OP[@]}"
    do
        if [[ "${psArray_OP[${i}]}" == "${psCONTENT}" ]]
        then let "n=n+1"
        fi
    done
    RV="${n}"

 RETURN "${RV}">/dev/null
}


# Search array elements for contain FIRST element recordNo
# ex.:   arr_contain_el "aTHIS" "$sContainThis"     returns nThEl_isMATCH
function arr_contain_el() {
REGFUNC="arr_contain_el"; RV="null"
local -n psArray_OP="${1}"
local psCONTENT="${2}"

    for i in "${!psArray_OP[@]}"       # i degil de sEl olmali
    do
        sEl="${psArray_OP[${i}]}"
        local sHASNOT_contain="${sEl##*${psCONTENT}*}"
        if [[ "${sHASNOT_contain}" ]]
        then ok
        else RV="${i}"; break
        fi
    done


 RETURN "${RV}">/dev/null
}

# Search ALL array elements that contain and retuns total COUNT
# ex.:   arr_contain_count "aTHIS" "$sContainThis"     returns nThEl_isMATCH
function arr_contain_count() {
REGFUNC="arr_contain_count"; RV="null"
local -n psArray_OP="${1}"
local psCONTENT="${2}"

    n=0
    for i in "${!psArray_OP[@]}"
    do
        sEl="${psArray_OP[${i}]}"
        local sHASNOT_contain="${sEl##*${psCONTENT}*}"
        if [[ "${sHASNOT_contain}" ]]
        then ok
        else let "n=n+1"
        fi
    done
    RV="${n}"
 RETURN "${RV}">/dev/null
}


# Search and Replace FIRST array element that exactly same
# ex.:   arr_replace "aTHIS" "$sSeekThis"  "$sReplaceWith"       returns nThEl_isFOUND
function arr_replace() {
REGFUNC="arr_replace"; RV="null"
local -n aSTRINGLIST="${1}"
local psCONTENT="${2}"
local psOTHERCONTENT="${3}"

    for i in "${!aSTRINGLIST[@]}"
    do
    ###  echo "${i}"  "${aSTRINGLIST[${i}]}" "-EQ" "${psCONTENT} -->${psOTHERCONTENT}"
        if [[ "${aSTRINGLIST[${i}]}" == "${psCONTENT}" ]]
        then
            aSTRINGLIST[${i}]="${psOTHERCONTENT}"
            RV="${i}"   # +1 gerek miyor mu ?   let "i=i+1"
            break
        fi
    done

 RETURN "${RV}">/dev/null
}



# Search and Replace ALL array elements that exactly same
# ex.:   arr_replace_all "aTHIS" "$sSeekThis"  "$sReplaceWith"     returns nThEl_isFOUND
function arr_replace_all() {
REGFUNC="arr_replace_all"; RV="null"
local -n psArray_OP="${1}"
local psCONTENT="${2}"
local psOTHERCONTENT="${3}"

    n=0
    for i in "${!psArray_OP[@]}"
    do
        if [[ "${psArray_OP[${i}]}" == "${psCONTENT}" ]]
        then
            psArray_OP[${i}]="${psOTHERCONTENT}"
            let "n=n+1"
        fi
    done
    RV="${n}"

 RETURN "${RV}">/dev/null
}

# Search and Replace FIRST array element that exactly same
# ex.:   arr_add_array "aTHIS" "$sSeekThis"     returns nThEl_isFOUND
function arr_add_array() {
REGFUNC="ArrAddArray"; RV="FALSE"
local -n psArray_OP="${1}"
local psCONTENT="${2}"

    local -n psAddArrayName="${psCONTENT}"
    psArray_OP=(${psArray_OP[@]} ${psAddArrayName[@]})

 RETURN "TRUE">/dev/null
}


    # ex. alias code='/bin/bash $MYRUN/cor-code "$@"'
    ## TODO! .bashrc icinden tanimli olmasi lazim   # export TEXTEDITOR=deepin-editor
    ## ex: code "$HOME/Projects/deneme.py" YA DA code "fstab"
# ex.: codeit "sh" "~/Desktop/runme"
################# v.3 ##### 08.10.2020
function code() {
#################
psWith_File_or_Alias="${1:-"${PWD}/readme-first.txt"}"
    # Hicbir parametre, yani Dosya ismi girilmemisse default..

    # Eger dosya ismi yerine MAHLAS, ALIAS gonderilmisse
    # ilgili dosyanin ismini full-path i ile ver :

 case "${psWith_File_or_Alias,1,1}" in
   bash)  sFileName="$HOME/.bashrc" ;;
   alias) sFileName="$HOME/.bash_aliases" ;;
   history) sFileName="$HOME/.bash_history" ;;
   zen) sFileName="${ZEN}/zen.sh" ;;
   mem) sFileName="${ZEN}/zen.mem" ;;
   mime) sFileName="$HOME/.local/share/applications/mimeapps.list" ;;
   hosts) sFileName="/etc/hosts" ;;
   grub)  sFileName="/boot/grub/grub.cfg" ;;
   fstab) sFileName="/etc/fstab"  ;;
   apache) sFileName="/etc/apache2/apache2.conf" ;;
   profile) sFileName="/etc/profile" ;;
   sourcelist) sFileName="/etc/apt/sources.list" ;;
   *)                   # Alias falan degil bizzat dosya ismi gonderilmis demektir..
        sFileName="${psWith_File_or_Alias}"   ;;
 esac


    ## sGetEXT="$(FILE "${sFileName}" "ext" )"
sFileBase="$(basename ${sFileName})"
sGetEXT="${sFileBase##*.}"
sWithEXT="${sGetEXT:-"sh"}"     # Dosya uzantisi yoksa.. default to -> sh

################### TEMPLATE kutupanesi ...
############# Aslinda ~/Templates den de alinabilir..
case "${sWithEXT,1,1}" in

    "txt")
sTemplate=""
        ;;

    "text")
sTemplate="I hope you know what you do.."
        ;;

    "c"|"h")
sTemplate="# -*- coding: utf-8 -*-"
        ;;

    "sh")
sTemplate='#!/bin/bash
source ~/zen.sh ; source ~/zen.mem
#####################

# FUNCTION:
### EX: funcy "p1"..
# PARAMETERs:    -> sRV= ?
echo "Help:" ; USAGE () {
  nARGs="$#"

}

################# Start Testing..
sRV=$(funcy "${1}"..)
echox "info" "${sRV}"
#'
        ;;

    "py")
sTemplate=" #!/usr/bin/env python    ## nowadays /usr/bin/python3
# -*- coding: utf-8 -*-
#
import os
import sys
#"
        ;;


    "bat")
sTemplate="
@echoes OFF
echo *****************************************************
echo %~dp0\php.exe -S localhost:666 -t /$PWD
echo *****************************************************
"
        ;;

    "batsh")
            sTemplate='#!/home/zen/os/sh
echo "*****************************************************"
echo "BASH for Windows STYLE PowerShell SCRIPT            "
echo "*****************************************************"
'
        ;;

    "json")
            sTemplate='
{
  "requires": true,
  "dependencies": {
    "coffeescript": {
      "version": "6.6.6",
      "file": "https://cortex.com.tr/dl/sample.ai",
    }
  }
}
'
        ;;

    "php")
sTemplate="
<?php

// Tüm bilgiyi gösterelim (INFO_ALL sabitine eşdeğer)
phpinfo();

// Sadece modül bilgisini gösterelim. phpinfo(8) de aynı sonucu verir.
phpinfo(INFO_MODULES);

?>
"
        ;;

    "css")
            sTemplate='
/*
Title: CSS3 Sablon
Author: Zen by Cortex
*/

/* Start Reset CSS */
html, body, div, span, applet, object, iframe, h1, h2, h3, h4, h5, h6, p, blockquote, pre, a, abbr, acronym, address, big, cite, code, del, dfn, em, img, ins, kbd, q, s, samp, small, strike, strong, sub, sup, tt, var, b, u, i, center, dl, dt, dd, ol, ul, li, fieldset, form, label, legend, table, caption, tbody, tfoot, thead, tr, th, td, article, aside, canvas, details, embed, figure, figcaption, footer, header, hgroup, menu, nav, output, ruby, section, summary, time, mark, audio, video {margin: 0; padding: 0; border: 0; font-size: 100%; font: inherit; vertical-align: baseline;}

article, aside, details, figcaption, figure, footer, header, hgroup, menu, nav, section {display: block;}

ol, ul {list-style: none;}

blockquote, q {quotes: none;}

blockquote:before, blockquote:after, q:before, q:after {content: ""; content: none;}

table {border-collapse: collapse; border-spacing: 0;}
/* End Reset CSS */

'
        ;;

    "html"|"htm")
            sTemplate='<html>
<head>  <meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link rel="stylesheet" href="os/bootstrap.css">
<link rel="stylesheet" href="os/fonts/font-awesome.css">
<link rel="stylesheet" href="os/w3.css">
<link rel="stylesheet" href="os/cortex.css">
<link rel="stylesheet" href="os/corlib.css">
<script src="os/jquery.js"></script>
<script src="os/bootstrap.js"></script>
<script src="os/cortex.js"></script>

  <!-- Material Design Bootstrap -->  <link href="os/mdb.css" rel="stylesheet">
  <!-- Bootstrap tooltips -->    <script type="text/javascript" src="os/popper.js"></script>
  <!-- MDB core JavaScript -->  <script type="text/javascript" src="os/mdb.js"></script>

<title>Test Title</title>
</head>
 <body>

    <script>
    // js Initialization
    $(document).ready(function() {
      bla bla bla commands;
    });
    </script>

 </body>

</html>
'
        ;;

    "ini") sTemplate="I hope you know what you do.." ;;

    "md") sTemplate="I hope you know what you do.."  ;;
    "js") sTemplate="I hope you know what you do.." ;;

    "desktop") sTemplate="I hope you know what you do.." ;;


    "cfg"| "xml"|"csv"|"sql" ) sTemplate="I hope you know what you do.." ;;

    "--help") echo "HELP()" ;;
    *) # echo "running ..."  ;;
esac


if isnot_exist_file "${sFileName}"; then
    touch "${sFileName}"       # Goruldu stamp i yapistir
    chmod 777 "${sFileName}"   # herkes herseyi yapabilsin
    chmod +x "${sFileName}"    # Script hemen eXecutable stamp i yapistir
        echo "${sTemplate}">"${sFileName}"  # Dump template to full-file
fi

    #============================
    "$TEXTEDITOR"  "${sFileName}"
    ### ${RUN}/file/textedit "${sFileName}"
}
## -----EOF ------ >%


function echo404 () { echoc "xred" "$REG -Source File NOT found -404 -> $1" ;  }
function echotitle () { echoc "titlebox" "$1" ;  }
function show () { printf '%b ' "$@\n\c" ; }


    #echo "-------------------------------------------- echo_red_bg() "
    #echo_red_bg "Line1 -Onemli Bilgi"

    #echo "-------------------------------------------- echoc()"
    #echoc "red_bg" "Onemli Bilgi"

    #echo "-------------------------------------------- echox()"
    #echox "Uygulama PATH'de: " "xgreen" "$PATH" "xred_bg" "Line1 -Önemli Bilgi.."  "xyellow"  "YAYALIM!"

    #echo "-------------------------------------------- echoes()"
    #echoes "Uygulama PATH'de: " "xgreen" "$PATH" "xred_bg" "Line1 -Önemli Bilgi.."  "xyellow"  "YAYALIM!"

# ex.:  echoc "red" " === Renk kodlari icin TEST_Color_Codes_for_Library() === "
# ex.:  echoc "12" "#"      # STR_REPLICATE.. sonuna \n ekleyerek geri cevirir ( echo $printf )
# example:
#        sMsgWarning="Application will be terminated! Are you sure?"
#        echoc "BLINK" "$sMsgWarning"
#        echo "== Simdi de cumle icinde kullanabilmek icin degiskene aktaralim :"
#        echoc "EXIT" "$sMsgWarning" "sDescription"
#        echo -e "You warned:  $sDescription . Your changes won't saved.. "
#
function echoc ()
{
 local psColor="${1,,}"
 local psString="$2"
 local psRV_Object="$3" # Bu parametre girilmezse fonsiyon sonunda GDD'ne "\n" eklenecek, degilse ...

 local sColor="" endcolor="\\033[0m"

 case "${psColor}" in
    "x"|"null"|"none"|"default") sColor="\\033[0;27m" ;;
    "b"|"bold") sColor="\\033[1;47m" ;;     # bold
    "title"|"read") sColor="\\033[0;1m"     # bold??
                    psString="${psString}" ;;     # TITLE
    "titlebox") sColor="\\033[0;47m"
                local nLen="${#psString}"       # Basligin uzunlugu
                local sLine="$( printf "=%.0s" $(seq ${nLen}) )"
                psString="${sLine} \n ${psString} \n ${sLine} " ;;     # TITLEBOX

    "u"|"ul"|"link")   sColor="\\033[0;4m" ;;      # Underline
    "ud"|"udbl")  sColor="\\033[0;21m" ;;  # Under-DoubleLine
    "uml"|"rev"|"rem") sColor="\\033[0;21m" ;;  # MiddleLine - REVisioned Ortasi cizili-canceled -rem
    "i"|"italic")  sColor="\\033[0;3m" ;;      # italic
    "bw"|"inv") sColor="\\033[0;7m" ;;     # black&white - INVerted -Background
    "blink"|"exit"|"terminate"|"die"|"shutdown") sColor="\\033[0;6m" ;;           # Blinking
    "black") sColor="\\033[0;30m" ;;
    "black_bg") sColor="\\033[0;40m" ;;
    "white") sColor="\\033[0;37m" ;;         # Beyaz
    "white_bg") sColor="\\033[0;47m" ;;       # Beyaz-BG
    "white_bg_bold") sColor="\\033[1;47m" ;;  # Beyaz-BG- bold
    "gray_bg_bold") sColor="\\033[7;90m" ;;        # Gri-BG Bold
    "red"|"stop"|"alert"|"warn")     sColor="\\033[0;31m" ;;          # red
    "red_bg"|"err"|"fail")    sColor="\\033[0;41m" ;;   # red-BG
    "green"|"pass"|"good"|"ok")   sColor="\\033[0;32m" ;;                  # Yesil
    "green_bg"|"perfect"|"best"|"success")  sColor="\\033[0;42m" ;;             # Yesil-AP
    "blue")    sColor="\\033[0;34m" ;;
    "blue_bg"|"note")   sColor="\\033[0;44m" ;;
    "yellow"|"wait")  sColor="\\033[0;33m" ;;              # sari - info
    "yellow_bg"|"wait_bg"|"info") sColor="\\033[0;43m" ;;         # sari - info -BG
                #"cyan")    sColor="\\033[0;36m" ;;
                #"cyan_bg")   sColor="\\033[0;46m" ;;
                #"purple")  sColor="\\033[0;35m" ;;
                #"purple_bg") sColor="\\033[0;45m" ;;
                # "nobold")  sColor="\\033[0;22m" ;;
                # "noul")    sColor="\\033[0;24m" ;;
                #   "noitalic")sColor="\\033[0;23m" ;;
                # "noinv")   sColor="\\033[0;27m" ;;
    *)  sColor="\\033[0;0m" ;;
  esac

  #======== Burada muhtesem zekice trickler var.. ilki : char_replicate() buraya implante edildi ..
  ## is_number() ile check edilen parametre numerik ise, stringi o kadar replike ediyor
  if is_number "${psColor}"
  then   # 1. parametre numeric olduguna gore digeri REPLICATE edilecek CHAR olmali..
          echo "$(printf "${psString}%.0s" $(seq ${psColor}) )">&2
  else  ## Ikinci trick : opsiyonel olarak girilen 3. parametre'yi ; hem GDD'nin LineFeed
        ## ile beslenip beslenmeyeceginin karar vericisi olarak kullaniyor,
        ##  hem de ust fonksiyonda kullanilacak bir variable adi olarak kullanip GDD'ne esitliyor
         if test -z "${psRV_Object}"
         then           # echoc "red" "Hata Olustu"  ise LF eklenerek gostersin
            local sLF="\n"
            printf "${sColor}%s${endcolor}${sLF}" "${psString}">&2
         else               # echoc "red" "Hata Olustu" "sMsgWarn" ise sonuna bir bosluk ekleyerek..
            local -n psRV_Object   # ..degilse.. psRV_Object="Ananin Herekesi" atanarak gonderilecek
            local sLF=" "          # ve sonuna LineFeed eklenmedigi icin, cumle icinde kullanilabilecek
            psRV_Object="$( printf "${sColor}%s${endcolor}${sLF}" "${psString}" )"
         fi

  fi
}


# ex.: echoes  "Önemli Bilgi.."  $PATH "Uygulama PATH'de yer almiyor.. " Bilginize
function echoes () { local paARGS=("$@") ; printf "%s\n" "${paARGS[@]}" ; }


# ex.: echox xred "Önemli Bilgi.." xend \
#       x  "$PATH" "Uygulama PATH'de yer almiyor.. " xend \
#       xu "Bilginize" "Blah blah" "Falan Filan" xi "Fuck you"  "Dolor ipsum"
# ex.: echox xred "Önemli Bilgi.." xend x  "$PATH" "Uygulama PATH'de yer almiyor.. " xend
#            xu "Bilginize" "Blah blah" "Falan Filan" xend xi "Fuck you"  "Dolor ipsum"
# ex.: echox xtitle "Blah One" xend "Blah two" xbw_bg "Blah Three" xi "Blah Four" x "Blah Five"
# Yukaridaki isi soyle de kodlayabilirdik :
#
#     echoc "NOTE" "$USER" "sUser"
#     echoc "INFO" "$PATH" "sPath"
#     echoc "bold" "Application will be terminated! " "sDescription"
#     echoc "BLINK" "Are you sure?" "sSure"
#     # These Above lines never appear on screen.. Only for memory variable assigments..
#     # Lets show total message to user AS a COLORED PARAGRAPH :
#     echo -e "Dear ${sUser}. Path is ${sPath} and you warned: ${sDescription}. Really ${sSure} "
#
function echox () {
local sElement=""
    while [[ $# -gt 0 ]]
    do
    sElement="${1}"
    cFirstOfEl="${sElement:0:1}"

    if [ "${cFirstOfEl,,}" == "x" ]
    then
        shift
        sColor="${sElement:1}"
        echoc "${sColor}" "${1}" "sPaintMe"      # Boyanip sRV olarak geri gelsin
        printf "%s" "${sPaintMe}">&2
        shift
    else                         # Boyanmadan kalsin
        printf "%s " "${1}">&2
             #    ^__ Buradaki bosluk cok onemli !!
        shift
    fi
    done
    echo ""
}



# ex.: echomd "h1" "Baslik 1"           ; echo  "Your h1-> $RETURN  veya $RV"
# ex.: echomd "h1" "Baslik 1" "sHayVan" ; echo  "Your h1-> $RETURN  veya $RV veya $sHayVan"
function echomd ()
{
 local psMD="${1,,}"
 local psString="$2"
 local -n psVarName="${3:-"RV"}"

 local sMD="" sM1="" sM2=""
 local idSp=" "

 case "${psMD}" in
    "h1"|"h2"|"h3"|"h1"|"h2"|"h3")   sM1="<${psMD}>"; sM2="</${psMD}>" ;
            sMD="${sM1} ${idSp}${psString} ${sM2}" ;;
    "h2")   sM1="##";sMD="${sM1}${idSp}${psString}" ;;
    "h3")   sM1="###";sMD="${sM1}${idSp}${psString}" ;;
    "h4")   sM1="####";sMD="${sM1}${idSp}${psString}" ;;
    "h5")   sM1="#####";sMD="${sM1}${idSp}${psString}" ;;
    "h6")   sMD1="#######"
            sMD="${sMD1}${idSp}${psString}"
        ;;
    "blockquote")   sM1=">"     #  <blockquote>  <p>"Alinti.." -Twain</p>  </blockquote>
                    sMD="${sMD1}${psString}"
        ;;
    "u"|"ul"|"link") sM1="[" ; sM2="]"           # [ANCHOR-TEXT](LINK)
            sMD="${sM1}${psString}${sM2}"
        ;;

    "b"|"bold") sM1="**" ; sM2="**"           # **This is bold text**  __This is bold text__
                sMD="${sM1}${psString}${sM2}"
        ;;


    "i"|"italic") sM1="*" ; sM2="*"           # *This is italic text* _This is italic text_
                sMD="${sM1}${psString}${sM2}"
        ;;

    "uml"|"rev"|"rem") sM1="~~" ; sM2="~~"           # ~~Strikethrough~~
                    sMD="${sM1}${psString}${sM2}"
        ;;


    *)  sMD=${psString} ;;
  esac
    #======Opsiyonel olarak girilen 3. parametre'yi ust fonksiyonda kullanilacak bir
  #  variable adi olarak kullanip GDD'ne esitliyor
     if test -z "${!psVarName}"
     then
        printf "%s" "${sMD}">&2
     else               # echoc "red" "Hata Olustu" "sMsgWarn" ise sonuna bir bosluk ekleyerek..
           # ..degilse.. psRV_Object="Ananin Herekesi" atanarak gonderilecek
          # ve sonuna LineFeed eklenmedigi icin, cumle icinde kullanilabilecek
        psVarName="$( printf "%s" "${sMD}" )"
     fi
 RV="${psVarName}"
 RETURN "${RV}"
}


# ex.: echohtml "h1" "Baslik 1"           ; echo  "Your h1-> $RETURN  veya $RV"
# ex.: echohtml "h1" "Baslik 1" "sHayVan" ; echo  "Your h1-> $RETURN  veya $RV veya $sHayVan"
function echohtml ()
{
 local psHTML="${1,,}"
 local psString="$2"
 local -n psVarName="${3:-"RV"}"

 local sHTML="" sTAG1="" sTAG2=""
 local idSp=" "

 case "${psHTML}" in

    "template")
            sHTML=' <html> <meta content="text/html;charset=UTF-8" /> <head>
<link rel="stylesheet" href="/os/fonts/font-awesome.css"><style></style>
<script src="/os/jquery.js"></script> </head>
<body> </body>
</html>'
        ;;

    "start")
            sHTML=' <html> <meta content="text/html;charset=UTF-8" /> <head>
<link rel="stylesheet" href="/os/fonts/font-awesome.css"><style></style>
<script src="/os/jquery.js"></script> </head>
<body>  '
        ;;

    "stop")
            sHTML='  </body>
</html>'
        ;;

    "h1"|"h2"|"h3"|"h1"|"h2"|"h3")   sTAG1="<${psHTML}>"; sTAG2="</${psHTML}>" ;
            sHTML="${sTAG1} ${idSp}${psString} ${sTAG2}"
        ;;
    "blockquote")   #  <blockquote>  <p>"Alinti.." -Twain</p>  </blockquote>
            sTAG1="<blockquote> <p>"  ; sTAG2="</p> </blockquote>"
            sHTML="${sTAG1}${psString}${sTAG2}"
        ;;
                           # [ANCHOR-TEXT](LINK)
    "ins"|"u"|"ul"|"link") sTAG1="<ins>" ; sTAG2="</ins>"
            sHTML="${sTAG1}${psString}${sTAG2}"
        ;;
                       # **This is bold text**  __This is bold text__
    "b"|"bold") sTAG1="<b>*" ; sTAG2="*</b>"
                sHTML="${sTAG1}${psString}${sTAG2}"
        ;;
                        # *This is italic text* _This is italic text_
    "i"|"italic") sTAG1="<i>" ; sTAG2="</i>"
                sHTML="${sTAG1}${psString}${sTAG2}"
        ;;
                       # ~~Ortesi cizgili edited~~
    "del"|"uml"|"rev"|"rem") sTAG1="<del>" ; sTAG2="</del>"
                    sHTML="${sTAG1}${psString}${sTAG2}"
        ;;
                       # fosforlu kalem
    "mark"|"yellow_bg") sTAG1="<mark>" ; sTAG2="<mark>"
                    sHTML="${sTAG1}${psString}${sTAG2}"
        ;;
                        # Subscript text
    "sub"|"sub_text") sTAG1="<sub>" ; sTAG2="</sub>"
                    sHTML="${sTAG1}${psString}${sTAG2}"
        ;;
                        # Subscript text
    "sup"|"sup_text") sTAG1="<sup>" ; sTAG2="</sup>"
                    sHTML="${sTAG1}${psString}${sTAG2}"
        ;;

    *)  sHTML=${psString} ;;
  esac

  #======Opsiyonel olarak girilen 3. parametre'yi ust fonksiyonda kullanilacak bir
  #  variable adi olarak kullanip GDD'ne esitliyor
     if test -z "${!psVarName}"
     then
        printf "%s" "${sHTML}">&2
     else               # echoc "red" "Hata Olustu" "sMsgWarn" ise sonuna bir bosluk ekleyerek..
           # ..degilse.. psRV_Object="Ananin Herekesi" atanarak gonderilecek
          # ve sonuna LineFeed eklenmedigi icin, cumle icinde kullanilabilecek
        psVarName="$( printf "%s" "${sHTML}" )"
     fi
 RV="${psVarName}"
 RETURN "${RV}"
}

# # icine 1 byte bile yazmadan dosya olusturur! TEMPLATE!
function safe_touch() { echo -n>"$1" ;}


# ex.:  print2MD "echoxed.md" "Dear " xh2 "$USER" "!.."  "Path is:" xb $PATH "and you warned:" xblockquote "Application will be terminated!" xi "Really" xlink "Are you sure?"
function print2MD() {
 psFileMD="$1"
 shift
 paARGS=("$@")      # ArrTEST "paARGS"
 local sElement sPaintMe idSP=" "

 if is_exist_file "${psFileMD}"
   then echo -n>"${psFileMD}"       # icine 1 byte bile yazmadan dosya olusturur! TEMPLATE!
 fi

    set -- "${paARGS[@]}"
    while (( $# ))
    do
        sElement="$1"
        cFirstOfEl="${sElement:0:1}"
        if [ "${cFirstOfEl,,}" == "x" ]
        then                    # Boyanmaya hazirlayalim!
            sMDtag="${sElement:1}" # x'e bitisik olan markdown-tag direktifi
            shift
            sNextElement="${paARGS[0]}"
            echomd "${sMDtag}" "${sNextElement}" "sPaintMe"      # Boyanip $sPaintMe olarak geri gelsin
            printf "%s" "${sPaintMe}${idSP}">>"${psFileMD}"
                                  #    ^__ Buradaki bosluk cok onemli !!
            shift
        else                         # Boyanmadan kalsin!
            printf "%s" "${sElement}${idSP}">>"${psFileMD}"
                                  #    ^__ Buradaki bosluk cok onemli !!
            shift
        fi
      shift
    done
    echo ""
}


######function print2HTML() {     test ; }
# ex.:  print2HTML "user.html" "Dear " xh2 "$USER" "!.."  "Path is:" xb $PATH "and you warned:" xblockquote "Application will be terminated!" xi "Really" xlink "Are you sure?"
function print2HTML() {
 psFileHTML="$1"
 shift
 paARGS=("$@")      # ArrTEST "paARGS"
 local sElement sPaintMe idSP=" "

    # Dosya varsa adini degistirt, yoksa icine 1 byte bile yazmadan olustur! TEMPLATE!
    # TODO! Dosya adini parse ederek (safe-ty) AuroRenameFile() tasarla !
 if is_exist_file "${psFileHTML}"
   then read2var "psFileHTML" "${psFileHTML} exist.. Another filename:"
   else echo -n>"${psFileHTML}"
 fi


 while (( ${#paARGS[@]} ))      # TEMPLATE! ARRAY LOOP - SHIFTing
 do
    sElement="${paARGS[0]}"
    echo "sElement: ${paARGS[0]}"

    cFirstOfEl="${sElement:0:1}"
    if [ "${cFirstOfEl,,}" == "x" ]
    then                    # Boyanmaya hazirlayalim!
        sHTMLtag="${sElement:1}" # x'e bitisik olan markdown-tag direktifi

        paARGS=( "${paARGS[@]:1}" )    #shift # String List lerde 1. word'den sonrasini al hesabindan..
        sNextElement="${paARGS[0]}"
        echohtml "${sHTMLtag}" "${sNextElement}" "sPaintMe"      # Boyanip $sPaintMe olarak geri gelsin
        printf "%s" "${sPaintMe}${idSP}">>"${psFileHTML}"
                              #    ^__ Buradaki bosluk cok onemli !!
        #shift
        paARGS=( "${paARGS[@]:1}" )    #shift # String List lerde 1. word'den sonrasini al hesabindan..
    else                         # Boyanmadan kalsin!
        printf "%s" "${sElement}${idSP}">>"${psFileHTML}"
                              #    ^__ Buradaki bosluk cok onemli !!

        paARGS=( "${paARGS[@]:1}" )    #shift # String List lerde 1. word'den sonrasini al hesabindan..
    fi
 done
 echo ""

}

#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
function zen_change_user_dirs_locale ()
{
  local ps_user_dirs_locale="${1:-"${ZEN}/user-dirs.locale.zen"}"

  if isnot_exist_file "${ps_user_dirs_locale}" ; then
         echoc "NOTE" "Generatin ${ps_user_dirs_locale}.."
    e2f "${ps_user_dirs_locale}" "# This file is written by xdg-user-dirs-update"
    e2f "${ps_user_dirs_locale}" "# If you want to change or add directories, just edit the line you are"
    e2f "${ps_user_dirs_locale}" "# interested in. All local changes will be retained on the next run"
    e2f "${ps_user_dirs_locale}" "# Format is XDG_zzz_DIR=$ZENUSER/yyy, where yyy is a shell-escaped"
    e2f "${ps_user_dirs_locale}" "# homedir-relative path, or XDG_zzz_DIR=/yyy, where /yyy is an"
    e2f "${ps_user_dirs_locale}" "# absolute path. No other format is supported."
    e2f "${ps_user_dirs_locale}" "#"
    e2f "${ps_user_dirs_locale}" "XDG_DESKTOP_DIR=\"\${ZENUSER}/Desktop\""
    e2f "${ps_user_dirs_locale}" "XDG_DOWNLOAD_DIR=\"\${ZENUSER}/Downloads\""
    e2f "${ps_user_dirs_locale}" "XDG_TEMPLATES_DIR=\"\${ZENUSER}/Templates\""
    e2f "${ps_user_dirs_locale}" "XDG_PUBLICSHARE_DIR=\"\${ZENUSER}/Public\""
    e2f "${ps_user_dirs_locale}" "XDG_DOCUMENTS_DIR=\"\${ZENUSER}/Documents\""
    e2f "${ps_user_dirs_locale}" "XDG_MUSIC_DIR=\"\${ZENUSER}/Music\""
    e2f "${ps_user_dirs_locale}" "XDG_PICTURES_DIR=\"\${ZENUSER}/Pictures\""
    e2f "${ps_user_dirs_locale}" "XDG_VIDEOS_DIR=\"\${ZENUSER}/Videos\""
 fi
}


#################################
function zen_generate_skeleton () {
###################################
   safe_mkdir "${ZEN}/"{mem,app,media,tmp,os,server,user}
   safe_mkdir "${ZEN}/os/"{run,code,fonts,ico,img,kernel}
   safe_mkdir "${ZEN}/server/"{node,mail,ftp,pkg,web/{www}}
   safe_mkdir "${ZEN}/user/"{.config,.local,.themes,Desktop,Documents,Downloads,Music,Pictures,Public,Templates,Videos}
}


# ex.:   safe_mount
# ex.:   safe_mount "/dev/sda1"
# ex.:   safe_mount "/dev/sda1" "/mnt/my/windows"
function safe_mount()
{
    local psDevDisk="$1"
    local psOPT_MountPoint="$2"
    local nPara="$#" n=0 nArr nLenArr strLineOf strDEVICE="" strFSTYPE="" strMOUNTPOINT=""
            ## Her defasinda root yetkisi istemesin.. diye aslinda $ZEN/ klasoru altina yazmali
    local sPartitionsINFO="$ZEN/MountPartitions.arr"

    if is_exist_file "${sPartitionsINFO}"
      then array_from_file "aPartitionsINFO" "${sPartitionsINFO}"
      else   #     echoc "ALERT" "Writing to ->${sPartitionsINFO}"
           array_from_partitions "aPartitionsINFO"
           array_to_file "aPartitionsINFO" "${sPartitionsINFO}"
    fi
    nLenArr="${#aPartitionsINFO[@]}"     # BOS yada swap yada root partisyon icermez!
                            # arr_show "aPartitionsINFO" " #FUCKIN aPartitionsINFO BOS yada swap yada root partisyon icermez! "
    ## HIC PARAMETRE GIRILMEMISSE, TUM DISKLERI OTOMATIK BAGLASIN
  if is_zero "${nPara}"
  #--------------------
     then
    #--- MOUNT ALL :
            for (( nArr=0; nArr<${nLenArr}; nArr++ ))
            do
                strDEVICE="$( echo "${aPartitionsINFO[$nArr]}" | awk '{print $1}')"     # /dev/mmcblk0p1

                # wait 1 "${strDEVICE}  # TAMAM, swap yada root degil , /proc/mounts icinde esamesi okunuyorsa alalim :"
                get_mount_point "${strDEVICE}" ; MOUNTPOINT="$RETURN"
                # wait 1 "sandvic mi? MOUNTPOINT= $RETURN"

                if [ "${MOUNTPOINT}" ]  #  baglama noktasi BOS DEGILse
                  then  continue        #  already mounted to  $MOUNTPOINT "
                  else  echo "empty MOUNTPOINT is going to auto-mounting.. " ; udisksctl mount -b "${strDEVICE}"       #   otomatik bagla
                fi
            done
      else
     #---- MOUNT with THIS - lets continue
        for (( nArr=0; nArr<${nLenArr}; nArr++ ))
        do
           strLineOf="${aPartitionsINFO[$nArr]}"

            strDEVICE="$( echo "${strLineOf}" | awk '{print $1}')"     # /dev/mmcblk0p1
             strFSTYPE="$( echo "${strLineOf}" | awk '{print $2}')"      # file-system icermiyorsa " "
              strMOUNTPOINT="$( echo "${strLineOf}" | awk '{print $3}')"      # Baglama klasoru yoksa " "

             ## Ancak baglanmasi istenen disk sistemde varsa devam edebiliriz..
             if [[ "${strDEVICE}" = "${psDevDisk}" ]] ; then   #..Aranan kan bulundu

                  # Ama bakalim bu psDevDisk biryerlere bagli mi??
                  MOUNTPOINT="$( get_mount_point "${psDevDisk}" )"
                  if [ "${MOUNTPOINT}"  ]           #  BAGLI!   if isnot_null/EMPTY "${MOUNTPOINT}"
                    then        # MOUNTPOINT BOS DEGIL, bagliymis,
                        # Ama bakalim bizim dayattigimiz yere mi bagli?
                         if isnot_empty_var "${psOPT_MountPoint}" ; then     # baglama yeri belirtilmis
                                # Diskin bagli oldugu yer sakin ola bizim de dayattigimiz yer olmasin?
                                if [[ "${MOUNTPOINT}" = "${psOPT_MountPoint}" ]]
                                  then continue  # E zaten hersey zaten gonlunceymis, ellesme!
                                  else           # cozup yeniden bagla, israrla belirtilmis
                                    echoc "BW" "Lazarus  ${strMOUNTPOINT} forced to [${psOPT_MountPoint}]"
                                    sudo umount "${strMOUNTPOINT}"
                                    safe_mkdir "${psOPT_MountPoint}"
                                    sudo mount "${psDevDisk}" "${psOPT_MountPoint}"
                                fi
                          fi # if isnot_empty_var "${psOPT_MountPoint}"
                  else     # BOS! BAGLANACAK
                       if is_empty_var "${psOPT_MountPoint}"   # baglama yeri gosterilmemis
                        then  # .. o zaman otomatik bagla..
                            udisksctl mount -b "${psDevDisk}">/dev/null
                        else  # Dayattigimiz yere elle baglanacakmis meger
                            safe_mkdir "${psOPT_MountPoint}"
                            sudo mount "${psDevDisk}" "${psOPT_MountPoint}"
                       fi # if is_empty_var
                  fi  # if [ "${strMOUNTPOINT}" ]
               # else echo "# FUCK Boyle bir disk yok sistemde.."
             fi
        done
  fi
}

function zen_generate_memfile () {
  local psZENMEM_FILE="${1:-"${ZEN}/zen.mem"}"
    #==================== safe_mkdir "${ZEN}"

    export sMountPoints="EFI BOOT WINDOWS WIN HOUSE LINUZE"
    declare -a aMountPoints=( ${sMountPoints} )    # array_from_words "aMountPoints" "sMountPoints"
    declare -a aDiskParts

    safe_mount

    #=============== #   DISKLERI HAYIRLISIYLA BAGLADIK MI?! O HALDE BIRRRR DAHA!"
    array_from_partitions "aDiskParts"
    #==========================

    while (( "${#aMountPoints[@]}" ))     #  while true
    do
      clear
      #====== ==="EFI BOOT WINDOWS WIN HOUSE LINUZE   Sectir  -> $sSelMP
      MENU_Array "aMountPoints"  "== Baglanacak PORTu secin ==" "live"
                 sSelMP="${RETURN}"
      #========="/dev/mmcblk0p2 ..." satirlarindan Sectir -> $sSelLine
      MENU_Array "aDiskParts"  "$sSelMP ==> Baglanacak DISK PARTISYONUNU secin ==" "live"
                  sSelLine="${RETURN}"
                # sSelLine ="/dev/mmcblk0p2    ntfs   /media/suse/windows   windows"
                # satirindaki 3. kolondaki bilgiyi once bir DiZiye cevirip,
      array_from_text "aElemFSTAB" "$sSelLine"    # /etc/fstab dosyasina yarasir bir dizi ismi
         sSelPart="${aElemFSTAB[2]}"    #  dizinin 2.elemani ->"/media/suse/windows"

      #==================== ======================
       e2f "${ZENMEM_FILE}" "${sSelMP}=${sSelPart}"
      #==================== ======================
       echoc "PASS" "${sSelMP}=${sSelPart} => ${ZENMEM_FILE} is OKAY.. "
      if isnot_okay "Diğer disklerle Devam edelim mi?" ; then break ; fi

    done

    #=======================
    #source "${ZENMEM_FILE}"     # AGAIN ! NEW GENERATED!
    #=======================
    DIALOG="dialog"
    TEXTEDITOR="geany"
    FILEMANAGER="nemo"
    BROWSER="localbrowser"
    MDTEXTEDITOR="retext"
    MDREMEDITOR="remarkable"

    TMP="\${TMP:-/dev/shm}"
    #### Asagidaki ilk 4 ( Dort ) satir, user-space in temelini olusturacak
    WINHOME="\${WIN}/home"
    WINUSER="\${WINDOWS}/Users/Public"

    ZENHOUSE="\${HOUSE}/zen"          ##  ZEN_YOLU Ayri mount edilmis /HOME-HOUSE icindeki ZEN deposu
    ZENHOME="/home/zen"
    ZEN="${ZENHOUSE}"         ## !! previously export-ed ZEN  veya simply $HOME/zen
    ZENMEMFILE="~/zen.mem"    #MEMFILE="${HOME}/${idMEMFILE}"
    ZENMEMDIR="\${ZEN}/mem"         #MEMDIR="${HOME}/${idMEMDIR}"

    ZENOS="\${ZEN}/os"
    ZENAPP="\${ZEN}/app"
    ZENMEDIA="\${ZEN}/media"
    ZENTEMP="\${ZEN}/tmp"
    ZENSERVER="\${ZEN}/server"
    ZENUSER="\${ZEN}/user/zen"

    ZENRUN="${ZENOS}/run"
    ZENCODE="${ZENOS}/code/sh"
    TEMPFILE="\${ZENTEMP}/tmp"
    TEXTFILE="\${ZENTEMP}/tmp.txt"
    LOGFILE="\${ZENTEMP}/tmp.log"

    MYISO="\${HOUSE}/iso"
    MYDL="\${HOUSE}/dl"
    MYTRASH="\${HOUSE}/trash"

    MYDEB="\${ZENSERVER}/deb"
    MYWEB="\${ZENSERVER}/web"
    MYMAIL="\${MYWEB}/mail"
    MYFTP="\${MYWEB}/ftp"
    MYPKG="\${MYWEB}/pkg"
    MYWWW="\${MYWEB}/www"

    WINWWW="\${WIN}/server/web/www"

    PENHOUSE="/media/${USER}/USB4HOUSE"
    PENHOME="/media/${USER}/USB2WIN"

    #### Asagidaki ilk 4 ( Dort ) satir, user-space in temelini olusturacak
    e2f "${ZENMEM_FILE}" "WINHOME=\${WIN}/home"
    e2f "${ZENMEM_FILE}" "WINUSER=\${WINDOWS}/Users/Public"
    e2f "${ZENMEM_FILE}" "ZENHOUSE=${ZENHOUSE}"
    e2f "${ZENMEM_FILE}" "ZENHOME=${ZENHOME}"
    e2f "${ZENMEM_FILE}" "ZEN=${ZEN}"
    e2f "${ZENMEM_FILE}" "ZENMEMFILE=${ZENMEMFILE}"
    e2f "${ZENMEM_FILE}" "ZENMEMDIR=${ZENMEMDIR}"
    e2f "${ZENMEM_FILE}" "TMP=${TMP}"
    e2f "${ZENMEM_FILE}" "MYISO=${MYISO}"
    e2f "${ZENMEM_FILE}" "MYDL=${MYDL}"
    e2f "${ZENMEM_FILE}" "MYTRASH=${MYTRASH}"
    e2f "${ZENMEM_FILE}" "ZENOS=${ZENOS}"
    e2f "${ZENMEM_FILE}" "ZENRUN=${ZENRUN}"
    e2f "${ZENMEM_FILE}" "ZENCODE=${ZENCODE}"
    e2f "${ZENMEM_FILE}" "ZENAPP=${ZENAPP}"
    e2f "${ZENMEM_FILE}" "ZENSERVER=${ZENSERVER}"
    e2f "${ZENMEM_FILE}" "ZENUSER=${ZENUSER}"
    e2f "${ZENMEM_FILE}" "ZENMEDIA=${ZENMEDIA}"
    e2f "${ZENMEM_FILE}" "ZENTEMP=${ZENTEMP}"
    e2f "${ZENMEM_FILE}" "TEMPFILE=${TEMPFILE}"
    e2f "${ZENMEM_FILE}" "TEXTFILE=${TEXTFILE}"
    e2f "${ZENMEM_FILE}" "LOGFILE=${LOGFILE}"
    e2f "${ZENMEM_FILE}" "MYDEB=${MYDEB}"
    e2f "${ZENMEM_FILE}" "MYWEB=${MYWEB}"
    e2f "${ZENMEM_FILE}" "MYMAIL=${MYMAIL}"
    e2f "${ZENMEM_FILE}" "MYFTP=${MYFTP}"
    e2f "${ZENMEM_FILE}" "MYPKG=${MYPKG}"
    e2f "${ZENMEM_FILE}" "MYWWW=${MYWWW}"
    e2f "${ZENMEM_FILE}" "WINWWW=${WINWWW}"
    e2f "${ZENMEM_FILE}" "PENHOUSE=${PENHOUSE}  # Fill this key manually"
    e2f "${ZENMEM_FILE}" "PENHOME=${PENHOME}    # Fill this key manually"

    e2f "${ZENMEM_FILE}" "DIALOG=${DIALOG}"
    e2f "${ZENMEM_FILE}" "TEXTEDITOR=${TEXTEDITOR}"
    e2f "${ZENMEM_FILE}" "FILEMANAGER=${FILEMANAGER}"
    e2f "${ZENMEM_FILE}" "BROWSER=${BROWSER}"
    e2f "${ZENMEM_FILE}" "MDTEXTEDITOR=${MDTEXTEDITOR}"
    e2f "${ZENMEM_FILE}" "MDREMEDITOR=${MDREMEDITOR}"

} # Bu satirdan sonra artik garantili bir install .cfg dosyasi olan 'zen.mem' var .

################################## MEM dosyasindan REGISTRY TREE olusturur. ###################
### Bir MEM dosyanin butun [SECTION] larinin butun KEY lerini alip,
### dosya ismi olarak belirleyip, o dosyalarin icine VAL degerlerini
### yazdirarak zenMEM folder-agacini hazirlayalim
##############################
function zen_generate_memtree () {
######################################
local sFileMEM="${ZEN}/zen.mem"
local sMemDIR="${ZEN}/mem"

if isnot_exist_file "${sFileMEM}" ; then
   ######## echoc "EXIT" "Please be sure  existence of MEM file is called: ${sFileMEM}"
   return 0
fi
if is_exist_file "${sMemDIR}/ZEN" ; then
   ######## echoc "PASS" "Already exist mem-tree: ${sMemDIR} and mem-var 'ZEN'"
   return 0
fi

    echoc "bw_bg" "Creating MEM-TREE FOLDER ${sMemDIR} and files VIA ${sFileMEM}"
    # Dogrudan Tum Key=Val satirlarinin dizisini getirelim :
    array_from_ini "aKEYVALPAIRs" "${sFileMEM}" "="   #
    #    arr_show "aKEYVALPAIRs"

    nLenPairs="${#aKEYVALPAIRs[@]}"
    if ! [ "${nLenPairs}" -eq 0 ] ; then
        for (( iKeyVal=0 ; iKeyVal<nLenPairs ; iKeyVal++ ))
        do
            sFilteredPairLINE="${aKEYVALPAIRs[$iKeyVal]}"
            sFilteredPair_Key=$(pairKEY "${sFilteredPairLINE}")
            sFilteredPair_Val=$(pairVAL "${sFilteredPairLINE}" )
            #------------------------------------------------
              safe_mkdir "${sMemDIR}"
              sMEMVARFILE="${sMemDIR}/${sFilteredPair_Key}"
              echoc "PASS" "WRITING ${sFilteredPair_Val} TO FILE ${sMEMVARFILE}"
              echo "${sFilteredPair_Val}">"${sMEMVARFILE}"
            #------------------------------------------------
        done
        echoc "SUCCESS" "Successfully created MEM Registry Tree in folder: ${sMemDIR} "
    else
        echoc "FAIL" "Failed create MEM-TREE FOLDER ${sMemDIR} AND FILES for file: ${sFileMEM}"
    fi
}


# Eger eklenmek istene klasor diskte yoksa eklemeden once sorar
# Gonderilen yeni folder in XPATH'de birden fazla kopyasi varsa kopyalari silmekle yetinir
#  Eger XPATH enviromenti icinde zaten varsa, o folder i basa tasimakla yetinir
# if it is already have been added there, moves it to top of XPATHLINE
# Add directory to XPATH,
#     1) if it is already have been added there, moves it to top of XPATHLINE
#     2) if folder really exist
#     3) if directory
function safe_path () {
    local psDIR="${1:-"$PWD"}"       # Parametre girilmemisse bulunulan dizini PATHe ekler.. Lazywork!!
    psDIR="${1%/}"                            # TODO! Check is it really a folder format string?
    local pWHAT2DO="${2:-"ADD"}"

  case "${pWHAT2DO,,}" in

        "add")
            if [[ :$PATH: =~ :$psDIR: ]]; then ok           # DIR is already exist in PATH
              else test -d $psDIR && PATH="$psDIR:$PATH"    # add to path if DIR is exist in disk
            fi
            ;;

        "put2top")
            if [[ :$PATH: =~ :$psDIR: ]]; then
                PATH="${PATH#$psDIR:}"        # remove if at start
                PATH="${PATH%:$psDIR}"        # remove if at end
                PATH="${PATH//:$psDIR:/:}"    # remove if in middle
            fi
            PATH="$psDIR:$PATH"
        ;;

        "rem")
            # JUST removes ONLY ONE in $PATH
            PATH="$(echo $PATH | sed -e "s;\(^\|:\)${psDIR%/}\(:\|\$\);\1\2;g" -e 's;^:\|:$;;g' -e 's;::;:;g')"
         ;;

        "remdup")
            local idSEP=":" idSP=" "
            sPATH="${PATH//${idSEP}/${idSP}}"
            sPATH="$( echo "$sPATH" | xargs -n1 | sort -u | xargs )"
            sPATH="$( str_trim "sPATH" )"     # echo "awked and re-trimmed " ; echo "[$sPATH]"
            PATH="${sPATH//${idSP}/${idSEP}}"    #  echo "PATH dotted again=> " ; echo "[$PATH]"
        ;;

        "-"*| "help" | "?" )  echo "TODO safe-path() HELP()"    ;;

        *)  echo "$PATH"    ;;
    esac
 export PATH
}


function INFOEXPORT() {
local psWHICH="${1,,}"      # .INI dosya icinden istenen keyVAL alinacak
export -p>"/tmp/INFOEXPORT.TEXT"
array_from_file "aINFOEXPORT" "/tmp/INFOEXPORT.TEXT"
arr_replace_all "aINFOEXPORT" "XDG" "FUCKKKKK"
arr_show "aINFOEXPORT" "replace_all"
    # RV=arr_seek() falan filan
 RETURN "${RV}">/dev/null
}

#############################
function zen_generate_info ()
#############################
{
 local sDisksINI="${ZEN}/zen_disks.ini"
 local sDisksINFO="${ZEN}/zen_disks.info"
 local nLenArr=0

    if isnot_exist_file "${sDisksINI}" ; then
        echoc "NOTE" "Generating ${sDisksINI}.."
        #-----------------------------------------------------------------------------------------------
        mapfile -t "aDisksINFO"<<<$(sudo lsblk -o PATH,FSTYPE,MOUNTPOINT,LABEL,UUID,SIZE,FSUSED,FSAVAIL,FSUSE% )
        #-----------------------------------------------------------------------------------------------
        n=0
        nLenArr="${#aDisksINFO[@]}"
        for (( i=0; i<${nLenArr}; i++ ))
        do
                        # lsblk -n -i -o PATH,FSTYPE,MOUNTPOINT,LABEL,UUID,SIZE,FSUSED,FSAVAIL,FSUSE%
            strPATH="$( echo "${aDisksINFO[$i]}" | awk '{print $1 }' )"     # echo "${strDev}"
            strFSTYPE="$( echo "${aDisksINFO[$i]}" | awk '{print $2 }' )"     # echo "${strDev}"
            strMOUNTPOINT="$( echo "${aDisksINFO[$i]}" | awk '{print $3 }' )"     # echo "${strDev}"
            strLABEL="$( echo "${aDisksINFO[$i]}" | awk '{print $4 }' )"     # echo "${strDev}"
            strUUID="$( echo "${aDisksINFO[$i]}" | awk '{print $5 }' )"     # echo "${strDev}"
            strSIZE="$( echo "${aDisksINFO[$i]}" | awk '{print $6 }' )"     # echo "${strDev}"
            strFSUSED="$( echo "${aDisksINFO[$i]}" | awk '{print $7 }' )"     # echo "${strDev}"
            strFSAVAIL="$( echo "${aDisksINFO[$i]}" | awk '{print $8 }' )"     # echo "${strDev}"
            strFSUSEPERCENT="$( echo "${aDisksINFO[$i]}" | awk '{print $9 }' )"     # echo "${strDev}"

            ### ===========  if it has a valid mount-point =======
            if isnot_empty_var "${strMOUNTPOINT}" ; then
                let "n=n+1"

                ### ============ Generates ZEN_DISKS.INI =======
                e2f "${sDisksINI}" "[$n]"
                e2f "${sDisksINI}" "PATH=${strPATH}"
                e2f "${sDisksINI}" "UUID=${strUUID}"
                e2f "${sDisksINI}" "FSTYPE=${strFSTYPE}"
                e2f "${sDisksINI}" "MOUNTPOINT=${strMOUNTPOINT}"
                e2f "${sDisksINI}" "MOUNT_OPTIONS="
                e2f "${sDisksINI}" "LABEL=${strLABEL}"

                ### ============ Generates ZEN_DISKS.INFO =======
                #-----------------------------------------------
                #PATH            FSTYPE   SIZE FSUSED FSAVAIL FSUSE%
                #/dev/mmcblk0p1  vfat     1G 216.4M  805.6M    21%
                #-----------------------------------------------
                local n1Percent=0 n2Percent=0 s1Percent="" s2Percent="" sPercentil=""
                n1Percent="$( first_char "${strFSUSEPERCENT}" )"
                n1Percent="$(($n1Percent))"     ## TEMPLATE!
                n2Percent="$((10-$n1Percent))"
                s1Percent="$( char_replicate "#" ${n1Percent} )"
                s2Percent="$( char_replicate "_" ${n2Percent} )"
                sPercentil="${s1Percent}${s2Percent}"
                local strLine="[$n] ${sPercentil} ${strPATH} ${strMOUNTPOINT} ${strFSTYPE}  ${strSIZE}  ${strFSUSED}  ${strFSAVAIL}  ${strFSUSEPERCENT}"
                e2f "${sDisksINFO}" "${strLine}"

            fi
        done
    fi
}


function zen_gen_PATH() {

   # set PATH so it includes user's private bin if it exists
   safe_path "$HOME/bin"
   safe_path "$HOME/.local/bin"
   safe_path "/usr/sbin"  # artik uygulamalari user a yuklemek moda
   safe_path "${ZEN}"
   safe_path "${ZEN}/os"
   safe_path "${ZEN}/app"

}

#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
function zen_generate_bashrc ()
{
local ps_bashrc="${1:-"${HOME}/.bashrc"}"
if isnot_exist_file "${ps_bashrc}" ; then
         echoc "NOTE" "Generatin ${ps_bashrc}.."

  e2f "${ps_bashrc}" "# ~/.bashrc: executed by bash(1) for non-login shells."
  e2f "${ps_bashrc}" "# 3 different typeshells in bash: login, normal,and interactive shell."
  e2f "${ps_bashrc}" "# Login shells read ~/.profile and interactive shells read ~/.bashrc; "
  e2f "${ps_bashrc}" "# in our interactive setup, /etc/profile sources ~/.bashrc "
  e2f "${ps_bashrc}" "# Thus all settings made here will also take effect in a login shell."
  e2f "${ps_bashrc}" "# NOTE:It is recommended to make language settings in ~/.profile rather than here"
  e2f "${ps_bashrc}" "# Since multilingual X sessions not work if LANG is overridden in every subshell. "
  e2f "${ps_bashrc}" "# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)"
  e2f "${ps_bashrc}" "# See also https://github.com/rcaloras/bash-preexec"
  e2f "${ps_bashrc}" "export PS1=\"\[\e[32m\][\[\e[m\]\[\e[31m\]\u\[\e[m\]\[\e[33m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\]:\[\e[36m\]\w\[\e[m\]\[\e[32m\]]\[\e[m\]\[\e[32;47m\]\\\$\[\e[m\] \""
  e2f "${ps_bashrc}" ""
  e2f "${ps_bashrc}" "[[ \$- != *i* ]] && return"
  e2f "${ps_bashrc}" "    # If not running interactively, dont do anything"
  e2f "${ps_bashrc}" "    # dont put duplicate lines or lines starting with space in the history."
  e2f "${ps_bashrc}" "HISTCONTROL=ignoreboth   # append to the history file, don't overwrite it"
  e2f "${ps_bashrc}" "shopt -s histappend"
  e2f "${ps_bashrc}" "shopt -s histverify    # calling history line via '!n' + ENTER, results edit-command instead of execute.  "
  e2f "${ps_bashrc}" "HISTSIZE=1000"
  e2f "${ps_bashrc}" "HISTFILESIZE=2000"
  e2f "${ps_bashrc}" ""
  e2f "${ps_bashrc}" "# enable bash completion in interactive shells"
  e2f "${ps_bashrc}" "if ! shopt -oq posix; then"
  e2f "${ps_bashrc}" "  if [ -f /usr/share/bash-completion/bash_completion ]; then"
  e2f "${ps_bashrc}" "    source /usr/share/bash-completion/bash_completion"
  e2f "${ps_bashrc}" "  elif [ -f /etc/bash_completion ]; then"
  e2f "${ps_bashrc}" "    source /etc/bash_completion"
  e2f "${ps_bashrc}" "  fi"
  e2f "${ps_bashrc}" "fi"
  e2f "${ps_bashrc}" " "
  e2f "${ps_bashrc}" "if [ -f ~/.bash_aliases ]; then source ~/.bash_aliases; fi"
  e2f "${ps_bashrc}" " "


fi
}


#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
function zen_change_bashrc ()
{
local psfBASHRC="${1:-"${HOME}/.bashrc"}"
local strLastLine="$( file_cat_lastline "${psfBASHRC}" )"
local strAppend="source ~/zen.sh    #--- >%"

    ## .bashrc hic yoksa bir tane sablon olusturalim
    if is_exist_file "${psfBASHRC}" ; then
        zen_generate_bashrc "${psfBASHRC}"
    fi

    ## .bashrc var ama zen-ify edilmemisse satir ekleyelim
    if isnot_equal "${strLastLine}" "${strAppend}" ; then
        if okay "'zen' enviromentals will be added to ${psfBASHRC}. Sure?" ; then
                 echoc "NOTE" "Adding lines  to ${psfBASHRC}.."
          e2f "${psfBASHRC}" " "
          e2f "${psfBASHRC}" "xrandr -o normal"
          e2f "${psfBASHRC}" " "
          e2f "${psfBASHRC}" "############# #    PROMPTUSER Custom Terminal##"
          e2f "${psfBASHRC}" "echo -n \"    _\|/_   \" "
          e2f "${psfBASHRC}" "echo \"  \$(date \"+%A %d %B %Y, %T\") \""
          e2f "${psfBASHRC}" "echo \"    z e n     User=\${USER}  / Distro=$(uname -n) \" "
          e2f "${psfBASHRC}" "echo -n \"     o s      \" "
          e2f "${psfBASHRC}" "free -m | awk 'NR==2{printf \"Memory= %s/%sMB (%.2f%%)\", \$3,\$2,\$3*100/\$2 }'"
          e2f "${psfBASHRC}" "df -h | awk '\$NF==\"/\"{printf \"   Disk Usage= %d/%dGB (%s)\n\", \$3,\$2,\$5}'"
          e2f "${psfBASHRC}" "echo -n \"     /|\      \""
          e2f "${psfBASHRC}" "echo \"Please run 'mount | grep ^/dev/' OR SIMPLY 'd' as an alias\""
          e2f "${psfBASHRC}" "echo \"              See - https://zen~OS/help (Right click, Open Link in Browser)\""
                            # Add $ZEN to System-wide..
          e2f "${psfBASHRC}"   "ZEN=$ZEN"
          e2f "${psfBASHRC}"   "export ZEN"

            zen_gen_PATH    # Add $ZEN path to System-wide PATH works..
          e2f "${psfBASHRC}"   "PATH=$PATH:$ZEN"
          e2f "${psfBASHRC}"   "export PATH"

          e2f "${psfBASHRC}" "alias a='source ~/.bash_aliases'"
          e2f "${psfBASHRC}" "alias za='source ~/zen.alias'"
          e2f "${psfBASHRC}" "${strAppend}"
        fi
    fi
}

#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
function zen_change_bash_aliases ()
{
 local psf_bash_aliases_zen="${1:-"$HOME/zen.alias"}"

    if isnot_exist_file "${psf_bash_aliases_zen}" ; then
            echoc "NOTE" "Generating ${psf_bash_aliases_zen}.."
      e2f "${psf_bash_aliases_zen}" "[[ -f ~/zen.mem ]] &&  source ~/zen.mem || echo  \"~/zen.mem NOT FOUND!!\" "
      e2f "${psf_bash_aliases_zen}" "#######################"
      e2f "${psf_bash_aliases_zen}" "# Some alias to avoid mistakes:"
      e2f "${psf_bash_aliases_zen}" "alias rm='rm -i'"
      e2f "${psf_bash_aliases_zen}" "alias cp='cp -i'"
      e2f "${psf_bash_aliases_zen}" "alias mv='mv -i'"
      e2f "${psf_bash_aliases_zen}" "alias grep='grep --color=auto' # Colorize output (good for log files)"
      e2f "${psf_bash_aliases_zen}" "alias ping='ping -c 5'"
      e2f "${psf_bash_aliases_zen}" "alias lsblk='lsblk -f'"
      e2f "${psf_bash_aliases_zen}" ""
      e2f "${psf_bash_aliases_zen}" "# -F Dizin sonuna slash   -A dizin-dotlari saklayarak gizlileri gosterir"
      e2f "${psf_bash_aliases_zen}" "alias l='ls --color=auto -F \"\$@\"'"
      e2f "${psf_bash_aliases_zen}" "alias ll='ls --color=auto -l -F \"\$@\"'"
      e2f "${psf_bash_aliases_zen}" "alias l.='ls --color=auto -A -F  \"\$@\"'"
      e2f "${psf_bash_aliases_zen}" "alias ll.='ls --color=auto -l -A -F \"\$@\"'"
      e2f "${psf_bash_aliases_zen}" "alias la='ls -d .* --color=auto'    ## Show hidden files ##"
      e2f "${psf_bash_aliases_zen}" "alias dir='ls -S --classify'"
      e2f "${psf_bash_aliases_zen}" "alias ,='cd ..'"
      e2f "${psf_bash_aliases_zen}" "alias c='clear'"
      e2f "${psf_bash_aliases_zen}" "alias d='df -h | grep /dev/ | sort'"
      e2f "${psf_bash_aliases_zen}" "alias h='history'"
      e2f "${psf_bash_aliases_zen}" "alias hh='history | egrep \"\$@\"'"
      #  e2f "${psf_bash_aliases_zen}" "alias i=RESERVE"
      e2f "${psf_bash_aliases_zen}" "alias j='jobs -l'"
      e2f "${psf_bash_aliases_zen}" "alias w='whoami'"
      e2f "${psf_bash_aliases_zen}" "alias p=pwd"
      e2f "${psf_bash_aliases_zen}" ""
      e2f "${psf_bash_aliases_zen}" "alias x='chmod 777 \"\$@\"'"
      e2f "${psf_bash_aliases_zen}" "alias xuser='chown -R -v \$USER:\$USER \"\$@\"'"
      e2f "${psf_bash_aliases_zen}" "alias xzen='chown -R -v zen:zen \"\$@\"'"
      e2f "${psf_bash_aliases_zen}" "alias myip='curl ipinfo.io/ip'"

      e2f "${psf_bash_aliases_zen}" "alias house='cd \$HOUSE; ls -l'"
      e2f "${psf_bash_aliases_zen}" "alias zen='cd \$ZEN; ls -l'"
      e2f "${psf_bash_aliases_zen}" "alias zenhouse='cd \$ZENHOUSE; ls -l'"
      e2f "${psf_bash_aliases_zen}" "alias penhome='cd \$PENHOME; ls -l'"
      e2f "${psf_bash_aliases_zen}" "alias penhouse='cd \$PENHOUSE; ls -l'"
      e2f "${psf_bash_aliases_zen}" "alias penzen='cd \$PENHOUSE/zen; ls -l'"

      e2f "${psf_bash_aliases_zen}" "alias zen='cd \$ZEN; ls -l'"
      e2f "${psf_bash_aliases_zen}" "alias win='cd \$WIN; ls -l'"
      e2f "${psf_bash_aliases_zen}" "alias windows='cd \$WINDOWS; ls -l'"
      e2f "${psf_bash_aliases_zen}" "alias winhome='cd \$WINHOME; ls -l'"
      e2f "${psf_bash_aliases_zen}" "alias winwww='cd \$WINWWW; ls -l'"
      e2f "${psf_bash_aliases_zen}" "alias winuser='cd \$WINUSER ; ls -l'"
      e2f "${psf_bash_aliases_zen}" "alias zenuser='cd \$ZENUSER ; ls -l'"
      e2f "${psf_bash_aliases_zen}" "alias zenapp='cd \$ZENAPP; ls -l'"
      e2f "${psf_bash_aliases_zen}" "alias zenserver='cd \$ZENSERVER; ls -l'"
      e2f "${psf_bash_aliases_zen}" "alias zenos='cd \$ZENOS ; ls -l'"
      e2f "${psf_bash_aliases_zen}" "alias zenrun='cd \$ZENRUN ; ls -l'"
      e2f "${psf_bash_aliases_zen}" "alias zencodesh='cd \$ZENCODE ; ls *.sh'"
      e2f "${psf_bash_aliases_zen}" "alias zenmedia='cd \$ZENMEDIA; ls -l'"
      e2f "${psf_bash_aliases_zen}" "alias zentemp='cd \$ZENTEMP; ls -l'"
      e2f "${psf_bash_aliases_zen}" "alias mytrash='cd \$MYTRASH; ls -l'"
      e2f "${psf_bash_aliases_zen}" "alias myiso='cd \$MYISO ; ls -l'"
      e2f "${psf_bash_aliases_zen}" "alias mydl='cd \$MYDL ; ls -l'"
      e2f "${psf_bash_aliases_zen}" "alias mywww='cd \$MYWWW; ls *.html'"
      e2f "${psf_bash_aliases_zen}" "alias mydeb='cd \$MYDEB ; ls -l *.deb'"
      e2f "${psf_bash_aliases_zen}" "alias mypkg='cd \$MYPKG ; ls -l *.deb'"
      e2f "${psf_bash_aliases_zen}" ""
      e2f "${psf_bash_aliases_zen}" "# Standart system wide navigation"
      e2f "${psf_bash_aliases_zen}" "alias gotmp='cd /tmp'"
      e2f "${psf_bash_aliases_zen}" "alias goboot='cd /boot'"
      e2f "${psf_bash_aliases_zen}" "alias goconfig='cd ~/.config'"
      e2f "${psf_bash_aliases_zen}" "alias golocal='cd ~/.local'"
      e2f "${psf_bash_aliases_zen}" "alias goshare='cd ~/.local/share'"
      e2f "${psf_bash_aliases_zen}" "alias goboot='cd /boot/grub'"
      e2f "${psf_bash_aliases_zen}" "alias gomedia='cd /run/media/\$USER ; ls -l'"
      e2f "${psf_bash_aliases_zen}" "alias goetc='cd /etc'"
      e2f "${psf_bash_aliases_zen}" "alias gowww='cd /var/www/html/'"
      e2f "${psf_bash_aliases_zen}" "alias gopkg='cd /var/cache/apt/archives'"
      e2f "${psf_bash_aliases_zen}" "alias gotemp='cd ~/Templates/ ; ls -l'"
      e2f "${psf_bash_aliases_zen}" "alias godesk='cd ~/Desktop/ ; ls -l'"
      e2f "${psf_bash_aliases_zen}" "alias godoc='cd ~/Documents/ ; ls -l'"
      e2f "${psf_bash_aliases_zen}" "alias godl='cd ~Downloads/ ; ls -l'"
      e2f "${psf_bash_aliases_zen}" "alias zencode='$ZEN/zencode.sh \"\$@\"'"
      e2f "${psf_bash_aliases_zen}" "alias zenweb='$ZEN/zenweb.sh \"\$@\"'"
      e2f "${psf_bash_aliases_zen}" "alias zendeb='$ZEN/zendeb.sh \"\$@\"'"
      e2f "${psf_bash_aliases_zen}" "############################################## PYTHONs"
      e2f "${psf_bash_aliases_zen}" "alias pyve='python3 -m venv ./venv'"
      e2f "${psf_bash_aliases_zen}" "alias pyva='source ./venv/bin/activate'"
      e2f "${psf_bash_aliases_zen}" "alias py666='python -m SimpleHTTPServer 666'"
      e2f "${psf_bash_aliases_zen}" "alias py3666='sudo python3 -m http.server 666'"
      e2f "${psf_bash_aliases_zen}" "alias pypipi='pip install \"\$@\"'"
      e2f "${psf_bash_aliases_zen}" "alias pywebmd='/usr/bin/remarkable \"http://localhost:666/os/index.md\"'"
      e2f "${psf_bash_aliases_zen}" "alias pyeric='eric6_webbrowser \"http://localhost:666/os/index.html\"'"
      e2f "${psf_bash_aliases_zen}" "alias md='echo \"Creating Folder(s).. \" ; mkdir -p \"\$@\"'"
      e2f "${psf_bash_aliases_zen}" "alias mnt='mount |column -t | grep ^/dev/'"
      e2f "${psf_bash_aliases_zen}" "alias unmedia='sudo umount /media/\$USER/*'"
      e2f "${psf_bash_aliases_zen}" "alias za='source ~/zen.alias'"
      e2f "${psf_bash_aliases_zen}" "alias zazen='source ~/zen.sh ; source ~/zen.alias'"
    fi

        # Kullanici sisteminde .bash_aliases dosyasi hic yoksa bizim olusturdugumuzu dafault yapalim
    if isnot_exist_file "~/.bash_aliases"; then
        safe_cp "${psf_bash_aliases_zen}" "~/.bash_aliases"
    fi

}



###################################### MAIN() ##############
###################### zen_source    # Create new one ${ZENMEM} via menu or use source
######################
################################################################################
### ex.:  ~/zen.sh "HELP"  VEYA ex.:  ~/zen.sh "GENERATE"
################################################################################
#############
#_zen_START_="${1,,}"  ############################################################
                #case "${_zen_START_}" in
                 #"menu")
                        #echo "FAKE zen_MENU_MAIN"
                        #if is_exist_file "${ZEN}/zenutil.sh"
                             #then source "${ZEN}/zenutil.sh"
                             #echo "FAKE! zen_util_MENU() "
                        #fi
                    #;;
                 #"generate")
                        #if is_exist_file "${ZEN}/zenutil.sh"
                             #then source "${ZEN}/zenutil.sh"
                             #zen_generate_MENU
                        #fi
                    #;;
                 #"help") echo "USE WITH ->MENU, GEN or call from scripts.." ;;
                #esac
                ###############################################################

######################## function zen_source ()########################{

##### ZENPATH simply must be "$HOUSE/zen" or "$HOME/zen"
        # run-time current dir that zen.sh in .. simdilik bir kenarda dursun, yanginda kullanilmak uzere
ZENPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
        # Eger sistemde $HOUSE daha tanimlanmamissa zen.sh in claistirildigi yer vatan bilinsin
HOUSE="${1:-"${ZENPATH}"}"
        # zen.sh cagrilirken disaridan parametre olarak hangi cografyada calisacagi bildirilmemisse, yukardaki gibi karar verilecek

        # Butun bu hazirliklari bunun icin yapmistik, baslayalim..
        # Bakalim zenHOUSE neresi olacak ve ZENMEMFILE nereden SOURCE edilecek ?? ::
        # Sistem enviromentinde halihazirda $ZEN path'i tanimlanmis ve EXPORT edilmis bile olsa ISE YARAMAYACAK!!
        # Ancak .bashrc icinde tanimlanip export edilirse, konsol oturumu boyunca aktif olacaktir.
        # O yuzden, eger zen.sh parametre olarak ZENPATH gecilmemisse, $HOME icinde zen.mem varsa, basitce hatmedecegiz..
        # Ama tanimlandigi yerde yaratilmamissa, tekvin'i biz baslatacagiz..

        if is_exist_file "${HOME}/zen.mem"
            #=============================
             then ZEN="${HOME}"
             else ZEN="${HOUSE}/zen"              ###
                safe_mkdir "${ZEN}"
                echoc  "ALERT" "New initialized & exported HOUSE ZEN->${ZEN}"

        fi

        #!# ZENMEM_FILE="${ZEN}/zen.mem"
        ZENMEM_FILE="${HOME}/zen.mem"

   # Bu andan itibaren artik zen.sh'in cagrilacagi ZEN yolu ve zen.mem'imiz olan MEMFILE kesin olarak belirlendi..
### Lets continue ..
    #===========================
    if is_exist_file "${ZENMEM_FILE}"
     then
        ##================================================
        echoc  "PASS" "Sourcing ${ZENMEM_FILE}"
        source "${ZENMEM_FILE}"
        ##================================================
     else
        echoc  "ALERT" "Creating ${ZENMEM_FILE} "
        zen_generate_memfile "${ZENMEM_FILE}"
        #echo "----------------------------"
        safe_cat "${ZENMEM_FILE}"
        echoc "EXIT" "#Just created [${ZENMEM_FILE}] # Exiting.. See you later.. "
        echo "'zen'-Install not finished yet. You should kill.me after editing ${ZENMEM_FILE} by hand..">"${ZEN}/kill.me"
        SHUTDOWN "Please carefully edit by hand and re-run $0 again! "
    fi
    #==================== BU SATIRDAN SONRA ARTIK HER DURUMDA BIR zen.mem DOSYAMIZ VAR!! . bakalim kurulumun devami icin
    #                  yol gosterici bir direktif dosya var mi? : Varsa fine-tuning yapalim bitsin bu install isleri..
    if is_exist_file "${ZEN}/kill.me" ; then
        wait 3 "${ZEN}/kill.me dosyasi mevcut.. zen_check_enviroment - fine-tuning yapalim bitsin bu install isleri.."
        ##======================= zen_check_enviroment
          zen_generate_skeleton
          zen_generate_memtree
          zen_change_bash_aliases
          zen_change_bashrc
          zen_change_user_dirs_locale
          safe_mount
          ## zen_gen_PATH
          #  echoc "GRAY_BOLD_BG" "TEST!DELETE!zen_generate_info()"
          zen_generate_info
        ##=======================
        safe_rm "${ZEN}/kill.me"
        if isnot_exist_file "${ZEN}/kill.me" ; then echo "'zen'-Installation is TOTALLY COMPLETED!"; fi
    fi

### export ZEN
### safe_mount
#############################################################
export LANG=C
declare -a _aRV
declare _sRV _nRV RV REG REGFUNC REGVAL MEM
export idSP=" "
##############################################
########################################################## eof MAIN() #########

## ---- %< -----BOF ------------------------------------------------------------------- >% ----


# ONLY FOR DEVELOPER !!
function zzz_TEST_Color_Codes_for_Library() {
  psCategoryNum="${1:-"7"}"
        i=0   ; nArr=100
 for (( i; i<$nArr; i++ ))
    do
      echo -e -n " [$i] \\033[${psCategoryNum};${i}m Testing \\033[0m "
    done

   echo -e "SECILEN  \\033[7;90m TEST \\033[0m"

}

function zzz__TEMPLATE__ () {
    local WHAT="" THE="" FUCK="" TAGS=""

    if [[ ${1:0:1} == "-" ]] ; then         # if start_with "-" "${1}"

        while [[ $# -gt 0 ]]
        do
            case ${1} in
                --what) WHAT="$2"  ; shift ; shift ;;
                --the)  THE="$2"   ; shift ; shift ;;
                --fuck) FUCK="$2"  ; shift ; shift ;;
                --tags) TAGS="$@"  ; shift ; shift ;;
                *)  USAGE ; shift  ;;  # past argument
            esac
        done
    else
        WHAT="$1"; THE="$2"; FUCK="$3"; OPTPARAMS="$4"
    fi
}



## ---- %< ------------------------------------------------------------------EOF ------ >% ----


##### EOF zen.sh ###########################################################
