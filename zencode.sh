#!/bin/bash

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
[[ -f ~/zen/zen.sh ]] && source ~/zen/zen.sh || source "${ZEN}/zen.sh"
[[ -f ~/zen/zen.mem ]] && source ~/zen/zen.mem || source "${ZEN}/zen.mem"
##################### zen_source

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
echo %~dp0\php.exe -S localhost:666 -t /
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


    if ! [ -e "${sFileName}" ] ; then
        touch "${sFileName}"       # Goruldu stamp i yapistir
        chmod 777 "${sFileName}"   # herkes herseyi yapabilsin
        chmod +x "${sFileName}"    # Script hemen eXecutable stamp i yapistir
            echo "${sTemplate}">"${sFileName}"  # Dump template to full-file
            echo "${sFileName} is created for $TEXTEDITOR" ; sleep 1
    fi

    #============================
     ###TEXTEDITOR="$(xdg-mime  query default text/plain "${sFileName}" )"
    ###  echo "TEXTEDITOR::$TEXTEDITOR" ; sleep 2
    ###"$TEXTEDITOR" "${sFileName}"
    xdg-open "${sFileName}"
    ### ${RUN}/file/textedit "${sFileName}"
}

## -----EOF ------ >%

# FILETYPE=$(xdg-mime query filetype $1)
# APP=$( find /usr/share -type f -name "*.desktop" -printf "%p\n" | rofi -threads 0 -dmenu -i -p "select default app")
# APP=$(basename -- $APP)
# xdg-mime default "$APP" "$FILETYPE"
# echo "$APP set as default application to open $FILETYPE"

code "$1"
