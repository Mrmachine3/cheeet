
#!/bin/bash

# Author: Wangz

# Lib
Lib="${HOME}/.cheeet/lib"
THEME="${HOME}/.cheeet/cheatsheet.rasi"


function Detail(){
    option="$1"
    SHEET="$2"
    LINE1=`awk 'NR==1' $Lib/"$SHEET"`
    t1=`echo $LINE1|cut -d '|' -f 2`
    t2=`echo $LINE1|cut -d '|' -f 3`
    t3=`echo $LINE1|cut -d '|' -f 4`
    t4=`echo $LINE1|cut -d '|' -f 5`
    LINE=`grep "$option" $Lib/"$SHEET"`
    n1=`echo $LINE|cut -d '|' -f 2`
    n2=`echo $LINE|cut -d '|' -f 3`
    n3=`echo $LINE|cut -d '|' -f 4`
    n4=`echo $LINE|cut -d '|' -f 5`
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

App


