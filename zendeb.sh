#!/usr/bin/env bash
source ~/zen.sh  ; source ~/zen.mem
################################# FUNCTIONs

###### okay alarak processe devam eder okay() {  # ex. if okay "Yapilacak isleme emin misiniz?"
function okay() {
    echo -e -n "\\033[0;1m=== $1 (yY/nN) :\\033[0m"
    read -n1 REPLY
    REPLY=${REPLY,,}    # tolower
    REPLY="${REPLY:-"y"}"
    echo ""
    if [[ "$REPLY" = "y" ]]; then return 0; else return 1; fi
}

# add a dependecy(package) to the masterlist
function DEBDL_add_to_master_list {
    # $1 package name
    # check if a dependency(package) is not present in the masterlist
    presr=$(cat ${masterlist} | grep -ic "$1")

    if [[ ${presr} -eq 0 ]]; then
        echo "$1" >> ${masterlist}
        echo "+ $1 Added to dependency list"
    fi
}


# downloads package and dependencies
function DEBDL_download_packages {
    # $1 - File with packages listed

    # Append the main package to file
    echo "${package}" >> $1
    DEBDL_add_to_master_list ${package}
    # Iterate through the list and download each dependency
    while read -r line
    do
        name="$line"
        echo "[................] Downloading: $name"
        apt-get download "$name" &> /dev/null

        if [[ $? -eq 0 ]]; then
            # Download success
            echo "[+] Downloaded:  $name"
        else
            # Download failed
            echo "[Failed!] Download:$name "
        fi
    done < "$1"
}

# check if a dependency(package) is not present in the masterlist
function DEBDL_is_not_present {
    # $1 package name
    echo $(cat ${masterlist} | grep -ic "$1")
}


# gets dependencies and append them to package list file (deb.list)
function DEBDL_get_dependencies {
    # $1 package name
    p1="$1"
    apt-cache depends ${p1} | grep -v "<" | grep -w "Depends:" > "${p1}_${filename}"

    sed -i -e 's/[<>|:]//g' "${p1}_${filename}"
    sed -i -e 's/Depends//g' "${p1}_${filename}"
    sed -i -e 's/ //g' "${p1}_${filename}"

    # Local count
    lcount=$(apt-cache depends ${p1} | grep -v "<" | grep -icw "Depends:")
    lit=0

    while [ ${lit} -lt ${lcount} ]
    do
        read -r line
        name="$line"
        # Add dependency if not in the master list.
        if [[ $(DEBDL_is_not_present "$name") -eq 0 ]]; then
            DEBDL_add_to_master_list ${name}
            DEBDL_get_dependencies ${name}
        fi
        # lit++
        lit=$(expr ${lit} + 1)
    done < "$1_$filename"
}

# gets dependencies for a package.
function DEBDL_get_global {
    # $1 package name

    echo "[*********] Found $gcount dependencies for: $1 "
    # Store all dependencies to file.
    apt-cache depends $1 | grep -v "<" | grep -w "Depends:" > "$1_$filename"
    # Clean file from unnecessary characters.
    sed -i -e 's/[<>|:]//g' "$1_$filename"
    sed -i -e 's/Depends//g' "$1_$filename"
    sed -i -e 's/ //g' "$1_$filename"

    while [ ${it} -lt ${gcount} ]
    do
        while read -r line
        do
            name="$line"
            round=$(expr ${it} + 1)

            if [[ $( echo ${name} | grep -v "<" | grep -c -w "Depends:") -lt 1 ]]; then
                if [[ $(DEBDL_is_not_present "$name") -eq 0 ]]; then
                    #echo "[-] Adding ${name} to masterlist"
                    DEBDL_add_to_master_list ${name}
                    DEBDL_get_dependencies ${name}
                fi
            fi
            it=$(expr ${it} + 1)
        done < "$1_$filename"
    done
}

DEBDL_USAGE () {
    echo "#"
    echo "# dldeb \?|--help -> This Help Lines:"
    echo "AIM: Search the repos with AppName and downloads AppName.deb file and dependencies from repos ."
    echo "# dldeb --pkg  krusader"
    echo "     You can use with PPA..  ex:  dldeb   --ppa  ppa:danielrichter2007/grub-customizer"
}
### End function declarations


################################# MAIN()
DEBDL () {
    LFN="dldeb()"
    package="$1"

    export LANG=C
        # check for provided arguments
        if [[ $# -lt 1 ]]; then
            echo "[!] No package name provided"
            DEBDL_USAGE
            exit 1
        fi

        if [[ ${1:0:1} == "-" ]] ; then         # XXX # if start_with "-" "${1}" ...  ## if hyphen "${1}" ...
            while [[ $# -gt 0 ]]
            do
                case ${1} in
                    --pkg) package=${2}; shift ; shift ;; # past argument # past value
                    --ppa) ppa=${2}; shift ; shift ;; # past argument # past value
                    -o|--opt)  OPT="${2}"; shift ; shift ;; # past argument # past value  OPTIONAL TAGs STRING
                    \?|--help) DEBDL_USAGE ; exit 1;;
                esac
            done
        else                                                    # XXX # if start_with_traditional $1 $2...
            package="${1,,}" ; ppa="${2}"
        fi

    if ! [[ x"${ppa}" == x ]] ; then        # ppa girilmis !
        pparepo="ppa:${ppa}/$package"
        echo "=================================================="
        echo "==  /etc/apt/source.list dizine eklenen repo:$pparepo"
        echo "=================================================="

        echo "# eger software-properties-common kurulu degilse once bu yapilacak:"
        sudo apt-get install software-properties-common

        sudo apt-add-repository $pparepo
        sudo apt-get update
     fi

    currdir=$(pwd)
    filename="deb.list"
    fname="complete_deb.txt"

    gcount=$(apt-cache depends ${package} | grep -v "<" | grep -icw "Depends:")
    it=0
    masterlist="dependencies_master_$RANDOM.mlist"

    ### Start function declarations
    if [[ ${gcount} -eq 0 ]]; then
        echo "Verify the package name using   apt search    and try again"
        exit
    fi

    # check for internet connectivity
    wget -q --tries=3 --timeout=3 --spider https://www.apple.com
    if [[ $? -ne 0 ]]; then
        # Exit code not 0
        echo "!! No connection, check your internet and try again.."
        exit
    fi


    ### Start main
        echo "=============================="
        echo "==  $currdir  for $package  =="
        echo "=============================="

    #drB!Cancelled create directory with package name
    #drB!Cancelled package_folder="$package"
    #drB!Cancelled mkdir "$package_folder" &> /dev/null

    if [[ $? -eq 0 ]]; then
        #drB!Cancelled echo "[+] Created directory $package_folder"
        #drB!Cancelled cd "$package_folder"

        # create masterlist file
        touch ${masterlist}

        # get dependencies for package and populate masterlist
        DEBDL_get_global "$package"

        # Sort and remove duplicates
            echo "--                                                                     --" >> ${fname}
        sort *.list | uniq > ${fname}

        # read the masterlist to get child dependencies
        echo "[++] Checking for child dependencies"
        while read -r line
        do
            name="$line"
            # check if is package name
            if [[ $( echo ${name} | grep -v "<" | grep -icw "Depends:") -lt 1 ]]; then

                pre=$(cat ${masterlist} | grep -ic "$name")

                if [ ${pre} -eq 0 ]; then
                    DEBDL_get_dependencies ${name}
                    DEBDL_add_to_master_list ${name}
                fi
            fi
            # it++
            it=$(expr ${it} + 1)
        done < "$fname"

        # delete all list files
        rm *.list

        # download packages from masterlist
        DEBDL_download_packages ${masterlist}

        # delete *.deb.list file
        rm ${fname}

        echo "-----------------------------------------------------------------------------"
        echo "-----------------------------------------------------------------------------"
        echo -n "-- Operations completed in :"
        echo $(getSECONDS "en" )
        echo "--Package files downloaded into $currdir     #drB!Cancelled DIR                      "
        echo "-----------------------------------------------------------------------------"
        if okay "Kurmak ister misiniz? : "; then
            #drB!Cancelled  cd "$currdir/$package_folder/"
            sudo apt-get update ;
            sudo gdebi $package
        fi

    else
        echo "!! Failed to create directory $package. "
        echo "Delete existing directory or make sure you have sufficient permissions."
    fi


}
### End main

# ex.: DEBDL "mc" # ex.: DEBDL --pkg "mc"
# ex.: DEBDL "cherrytree" "giuspen"
# ex.: DEBDL --pkg "grub-customizer" --ppa "danielrichter2007"   #  ppa:philip.scott/notes-up
DEBDL "$@"
