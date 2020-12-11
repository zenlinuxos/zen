#!/bin/bash
###########  source lib_from_zen.sh 


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

# ex.: wait 3  "birazdan formatlanacak, bekleyin" veya wait 1
function wait () {
local nSec="$1"
local sMsg="${2:-"please wait.."}"
 echo -e "\\033[0;32m ${sMsg} \\033[0m" ; sleep "${nSec}"
}

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
 echo "${RETURN}" 2>/dev/null
} # xReturned="$(RETURN)" veya xReturned="${RETURN}" veya xReturned="$(cat /tmp/RETURN )"


# ex.: is_number "12Sovalye"
function is_number() {
    local strREGEXP='^[0-9]+$'
    if [[ "$1" =~ ${strREGEXP} ]]
    then return 0
    else return 1
    fi
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


#ex.:  aDiskler=( "sda1" "sda2" "sda3" "sda4" "cdrom" "sdb1" "sdb2" "sdb3")
#ex.:   MENU_Array  "aDiskler" "== Baglanacak diski secin == " +- "live"
function menu_array() { MENU_Array "$@" ; echo "${RETURN}" ; }
function MENU_Array () {
 local -n a_Menu="$1"
 local psTitle_myARRAY_MENU="${2:-"[0] <- EXIT MENU"}"
 local psOPTIONAL="${3:-"static"}"      # OR "live" FOR eNumarated Array 

 local n_LenA="${#a_Menu[@]}"
 if [[ "${n_LenA}" = "0" ]] ; then
    echo "An Error encountered. No menu array exist.. Returning <null>"
    RV="null"
 else
    local strSELECTED=""
    #Dizinin icerigini degistirmeden, sadece basitce 0'dan degil de 1'den baslatarak ekranda goster
    arr_shownum "a_Menu" "$psTitle_myARRAY_MENU"

    echoc "READ" "[0] <- EXIT MENU ->Choose an option:"
    read -n1 REPLY

    if [ "${REPLY}" -eq 0 ] ; then 
        RV="exit" ;  RETURN "${RV}">/dev/null 
        return 0 
    fi 
    
    if [ "${REPLY}" -gt "${n_LenA}" ] ; then 
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

 
 fi
 
 RETURN "${RV}">/dev/null  # SON YAPILAN SECIMIN ICERIGINI $RETURN e RAPTIYELESIN !
} #xRV="${RETURN}"

function DO_Anne_Gorevi() {
    echoc "INFO" "Annenin görevi evi yönetmektir.."
}


function DO_Baba_Gorevi() {
    echoc "INFO" "Babnın görevi finansı sağlamaktır.."
}


function DO_Cocuk_Gorevi() {
    echoc "INFO" "Cocukların görevi kendilerini geliştirmektir.."
}


############ MAIN()
 
  aAile=( "Anne" "Baba" "Cocuk" "Dede" )
 
    while (( "${#aAile[@]}" ))     #  while true # Yani aAile dizisi varoldukca dongu devam etsin
    do
      clear
         MENU_Array  "aAile" "== Görevleri hatırlat == "  
         sGorevHatirlat="${RETURN}" 
         case "${sGorevHatirlat,,}" in
            "anne") DO_Anne_Gorevi 
                    if isnot_okay "Menüyü Kullanmaya Devam edelim mi?" ; then break ; fi
            ;;
            "baba") DO_Baba_Gorevi 
                    if isnot_okay "Menüyü Kullanmaya Devam edelim mi?" ; then break ; fi
            ;;
            "cocuk") DO_Cocuk_Gorevi 
                    if isnot_okay "Menüyü Kullanmaya Devam edelim mi?" ; then break ; fi
            ;;
            "dede") echoc "ARGO" "Hadi lan, ailede dede falan yok.. "
                    if isnot_okay "Menüyü Kullanmaya Devam edelim mi?" ; then break ; fi
            ;;
            "null") echoc "INFO" "Belirlenenlerin dışında birşey seçtin.. "
                    if isnot_okay "Menüyü Kullanmaya Devam edelim mi?" ; then break ; fi
            ;;
            "exit") echoc "EXIT" "Menüden çıkıldı.. " ; break
            ;;
         esac
        
    done
    
 wait 5 "Şimdi aynı fonksiyonu 'live' parametresi ile çalıştıralım.. Azzzz sonra.. "
