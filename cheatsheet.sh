
#!/bin/bash

# Author: Wangz

# Lib
Dir="${HOME}/.cheeet"
Lib="${HOME}/.cheeet/lib"
THEME="${HOME}/.cheeet/cheatsheet.rasi"


function Detail(){
    option="$1"
    echo "option: $option"
    SHEET="$2"
    LINE1=`awk 'NR==1' $Lib/"$SHEET"`
    t1=`echo $LINE1|cut -d '|' -f 2`
    t2=`echo $LINE1|cut -d '|' -f 3`
    t3=`echo $LINE1|cut -d '|' -f 4`
    t4=`echo $LINE1|cut -d '|' -f 5`
    n2=`echo $option|cut -d '|' -f 3|sed 's/"/\"/g'`
    LINE=`grep -F "$option" $Lib/"$SHEET"`
    echo "LINE: $LINE."
    n1=`echo $LINE|cut -d '|' -f 2|sed 's/"/\\"/g'`
    echo "n1: $n1."
    echo "n2: $n2."
    n3=`echo $LINE|cut -d '|' -f 4|sed 's/"/\\"/g'`
    n4=`echo $LINE|cut -d '|' -f 5|sed 's/"/\\"/g'`
    DETAIL=`echo -e "$t1: $n1\n$t2: $n2\n$t3: $n3\n$t4 $n4"`
    rofi -dmenu -p "Detail"  -config $THEME -mesg "$DETAIL"

}


function Sheet() {
    SHEET="$1"
    message=`awk 'NR==1' $Lib/"$SHEET" |cut -d '|' -f 1,2,3,4 |sed 's/[ ]/=/g'`
    rofiCom="rofi -dmenu\
         -mesg ${message:0:100}\
         -p "CheatSheet"\
         -config $THEME"
    option=`awk 'NR>1' $Lib/"$SHEET" |cut -d '|' -f 1,2,3,4 |$rofiCom`
    
    if [ -n "$option" ]; then
        Detail "$option" $SHEET 
    fi
}

function App() {
    option=`ls -1 $Lib|rofi -dmenu -p "App" -config ~/.cheeet/cheatsheet.rasi`
    if [ -n "$option" ];then
        Sheet $option
    fi
}

function ShowHelp() {
    echo -e "    all -- show all apps/command cheatsheet in one page\n    sgl -- just show apps/commands in the first page   "
}

if [ "$1" == "all" ];then
    cat $Lib/* > $Dir/all
    Lib=$Dir
    Sheet all
elif [ "$1" == "sgl" ];then
    App
else 
    ShowHelp
fi


