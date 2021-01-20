#! /bin/bash
source ~/zen.sh  ; source ~/zen.mem


usage () {
  cat <<EOF
  $NAME (PHP built-in web server manager) Version 0.2.0
  PHP builtin server manager on port $PORT
  usage: ./$NAME <command> [<hostname>:<port>]
  Available commands:
  start     Starts PHP built-in web server server on specified hostname:port, default is localhost:$PORT
  stop      Stops the PHP built-in web server
  restart   Stops and Starts on previously specified hostname:port
  status    Status of "$NAME" process
  log       Show the PHP built-in web server logs. Use the -f option for a live update
  report bugs to zenlinuxos@gmail.com
  $NAME homepage: <https://github.com/zenlinuxos/php-built-in-server-manager>
EOF
return 0
}

is_valid_php_server ()
{

  echoc "PASS" ".. Validating server in $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ) .. "
  which php &> /dev/null
  if [[ $? -eq 1 ]]; then
    echoc "ERROR" "----> Error: PHP not found. Please install PHP version 5.4 or greater!"
    return 1
  fi

  php -h | grep -q -- '-S'
  if [[ $? -eq 1 ]]; then
    echoc "ERROR" "----> Error:  PHP version must be 5.4 or greater!"
    return 1
  fi

  return 0
}

function check_webroot() {

    if is_empty_var "${WEBROOT}" ; then
        # WIN=/media/cortex/LIN2HOME
        # HOUSE=/media/cortex/lin4house
        # ZEN=${HOUSE}/zen
        ##
        MYWWW=${ZEN}/server/web/www
        ##
        WINWWW=${WIN}/home/server/web/www

          aWebFolders=(
          "System Default - /var/www/html" \
          "Linuze ZenOS- $ZEN" \
          "Windoze Web - $WIN"
          )

             MENU_Array  "aWebFolders" "== Sistemde tanimli Web-yayin-klasorleri == "
             case "${REPLY}" in
                "0") echoc "EXIT" "Menüden çıkıldı.. "   ;;
                "1") WEBROOT="/var/www/html" ;;
                "2") WEBROOT="${ZEN}/server/web/www" ;;
                "3") WEBROOT="${WIN}/home/server/web/www" ;;
                *) echoc "INFO" "Belirlenenlerin dışında birşey seçtin.. "  ;;
             esac
    fi
}

function is_exist_pidfile() {
  if [[ -e "$PIDFILE" ]]; then
    echoc "PASS" "Server seems to be running!"
    echoc "BOLD" "if not, there is probably a zombie $PIDFILE"
    echoc "INFO" "if you are sure no server is running just remove  manually and start again"
        return 0
  else
    echoc "ALERT" "..creating $PIDFILE"
    return 1
  fi

}

start_php_server () {

  if ! is_valid_php_server; then
    return 1
  fi

  if is_exist_pidfile; then
        if okay "Wanna kill this PID and continue to fire up server?" ; then
            rm -f "${PIDFILE}"
        fi
  fi

    echoc "U" "https://www.php.net/manual/en/features.commandline.webserver.php "
    echoc "ALERT" "so PHP applications will stall if a request is blocked."
    echoc "B" "$NAME gonna start on  ${WEBROOT}"
    echo "https://${HOST}:${PORT}"
    php -S "$HOST":"$PORT" -t "${WEBROOT}" >> "$LOGFILE" 2>&1 &
    echo "$HOST":"$PORT":$! > $PIDFILE
    return 0

}

start_python_server () {
  echoc "PASS" ".. Start ${pSERVANT} server in $0  .. Validating .. "
  is_valid_php_server

  if [[ $? -eq 1 ]]; then
    return 1
  fi

  if is_exist_pidfile; then
       return 1
  else
        if [ "${pSERVANT}" = "python" ] ; then
              sudo python -m SimpleHTTPServer "${PORT}" -d "${WEBROOT}"
        fi

         if [ "${pSERVANT}" = "python" ] ; then
              sudo python3 -m http.server "${PORT}" -d "${WEBROOT}"
        fi

        echoc "U" "https://docs.python.org/3/library/http.server.html"
        echo "https://${HOST}:${PORT} for ${WEBROOT}"
        php -S "$HOST":"$PORT" -t "${WEBROOT}" >> "$LOGFILE" 2>&1 &
        echo "$HOST":"$PORT":$! > $PIDFILE
        return 0
  fi
}

read_pidfile() {
    echoc "PASS" "..check for read $PIDFILE" ; sleep 1
  if is_exist_pidfile; then
    PIDFILECONTENT=`cat "$PIDFILE"`
    IFS=: read HOST PORT PID <<< "$PIDFILECONTENT:"
    return 0
  else
    return 1
  fi

}
stop_server () {
  if read_pidfile; then
    kill -9 "$PID"
    rm -f "$PIDFILE"
    echo "$NAME stopped!"
    return 0
  else
    echo "$NAME is not running!"
    return 1
  fi
}

status_server() {
  if read_pidfile && kill -0 "$PID" ; then
    echo "$NAME is running on ${HOST}:${PORT}"
  else
    echo "$NAME is not running!"
  fi
}


log_server() {
  if read_pidfile && kill -0 "$PID" ; then
    if [[ "$1" = "-f" ]]; then
      TAIL_OPTS="-f"
    fi
    tail $TAIL_OPTS "$LOGFILE"
  else
    echo "$NAME is not running!"
  fi
}


### zenweb python3 start 666 $WINWWW
#### ex.: zenweb php|python|python3  start|stop|status|log  666 /var/www
###
clear #################################### zenweb "python3" "start" "666" "${WINWWW}"

function MAIN() {
pSERVANT="${1:-"PHP"}" ; pSERVANT="${pSERVANT,,}"            # lowercase command parameter
pACTION="${2:-"START"}" ; pACTION="${pACTION,,}"            # lowercase command parameter
PORT="${3:-"8080"}"         # default port number
WEBROOT="${4:-"${PWD}"}"            #  ALIAS win|lin|default ? for pre-defined web broadcasting folder/PATH

# script name
NAME="${0##*/}"
NAME="$(echo $(basename ${NAME}) | cut -d'.' -f1)"     # zenweb


# pidfile contents would be hostname:port:pid
PIDFILE="${ZENTEMP}/${NAME}.pid"
LOGFILE="${ZENTEMP}/${NAME}.log"

if [ "${pSERVANT}" = "php" ] ; then
    case "${pACTION}" in
      start)
            #-------------
            check_webroot
            start_php_server;;
            #-------------
      stop)  stop_server;;
      restart) stop_server; check_webroot; start_php_server ;;
      status) status_server;;
      log) log_server $2;;
      -h) usage ;;
      --help) usage ;;
      *) usage;;
    esac
else
    case "${pACTION}" in
      start)  start_python_server  ;;
            #-------------
      stop) echo "STOP -> stop_server" ;;
      restart) echo "RESTART -> stop_server; start_php_server " ;;
      status)  echo "STATUS -> status_server" ;;
      log)  echo "LOG -> log_server $2" ;;
      -h) usage ;;
      --help) usage ;;
      *) usage;;
    esac
fi


if [ "${pSERVANT}" = "python3" ]; then
    case "${pACTION}" in
      start)  sudo python3 -m http.server "${PORT}" -d "${WEBROOT}" ;;
            #-------------
      stop) echo "3STOP -> stop_server" ;;
      restart) echo "3RESTART -> stop_server; start_php_server " ;;
      status)  echo "3STATUS -> status_server" ;;
      log)  echo "LOG -> log_server $2" ;;
      -h) usage ;;
      --help) usage ;;
      *) usage;;
    esac
fi

}

MAIN "$@"

# python3 -m venv ./venv
# source ./venv/bin/activate'
