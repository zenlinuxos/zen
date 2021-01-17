#!/bin/bash
###########  ZEN="/media/cortex/lin4house/zen"
source $ZEN/zen.sh
source $ZEN/zen.mem

function todays () { sDate=$(date +"%A, %B %-d, %Y");  echo "Today's date is:${sDate}"; }

# ex.: git_ekle  "dosya.sh"  "Deneme Amacli Dosya eklendi"

function git_ekle() {
psFILE="$1"
local sDate="$(date +"%A, %B %-d, %Y")"
psCOMMENT="${2:-"Updated ${sDate}"}"

    git add "${psFILE}"
    git commit -m "${psCOMMENT}"
    git push

}

### file_cat_grep "${sf_ProjectINI}" "MYTEMP="
### array_from_inifile "aINIT" "${sf_ProjectINI}"
### arr_seek "aINIT" "GitHub"
#


sUser="zenlinuxos"
sEmail="zenlinuxos@gmail.com"       # PASSWORD == zlo2023zorba
sMyGITProject="http://github.com/${sUser}/${sProNameDir}"
#sGitHubProjectFile="http://github.com/zenlinuxos/zen.git"
sGitHubProjectFile="http://github.com/${sUser}/${sProNameDir}.git"



git_ekle "$@"





exit


  aCommand=( "Info" "Init" "Create" "Add" "remote add githubDepo" "Commit" "Clone" )

    while (( "${#aCommand[@]}" ))     #  while true # Yani aCommand dizisi varoldukca dongu devam etsin
    do
      clear
         MENU_Array  "aCommand" "== Görevleri hatırlat == "
         sAction="${RETURN,,}"
         case "${sAction,,}" in
            "info") safe_cat "${sf_ProjectINI}"
            ;;
            "init") git init
            ;;
            "create")
            ;;
            "add")
            ;;
            "remote add githubDepo")  git remote add githubDepo "${sGitHubProjectFile}"
            ;;
            "clone")  git clone "${sGitHubProject}"
            ;;
            "exit") echoc "EXIT" "Menüden çıkıldı.. " ; break
            ;;
         esac

    done
