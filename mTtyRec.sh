#!/bin/bash
 E='echo -e';    # -e включить поддержку вывода Escape последовательностей
 e='echo -en';   # -n не выводить перевод строки
 c="+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+"
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
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Эти строки задают цвет фона ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  R(){ CLEAR ;stty sane;CLEAR;};                 # в этом варианте фон прозрачный
 HEAD(){ for (( a=2; a<=21; a++ ))
  do
 TPUT $a 1
        $E "\033[1;35m\xE2\x94\x82                                                            \xE2\x94\x82\033[0m";
  done
 TPUT 3 4
        $E "\033[1;36m*** Ttyrec ***\033[0m";
 TPUT 4 8
        $E "\033[90mtty рекордер\033[0m";
 TPUT 5 1
        $E "\033[35m$c\033[0m";
 TPUT 10 1
        $E "\033[35m+- Опции ------------------------------------- Options ------+\033[0m";
 TPUT 14 1
        $E "\033[35m+- Команды ----------------------------------- Commands -----+\033[0m";
 TPUT 18 1
        $E "\033[35m+- Up \xE2\x86\x91 \xE2\x86\x93 Down Select Enter ---------------------------------+\033[0m";
 MARK;TPUT 1 1
        $E "$c";UNMARK;}
   i=0; CLEAR; CIVIS;NULL=/dev/null
# 32 это расстояние сверху и 48 это расстояние слева
   FOOT(){ MARK;TPUT 21 1
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
  M0(){ TPUT  6 3; $e " Oбзор                                       \033[32mSynopsis    \033[0m";}
  M1(){ TPUT  7 3; $e " Описание                                    \033[32mDescription \033[0m";}
  M2(){ TPUT  8 3; $e " Окружающая среда                            \033[32mEnvironment \033[0m";}
  M3(){ TPUT  9 3; $e " Смотрите также                              \033[32mSee Also    \033[0m";}
#
  M4(){ TPUT 11 3; $e " Добавьте вывод в файл или ttyrecord         \033[32m-a          \033[0m";}
  M5(){ TPUT 12 3; $e " Aвтоматически вызывает uudecode и сохраняет \033[32m-u          \033[0m";}
  M6(){ TPUT 13 3; $e " Вызвать команду при запуске ttyrec          \033[32m-e command  \033[0m";}
#
  M7(){ TPUT 15 3; $e " Запись сеанса в файл                        \033[32mttyrec      \033[0m";}
  M8(){ TPUT 16 3; $e " Oстановить запись                           \033[32mexit        \033[0m";}
  M9(){ TPUT 17 3; $e " Воспроизвести                               \033[32mttyplay     \033[0m";}
#
 M10(){ TPUT 19 3; $e " \033[32mExit                                                    \033[0m";}
LM=10
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
  0) S=M0;SC;if [[ $cur == enter ]];then R;echo " ttyrec [-a] [-u] [-e command] [file]";ES;fi;;
  1) S=M1;SC;if [[ $cur == enter ]];then R;echo "    Ttyrec — это tty-рекордер. Это производная команда script для записи информации о времени с микросекундной точностью. Он может записывать emacs -nw, vi, lynx или
 любые программы, работающие на tty.
    Ttyrec вызывает оболочку и записывает сеанс до выхода из оболочки. Записанные данные можно воспроизвести с помощью ttyplay. Если указан файл аргументов, сеанс
 будет записан в этот файл. В противном случае по умолчанию используется ttyrecord.
    Файл формата tty не содержит какой либо информации об используемой кодировке и размере эмулятора терминала необходимого для воспроизведения файла.";ES;fi;;
  2) S=M2;SC;if [[ $cur == enter ]];then R;echo "    SHELL Если переменная SHELL существует, оболочка, разветвленная ttyrec, будет этой оболочкой. Если он не установлен, предполагается оболочка Bourne.
 (Большинство оболочек устанавливают это переменная автоматически).";ES;fi;;
  3) S=M3;SC;if [[ $cur == enter ]];then R;echo " script, ttyplay, ttytime, uuencode, uudecode";ES;fi;;
  4) S=M4;SC;if [[ $cur == enter ]];then R;echo " Примените выход к файлу или ttyrecord, а не переписать его.";ES;fi;;
  5) S=M5;SC;if [[ $cur == enter ]];then R;echo "     С помощью этой опции ttyrec автоматически вызывает uudecode и сохраняет его вывод, когда закодированные данные появляются в сеансе. Позволит нам передавать
 файлы с удаленного хоста.";ES;fi;;
  6) S=M6;SC;if [[ $cur == enter ]];then R;echo " Вызвать команду при запуске ttyrec.";ES;fi;;
  7) S=M7;SC;if [[ $cur == enter ]];then R;echo " ttyrec -a file.tty";ES;fi;;
  8) S=M8;SC;if [[ $cur == enter ]];then R;echo " Ctrl + D
или
 exit";ES;fi;;
#
  9) S=M9;SC;if [[ $cur == enter ]];then R;echo "
 с помощью ttyplay запускается воспроизведение tty-файла в режиме "реального времени" (есть возможность
 изменения +/- скорости воспроизведения):
 ttyplay file.tty
";ES;fi;;
 10) S=M10;SC;if [[ $cur == enter ]];then R;exit 0;fi;;
 esac;POS;done
