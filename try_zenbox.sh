#!/bin/bash
source ~/zen.sh ; source ~/zen.mem
#####################
source zenbox.sh


#Then, you must create a "main" function:
main (){
    #your code here, you can add some windows, text...
    window "title" "color"
    append "Text..."
    endwin
}

#then, you can execute loop:
main_loop 1
