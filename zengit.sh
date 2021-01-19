#!/bin/bash
###########
source ~/zen.sh ; source ~/zen.mem
function git_fetch_pull_all_subfolders() {
    # Uncomment if you want the script to always use the scripts
    # directory as the folder to look through
    #REPOSITORIES="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    REPOSITORIES="$(pwd)"

    IFS=$'\n'

    for REPO in `ls "$REPOSITORIES/"`
    do
      if [ -d "$REPOSITORIES/$REPO" ]
      then
        echo "Updating $REPOSITORIES/$REPO at `date`"
        if [ -d "$REPOSITORIES/$REPO/.git" ]
        then
          cd "$REPOSITORIES/$REPO"
          git status
          echo "Fetching"
          git fetch
          echo "Pulling"
          git pull
        else
          echo "Skipping because it doesn't look like it has a .git folder."
        fi
        echo "Done at `date`"
        echo
      fi
    done
}

################


function source_git_mem()
{
     local PROJECT_FOLDER="$(basename "${PWD}")"
     echo "PROJECT_FOLDER::$PROJECT_FOLDER"

    GITMEM_FILE="${PWD}/git.mem"


    #===========================
    if isnot_exist_file "${GITMEM_FILE}" ; then
        echoc  "ALERT" "Creating ${GITMEM_FILE} .."
        #.......................................
        GIT_USER="zenlinuxos"
        GIT_MAIL="zenlinuxos@gmail.com"       #
        GIT_PASSWORD="zlo2023zorba"
        GIT_PROJECT="http://github.com/${GIT_USER}/${PROJECT_FOLDER}"
        GIT_HUBFILE="http://github.com/${GIT_USER}/${PROJECT_FOLDER}.git"
                      #GIT_HUBFILE="http://github.com/zenlinuxos/zen.git"
        #.......................................
        e2f "${GITMEM_FILE}" "PROJECT_FOLDER=${PROJECT_FOLDER}"
        e2f "${GITMEM_FILE}" "GIT_USER=${GIT_USER}"
        e2f "${GITMEM_FILE}" "GIT_PASSWORD=${GIT_PASSWORD}"
        e2f "${GITMEM_FILE}" "GIT_MAIL=${GIT_MAIL}"
        e2f "${GITMEM_FILE}" "GIT_PROJECT=${GIT_PROJECT}"
        e2f "${GITMEM_FILE}" "GIT_HUBFILE=${GIT_HUBFILE}"
    fi
 source "${GITMEM_FILE}"
}

# ex.: git_add  "dosya.sh"  "Deneme Amacli Dosya eklendi"
function git_add()
{
    psFILE="${1:-"README.md"}"
    psCOMMENT="${2:-"Updated ${sDate}"}"

    local NPARAM="$#"
    if is_zero "${NPARAM}" ; then
        echoc "ALERT" "Dosya ismi belirtmemissiniz.."
        return 0
    fi


    if is_exist_file "${psFILE}"; then
          git status
          echo "Fetching"
          git fetch

        if okay "wanna send to cloud?"; then
            echo "Adding and Comitting "
            git add "${psFILE}"
            git commit -m "${psCOMMENT}"
        fi

        if okay "wanna send to cloud?"; then
                    ###echo "Pulling"
                    ##git pull https://username:password@git_hostname.com/my/repository
                    # git pull https://zenlinuxos:zlo2023zorba@github.com/zenlinuxos/zen

            echo "Pushing"
            git push https://${GIT_USER}:${GIT_PASSWORD}@github.com/${GIT_USER}/${PROJECT_FOLDER}



        fi
    else
        echoc "ALERT" "Dosya ismi belirtmemissiniz.."
        return 1
    fi
}

function git_init() {
    git config --global user.name "${GIT_USER}"
    git config --global user.email "${GIT_MAIL}"
    git init
}

function git_clone() {
    echoc "INFO" "..  Cloning ${sGitHubProject} into ${GIT_PROJECT} .."
    git clone "${sGitHubProject}"
}


####### ex.:
clear #############################
        # https://training.github.com/downloads/tr/github-git-cheat-sheet/

source_git_mem
    sDate="$(date +"%A, %B %-d, %Y")"
    psFILE="${1:-"README.md"}"
    psCOMMENT="${2:-"Updated ${sDate}"}"

NPARAM="$#"
#if is_zero "${NPARAM}" ; then

  aCommand=( "Project Folder Information" \
             "Git- Config & Init" \
             "Git- Create" \
             "Git Clone" \
             "Add $psFILE " \
             "Git - remote add githubDepo" \
             "Commit"  )

    while (( "${#aCommand[@]}" ))     #  while true # Yani aCommand dizisi varoldukca dongu devam etsin
    do
      #clear
         MENU_Array "aCommand" "== Görevleri hatırlat == "
         sAction="${REPLY}"
         case "${sAction}" in
            "1") safe_cat "${GITMEM_FILE}" ;;
            "2") git_init   ;;             # "${PROJECT_FOLDER}"
            "3") echo "${sAction}" ;;
            "4") git_clone "${sGitHubProject}" ;;
            "5") git_add "${psFILE}" "${psCOMMENT}" ;;
            "6") git remote add githubDepo "${GIT_HUBFILE}" ;;
            "7") echo "${sAction}" ;;
            "0") echoc "EXIT" "Menüden çıkıldı.. " ; break
            ;;
         esac

    done
#fi
