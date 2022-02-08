#!/bin/bash
 E='echo -e';    # -e включить поддержку вывода Escape последовательностей
 e='echo -en';   # -n не выводить перевод строки
 c="+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+"
 trap "R;exit" 2 #
    ESC=$( $e "\e")
   TPUT(){ $e "\e[${1};${2}H" ;}
  CLEAR(){ $e "\ec";}
# 25 возможно это
  CIVIS(){ $e "\e[?25l";}
# это цвет текста списка перед курсором при значении 0 в переменной  UNMARK(){ $e "\e[0m";}
MARK(){ $e "\e[1;45m";}
# 0 это цвет списка
 UNMARK(){ $e "\e[0m";}
  R(){ CLEAR ;stty sane;CLEAR;};                 # в этом варианте фон прозрачный
 HEAD(){ for (( a=2; a<=14; a++ ))
  do
 TPUT $a 1
        $E "\033[1;35m\xE2\x94\x82                                       \xE2\x94\x82\033[0m";
  done
 TPUT 3 3
        $E "\033[1;36m*** ttygif ***\033[0m";
 TPUT 4 3
        $E "\033[90mKонвертировать файл ttyrec в файл gif\033[0m";
 TPUT 5 1
        $E "\033[35m+---------------------------------------+\033[0m";
 TPUT 8 1
        $E "\033[35m+ Опции ----------------- Options ------+\033[0m";
 TPUT 12 1
        $E "\033[35m+ Up \xE2\x86\x91 \xE2\x86\x93 Down Select Enter -------------+\033[0m";
 MARK;TPUT 1 1
        $E "$c";UNMARK;}
   i=0; CLEAR; CIVIS;NULL=/dev/null
# 32 это расстояние сверху и 48 это расстояние слева
   FOOT(){ MARK;TPUT 15 1
        $E "$c";UNMARK;}
# это управляет кнопками ввер/хвниз
 i=0; CLEAR; CIVIS;NULL=/dev/null
#
 ARROW(){ IFS= read -s -n1 key 2>/dev/null >&2
           if [[ $key = $ESC ]];then
              read -s -n1 key 2>/dev/null >&2;
              if [[ $key = \[ ]]; then
                 read -s -n1 key 2>/dev/null >&2;
                 if [[ $key = A ]]; then echo up;fi
                 if [[ $key = B ]];then echo dn;fi
              fi
           fi
           if [[ "$key" == "$($e \\x0A)" ]];then echo enter;fi;}
  M0(){ TPUT  6 3; $e " Установка              \033[32minstall     \033[0m";}
  M1(){ TPUT  7 3; $e " Создать гифку          \033[32mttygif      \033[0m";}
#
  M2(){ TPUT  9 3; $e " Установить скорость    \033[32m-s --speed  \033[0m";}
  M3(){ TPUT 10 3; $e " Показать справку       \033[32m-h --help   \033[0m";}
  M4(){ TPUT 11 3; $e " Показать версию        \033[32m-v --version\033[0m";}
#
  M5(){ TPUT 13 3; $e "\033[32m Exit                               \033[0m";}
LM=5
   MENU(){ for each in $(seq 0 $LM);do M${each};done;}
    POS(){ if [[ $cur == up ]];then ((i--));fi
           if [[ $cur == dn ]];then ((i++));fi
           if [[ $i -lt 0   ]];then i=$LM;fi
           if [[ $i -gt $LM ]];then i=0;fi;}
REFRESH(){ after=$((i+1)); before=$((i-1))
           if [[ $before -lt 0  ]];then before=$LM;fi
           if [[ $after -gt $LM ]];then after=0;fi
           if [[ $j -lt $i      ]];then UNMARK;M$before;else UNMARK;M$after;fi
           if [[ $after -eq 0 ]] || [ $before -eq $LM ];then
           UNMARK; M$before; M$after;fi;j=$i;UNMARK;M$before;M$after;}
   INIT(){ R;HEAD;FOOT;MENU;}
     SC(){ REFRESH;MARK;$S;$b;cur=`ARROW`;}
# Функция возвращения в меню
     ES(){ MARK;$e " ENTER = main menu ";$b;read;INIT;};INIT
  while [[ "$O" != " " ]]; do case $i in
  0) S=M0;SC;if [[ $cur == enter ]];then R;echo "
 установка ttygif
 sudo apt install ttyrec
#
 sudo apt install imagemagick ttyrec gcc x11-apps
 git clone https://github.com/icholy/ttygif.git
 cd ttygif
 make
 sudo make install
";ES;fi;;
  1) S=M1;SC;if [[ $cur == enter ]];then R;echo " ttygif file.tty";ES;fi;;
  2) S=M2;SC;if [[ $cur == enter ]];then R;echo "
 ttygif -s
#
 ttygif --speed
";ES;fi;;
  3) S=M3;SC;if [[ $cur == enter ]];then R;echo "
 ttygif -h
#
 ttygif --help
";ES;fi;;
  4) S=M4;SC;if [[ $cur == enter ]];then R;echo "
 ttygif -v
#
 ttygif --version
";ES;fi;;
#
  5) S=M5;SC;if [[ $cur == enter ]];then R;exit 0;fi;;
 esac;POS;done
