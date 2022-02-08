#!/bin/bash
 E='echo -e';    # -e включить поддержку вывода Escape последовательностей
 e='echo -en';   # -n не выводить перевод строки
 c="+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+"
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
 HEAD(){ for (( a=2; a<=24; a++ ))
  do
 TPUT $a 1
        $E "\033[1;35m\xE2\x94\x82                                                                                                    \xE2\x94\x82\033[0m";
  done
 TPUT 3 3
        $E "\033[1;36m*** TermRecord ***\033[0m";
 TPUT 4 3
        $E "\033[90mЗапись терминальной сессии в файл HTML\033[0m";
 TPUT 5 1
        $E "\033[35m+----------------------------------------------------------------------------------------------------+\033[0m";
 TPUT 10 1
        $E "\033[35m+ Дополнительные аргументы: --------------------- Optional arguments: -------------------------------+\033[0m";
 TPUT 22 1
        $E "\033[35m+ Up \xE2\x86\x91 \xE2\x86\x93 Down Select Enter --------------------------------------------------------------------------+\033[0m";
 MARK;TPUT 1 1
        $E "$c";UNMARK;}
   i=0; CLEAR; CIVIS;NULL=/dev/null
# 32 это расстояние сверху и 48 это расстояние слева
   FOOT(){ MARK;TPUT 25 1
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
  M0(){ TPUT  6 3; $e " Установка                                      \033[32minstall                                          \033[0m";}
  M1(){ TPUT  7 3; $e " Использование                                  \033[32mUsage                                            \033[0m";}
  M2(){ TPUT  8 3; $e " Запуск                                         \033[32mTermRecord                                       \033[0m";}
  M3(){ TPUT  9 3; $e " Остановка                                      \033[32mexit                                             \033[0m";}
#
  M4(){ TPUT 11 3; $e " Показать справку                               \033[32m-h                 --help                        \033[0m";}
  M5(){ TPUT 12 3; $e " Использовать либо скрипт, либо ttyrec          \033[32m-b {script,ttyrec} --backend {script,ttyrec}     \033[0m";}
  M6(){ TPUT 13 3; $e " Запустить команду и выйти                      \033[32m-c COMMAND         --command COMMAND             \033[0m";}
  M7(){ TPUT 14 3; $e " Pазмеры терминала                              \033[32m-d -h -w           --dimensions -h -w            \033[0m";}
  M8(){ TPUT 15 3; $e " Tолько JSON                                    \033[32m                   --json                        \033[0m";}
  M9(){ TPUT 16 3; $e " Вывести только JavaScript                      \033[32m                   --js                          \033[0m";}
 M10(){ TPUT 17 3; $e " Файл для использования в качестве HTML шаблона \033[32m-m TEMPLATE_FILE   --template-file TEMPLATE_FILE \033[0m";}
 M11(){ TPUT 18 3; $e " Файл для вывода в HTML                         \033[32m-o OUTPUT_FILE     --output-file OUTPUT_FILE     \033[0m";}
 M12(){ TPUT 19 3; $e " Файл скрипта для разбора                       \033[32m-s SCRIPT_FILE     --script-file SCRIPT_FILE     \033[0m";}
 M13(){ TPUT 20 3; $e " Файл синхронизации для разбора                 \033[32m-t TIMING_FILE     --timing-file TIMING_FILE     \033[0m";}
 M14(){ TPUT 21 3; $e " Полный путь к временным файлам                 \033[32m                   --tempfile TEMPFILE           \033[0m";}
#
 M15(){ TPUT 23 3; $e "\033[32m Exit                                                                                            \033[0m";}
LM=15
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
 TermRecord доступен в качестве пакета Python, поэтому вы можете установить его с помощью команды pip.
 Для начала, установите pip на вашу систему Linux. Затем установите TermRecord следующим образом.
 sudo pip install TermRecord
";ES;fi;;
  1) S=M1;SC;if [[ $cur == enter ]];then R;echo "
 TermRecord [-h] [-b {script,ttyrec}] [-c COMMAND] [-d h w] [--json]
            [--js] [-m TEMPLATE_FILE] [-o OUTPUT_FILE] [-s SCRIPT_FILE]
            [-t TIMING_FILE] [--tempfile TEMPFILE]
";ES;fi;;
  2) S=M2;SC;if [[ $cur == enter ]];then R;echo " TermRecord -o session.html";ES;fi;;
  3) S=M3;SC;if [[ $cur == enter ]];then R;echo " Чтобы остановить запись нажмите Ctrl+d или можно набрать exit и нажать ENTER.";ES;fi;;
#
  4) S=M4;SC;if [[ $cur == enter ]];then R;echo "
 TermRecord -h
#
 TermRecord --help
";ES;fi;;
  5) S=M5;SC;if [[ $cur == enter ]];then R;echo " ";ES;fi;;
  6) S=M6;SC;if [[ $cur == enter ]];then R;echo " ";ES;fi;;
  7) S=M7;SC;if [[ $cur == enter ]];then R;echo " ";ES;fi;;
  8) S=M8;SC;if [[ $cur == enter ]];then R;echo " ";ES;fi;;
  9) S=M9;SC;if [[ $cur == enter ]];then R;echo " ";ES;fi;;
 10) S=M10;SC;if [[ $cur == enter ]];then R;echo " ";ES;fi;;
 11) S=M11;SC;if [[ $cur == enter ]];then R;echo " TermRecord -o session.html";ES;fi;;
 12) S=M12;SC;if [[ $cur == enter ]];then R;echo " ";ES;fi;;
 13) S=M13;SC;if [[ $cur == enter ]];then R;echo " ";ES;fi;;
 14) S=M14;SC;if [[ $cur == enter ]];then R;echo " Полный путь к временным файлам (будут добавлены расширения).";ES;fi;;
#
 15) S=M15;SC;if [[ $cur == enter ]];then R;exit 0;fi;;
 esac;POS;done
